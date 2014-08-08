//
//  SettingsViewController.m
//  DogeKeeper
//
//  Created by Andrew on 5/19/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)setDogeApi:(id)sender
{
    [self performSegueWithIdentifier:@"apiSegue" sender:sender];
}
-(IBAction)setBlockIO:(id)sender
{
    [self performSegueWithIdentifier:@"blockSegue" sender:sender];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    announcementLabel.hidden = TRUE;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        BOOL hideAnnouncementLabel = FALSE;
        if([AnnouncementHandler isUrgentAnnouncement] && ![AnnouncementHandler readUrgentAnnouncement])
        {
            hideAnnouncementLabel = FALSE;
        }
        else
        {
            hideAnnouncementLabel = TRUE;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            announcementLabel.hidden = hideAnnouncementLabel;
        });
    });
    BlockIOHandler * api = [[BlockIOHandler alloc] init];
    if([api checkAccount])
    {
        unlinkButton.enabled = TRUE;
    }
    else
    {
        unlinkButton.enabled = FALSE;
    }
}
-(IBAction)about:(id)sender
{
    [self performSegueWithIdentifier:@"aboutSegue" sender:nil];
}
<<<<<<< HEAD
-(IBAction)announcements:(id)sender
{
    [self performSegueWithIdentifier:@"announcementSegue" sender:nil];
}
-(IBAction)removeAccount:(id)sender
{
    BlockIOHandler * api = [[BlockIOHandler alloc] init];
    [api removeAccount];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Block.io Key Removed" message:@"Your Block.io Dogecoin Key has been removed from DogeKeeper." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    unlinkButton.enabled = FALSE;
=======
- (IBAction)toggleFee:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:feeSwitch.on forKey:@"addfee"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(IBAction)removeApi:(id)sender
{
    if([api checkDogeAPIAccount])
    {
        NSLog(@"remove");
        [api removeDogeAPIAccount];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"DogeAPI Key Removed" message:@"Your DogeAPI Key has been removed from DogeKeeper." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        unlinkButton.enabled = FALSE;
    }
>>>>>>> FETCH_HEAD
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
