//
//  SettingsViewController.h
//  DogeKeeper
//
//  Created by Andrew on 5/19/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <UIKit/UIKit.h>
#import "BlockIOHandler.h"
#import "AnnouncementHandler.h"

@interface SettingsViewController : UIViewController <NSObject>
{
    IBOutlet UIButton * unlinkButton;
    IBOutlet UILabel * announcementLabel;
}
@end
