//
//  AddWalletViewController.m
//  DogeKeeper
//
//  Created by Andrew on 5/20/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "AddWalletViewController.h"

@interface AddWalletViewController ()

@end

@implementation AddWalletViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(validate)userInfo: nil repeats: YES];
    // Do any additional setup after loading the view.
}
-(void)validate
{
    if([titleField.text isEqualToString:@""] || [addressField.text isEqualToString:@""])
    {
        saveButton.enabled = FALSE;
    }
    else
    {
        saveButton.enabled = TRUE;
    }
}
-(IBAction)saveWallet:(id)sender
{
    [self addWallet:titleField.text withAddress:addressField.text];
    [self dismissViewControllerAnimated:TRUE completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadWallets" object:nil];
    }];
}
-(IBAction)scanQR:(id)sender
{
    if ([BCScannerViewController scannerAvailable]) {
		BCScannerViewController *scanner = [[BCScannerViewController alloc] init];
		scanner.delegate = self;
		scanner.codeTypes = @[ BCScannerQRCode ];
		[self presentViewController:scanner animated:TRUE completion:nil];
    }
}
-(IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
-(void)addWallet:(NSString*)title withAddress:(NSString*)address
{
    DogecoinWallet * wallet = [[DogecoinWallet alloc] init];
    wallet.address = address;
    wallet.title = title;
    NSData * walletData = [NSKeyedArchiver archivedDataWithRootObject:wallet];
    NSMutableArray * wallets = [DogecoinWallet getAllWallets];
    [wallets addObject:walletData];
    [[NSUserDefaults standardUserDefaults] setObject:wallets forKey:@"wallets"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - BCScannerViewControllerDelegate

- (void)scanner:(BCScannerViewController *)scanner codesDidEnterFOV:(NSSet *)codes
{
    [scanner dismissViewControllerAnimated:TRUE completion:nil];
    NSString * code = [[codes allObjects] objectAtIndex:0];
    if([code rangeOfString:@"dogecoin:"].location != NSNotFound)
    {
        code = [code stringByReplacingOccurrencesOfString:@"dogecoin:" withString:@""];
    }
    addressField.text = [code substringToIndex:34];
	NSLog(@"Added: [%@]", codes);
}

//- (void)scanner:(BCScannerViewController *)scanner codesDidUpdate:(NSSet *)codes
//{
//	NSLog(@"Updated: [%lu]", (unsigned long)codes.count);
//}

- (void)scanner:(BCScannerViewController *)scanner codesDidLeaveFOV:(NSSet *)codes
{
	NSLog(@"Deleted: [%@]", codes);
}

- (UIImage *)scannerHUDImage:(BCScannerViewController *)scanner
{
	return [UIImage imageNamed:@"HUD"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
