//
//  AnnouncementViewController.m
//  DogeKeeper
//
//  Created by Andrew on 7/29/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import "AnnouncementViewController.h"

@interface AnnouncementViewController ()

@end

@implementation AnnouncementViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: @"http://dogekeeper.com/news.php"] cachePolicy:0 timeoutInterval:20];
    [announcementView loadRequest:request];
    // Do any additional setup after loading the view.
}
-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        if(![AnnouncementHandler readUrgentAnnouncement])
        {
            [AnnouncementHandler markAsRead];
        }
    });
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
