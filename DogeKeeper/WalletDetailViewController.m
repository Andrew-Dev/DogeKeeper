//
//  WalletDetailViewController.m
//  DogeKeeper
//
//  Created by Andrew on 6/14/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-SA 4.0
//

#import "WalletDetailViewController.h"

@interface WalletDetailViewController ()

@end

@implementation WalletDetailViewController
@synthesize walletData;
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
    DogecoinWallet * wallet = [NSKeyedUnarchiver unarchiveObjectWithData:walletData];
    qrView.image = [UIImage mdQRCodeForString:[NSString stringWithFormat:@"dogecoin:%@",wallet.address] size:qrView.bounds.size.width];
    titleLabel.text = wallet.title;
    balanceLabel.text = @"Loading Balance...";
    recievedLabel.text = @"Loading Recieved...";
    addressView.text = wallet.address;
    DogeChainHandler * chain = [[DogeChainHandler alloc] init];
    if(wallet.isApi)
    {
        balanceLabel.hidden = TRUE;
        recievedLabel.hidden = TRUE;
    }
    else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                 (unsigned long)NULL), ^(void) {
            NSString * balance = [chain getDogeBalance:wallet.address];
            NSString * recieved = [chain getDogeRecieved:wallet.address];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(balance != nil && ![balance isEqualToString:@"Error."])
                {
                    balanceLabel.text = [NSString stringWithFormat:@"Balance: %@ DOGE",balance];
                }
                else
                {
                    balanceLabel.text = @"Error retrieving total recieved.";
                }
                if(recieved != nil && ![recieved isEqualToString:@"Error."])
                {
                    recievedLabel.text = [NSString stringWithFormat:@"Total Recieved: %@ DOGE",balance];
                }
                else
                {
                    recievedLabel.text = @"Error retrieving total recieved.";
                }
            });
        });
    }
    // Do any additional setup after loading the view.
}
-(IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
