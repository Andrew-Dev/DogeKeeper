//
//  TransactionDetalViewController.h
//  DogeKeeper
//
//  Created by Andrew on 6/26/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DogeTransaction.h"

@interface TransactionDetalViewController : UIViewController
{
    IBOutlet UITextView * idview;
    IBOutlet UITextView * addressview;
    IBOutlet UILabel * dogelabel;
    IBOutlet UIImageView * donationImg;
    BOOL didSendTransasction;
}

@property NSData * transactionData;
@property BOOL fromSendScreen;

@end
