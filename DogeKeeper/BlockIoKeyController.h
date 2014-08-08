//
//  BlockIoKeyController.h
//  DogeKeeper
//
//  Created by Andrew on 7/27/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockIOHandler.h"

@interface BlockIoKeyController : UIViewController
{
    IBOutlet UITextField * keyField;
    IBOutlet UILabel * validLabel;
    IBOutlet UIScrollView * instructionScroll;
    IBOutlet UIView * instructionView;
    IBOutlet UIView * keyboardBar;
    IBOutlet UIButton * validateButton;
    IBOutlet UIBarButtonItem * doneButton;
    IBOutlet UIBarButtonItem * unlinkButton;

}
@end
