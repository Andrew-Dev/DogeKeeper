//
//  DogeViewController.h
//  DogeKeeper
//
//  Created by Andrew on 5/17/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "DogeAPIHandler.h"
#import "DogecoinWallet.h"
#import "WalletDetailViewController.h"

@interface DogeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>
{
    IBOutlet UILabel * balanceLabel;
    IBOutlet UITableView * addressTable;
    IBOutlet UINavigationBar * topBar;
    IBOutlet UIBarButtonItem * sendBtn;
    IBOutlet UIBarButtonItem * histBtn;
    IBOutlet UIView * setupView;
    IBOutlet UIButton * reloadButton;
    IBOutlet UIButton * addressButton;
    NSArray * addresses;
    NSNumber * balance;
    DogecoinWallet * selectedWallet;
    BOOL error;
    
}
@end
