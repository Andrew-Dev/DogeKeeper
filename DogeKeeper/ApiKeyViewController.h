//
//  ApiKeyViewController.h
//  DogeKeeper
//
//  Created by Andrew on 5/18/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "DogeAPIHandler.h"

@interface ApiKeyViewController : UIViewController
{
    IBOutlet UITextField * keyField;
    IBOutlet UILabel * validLabel;
    IBOutlet UIScrollView * instructionScroll;
    IBOutlet UIView * instructionView;
    IBOutlet UIView * keyboardBar;
    IBOutlet UIButton * validateButton;
    IBOutlet UIBarButtonItem * doneButton;
}
@end
