//
//  ExchangeRateViewController.h
//  DogeKeeper
//
//  Created by Andrew on 7/30/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceHandler.h"

@interface ExchangeRateViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIToolbar * keyboardBar;
    IBOutlet UITextField * dogeAmountField;
    IBOutlet UITableView * priceList;
    IBOutlet UINavigationBar * navBar;
    NSArray * prices;
    double amount;
}
@end
