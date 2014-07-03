//
//  HistoryViewController.h
//  DogeKeeper
//
//  Created by Andrew on 6/14/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "DogeTransaction.h"

@interface HistoryViewController : UIViewController <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView * transactionList;
}
@end
