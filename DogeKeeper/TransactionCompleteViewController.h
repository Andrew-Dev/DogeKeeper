//
//  TransactionCompleteViewController.h
//  DogeKeeper
//
//  Created by Andrew on 5/21/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "DogeTransaction.h"

@interface TransactionCompleteViewController : UIViewController
{
    IBOutlet UITextView * idview;
    IBOutlet UITextView * addressview;
    IBOutlet UILabel * dogelabel;
    IBOutlet UIImageView * donationImg;
    IBOutlet UILabel * feelabel;
}

@property NSData * transactionData;

@end
