//
//  AboutViewController.m
//  DogeKeeper
//
//  Created by Andrew on 6/7/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    // Do any additional setup after loading the view.
}
-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)dogeCoinWebsite:(id)sender
{
    [self openWebURL:@"http://dogecoin.com"];
}
-(IBAction)dogeCoinReddit:(id)sender
{
    [self openWebURL:@"http://reddit.com/r/dogecoin"];
}
-(IBAction)dogeKeeperWebsite:(id)sender
{
    [self openWebURL:@"http://dogekeeper.com"];
}
-(IBAction)dogeKeeperTwitter:(id)sender
{
    [self openWebURL:@"http://twitter.com/DogeKeeper"];
}
-(IBAction)dogeAPI:(id)sender
{
    [self openWebURL:@"http://dogeapi.com"];
}
-(IBAction)dogeChain:(id)sender
{
    [self openWebURL:@"http://dogechain.info"];
}
-(IBAction)bcscanner:(id)sender
{
    [self openWebURL:@"https://github.com/michaelochs/BCScanner"];
}
-(IBAction)qrencoder:(id)sender
{
    [self openWebURL:@"https://github.com/moqod/iOS-QR-Code-Encoder"];
}
-(IBAction)icons8:(id)sender
{
    [self openWebURL:@"http://icons8.com/"];
}
-(void)openWebURL:(NSString*)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
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
