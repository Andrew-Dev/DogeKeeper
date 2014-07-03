//
//  WalletDetailViewController.h
//  DogeKeeper
//
//  Created by Andrew on 6/14/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "UIImage+MDQRCode.h"
#import "DogecoinWallet.h"
#import "DogeChainHandler.h"

@interface WalletDetailViewController : UIViewController
{
    IBOutlet UIImageView * qrView;
    IBOutlet UILabel * balanceLabel;
    IBOutlet UILabel * recievedLabel;
    IBOutlet UILabel * titleLabel;
    IBOutlet UITextView * addressView;
}
@property NSData * walletData;

@end
