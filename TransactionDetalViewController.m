//
//  TransactionDetalViewController.m
//  DogeKeeper
//
//  Created by Andrew on 6/26/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import "TransactionDetalViewController.h"

@interface TransactionDetalViewController ()

@end

@implementation TransactionDetalViewController
@synthesize transactionData,fromSendScreen;

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
    DogeTransaction * transaction = [NSKeyedUnarchiver unarchiveObjectWithData:transactionData];
    
    // Do any additional setup after loading the view.
}
-(IBAction)done
{
    [[[self presentingViewController] presentingViewController] dismissViewControllerAnimated:TRUE completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SendSuccessNotification" object:nil];
    }];
    //[self dismissViewControllerAnimated:TRUE completion:nil];
}
-(IBAction)actionButton:(id)sender
{
    if(transaction)
    {
        
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
