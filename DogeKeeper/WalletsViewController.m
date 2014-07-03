//
//  WalletsViewController.m
//  DogeKeeper
//
//  Created by Andrew on 5/17/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "WalletsViewController.h"

@interface WalletsViewController ()

@end

@implementation WalletsViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addWallet:(DogecoinWallet*)wallet
{
    NSMutableArray * wallets = [DogecoinWallet getAllWallets];
    NSData * walletData = [NSKeyedArchiver archivedDataWithRootObject:wallet];
    [wallets addObject:walletData];
    [[NSUserDefaults standardUserDefaults] setObject:wallets forKey:@"wallets"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
