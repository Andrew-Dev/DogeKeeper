//
//  SettingsViewController.m
//  DogeKeeper
//
//  Created by Andrew on 5/19/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-SA 4.0
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
-(IBAction)setApi:(id)sender
{
    [self performSegueWithIdentifier:@"apiSegue" sender:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    api = [[DogeAPIHandler alloc] init];
    if([api checkDogeAPIAccount])
    {
        unlinkButton.enabled = TRUE;
    }
    else
    {
        unlinkButton.enabled = FALSE;
    }
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    if([api checkDogeAPIAccount])
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
