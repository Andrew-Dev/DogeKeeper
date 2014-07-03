//
//  WalletListController.h
//  DogeKeeper
//
//  Created by Andrew on 6/9/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-SA 4.0
//

#import <UIKit/UIKit.h>
#import "DogecoinWallet.h"
#import "DogeChainHandler.h"
#import "WalletDetailViewController.h"

@interface WalletListController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView * walletListView;
    IBOutlet UINavigationBar * navBar;
    UIRefreshControl * refreshControl;
    NSData * walletData;
}
@end
