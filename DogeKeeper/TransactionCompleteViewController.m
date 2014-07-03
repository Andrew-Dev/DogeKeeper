//
//  TransactionCompleteViewController.m
//  DogeKeeper
//
//  Created by Andrew on 5/21/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "TransactionCompleteViewController.h"

@interface TransactionCompleteViewController ()

@end

@implementation TransactionCompleteViewController
@synthesize transactionData;

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
    transaction.dateSent = [NSDate date];
    idview.text = [NSString stringWithFormat:@"Transaction ID:\n%@",transaction.transactionID];
    addressview.text = transaction.toAddress;
    dogelabel.text = [NSString stringWithFormat:@"%f DOGE",[transaction.amount doubleValue]];
    [DogeTransaction addTransactionToHistory:transaction];
    if([transaction.toAddress isEqual: @"DGszZCQdH4tLxu4wZ1nerAL5c9WtS1vmHp"])
    {
        donationImg.hidden = FALSE;
    }
    // Do any additional setup after loading the view.
}
-(IBAction)done
{
    [[[self presentingViewController] presentingViewController] dismissViewControllerAnimated:TRUE completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SendSuccessNotification" object:nil];
    }];
    //[self dismissViewControllerAnimated:TRUE completion:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    
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
