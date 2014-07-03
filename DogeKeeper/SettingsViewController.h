//
//  SettingsViewController.h
//  DogeKeeper
//
//  Created by Andrew on 5/19/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "DogeAPIHandler.h"

@interface SettingsViewController : UIViewController
{
    DogeAPIHandler * api;
    IBOutlet UIButton * unlinkButton;
}
@end
