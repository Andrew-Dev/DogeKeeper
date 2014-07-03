//
//  AddWalletViewController.h
//  DogeKeeper
//
//  Created by Andrew on 5/20/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "DogecoinWallet.h"
#import "BCScannerViewController.h"

@interface AddWalletViewController : UIViewController <BCScannerViewControllerDelegate>
{
    IBOutlet UITextField * titleField;
    IBOutlet UITextField * addressField;
    IBOutlet UIBarButtonItem * saveButton;
}
@end