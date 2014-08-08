//
//  SendViewController.h
//  DogeKeeper
//
//  Created by Andrew on 5/17/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "BlockIOHandler.h"
#import "DogeTransaction.h"
#import "TransactionCompleteViewController.h"
#import "BCScannerViewController.h"

@interface SendViewController : UIViewController <BCScannerViewControllerDelegate>
{
    IBOutlet UIScrollView * sendScroll;
    IBOutlet UIView * sendView;
    IBOutlet UITextField * addressField;
    IBOutlet UITextField * amountField;
    IBOutlet UITextField * pinField;
    IBOutlet UILabel * feeLabel;
    IBOutlet UIToolbar * keyboardBar;
    IBOutlet UIBarButtonItem * sendBtn;
    NSData * transactionData;
}
@end
