//
//  ExchangeRateViewController.m
//  DogeKeeper
//
//  Created by Andrew on 7/30/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import "ExchangeRateViewController.h"

@interface ExchangeRateViewController ()

@end

@implementation ExchangeRateViewController

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
    dogeAmountField.inputAccessoryView = keyboardBar;
    amount = [dogeAmountField.text doubleValue];
    [self reloadPriceData];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear:) name:UIKeyboardWillShowNotification object:nil];
}
-(void)keyboardDidAppear:(NSNotification*)notification
{
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow *window = [[[UIApplication sharedApplication] windows]objectAtIndex:0];
    CGRect keyboardFrameConverted = [self.view convertRect:keyboardFrame fromView:window];
    int kHeight = keyboardFrameConverted.size.height;
    [self keyboardResize:kHeight];
}
-(void)keyboardResize:(int)height
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [priceList setContentInset:UIEdgeInsetsMake(0, 0, height, 0)];
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification*)notification
{
    if([[[notification userInfo] valueForKey:@"UIKeyboardFrameChangedByUserInteraction"] intValue] == 0)
    {
        [priceList setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
-(BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}
-(IBAction)keyboardDone:(id)sender
{
    [dogeAmountField resignFirstResponder];
}
-(void)reloadPriceData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            navBar.topItem.title = @"Loading Prices...";
        });
        prices = [PriceHandler getPricesFromSoChain];
        if(prices == nil)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not get price data from SoChain." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            navBar.topItem.title = @"Exchange Rates";
            [priceList reloadData];
        });
    });
}
-(IBAction)amountFieldChanged:(id)sender
{
    NSLog(@"changed");
    amount = [dogeAmountField.text doubleValue];
    [priceList reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)refreshButton:(id)sender
{
    [self reloadPriceData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [prices count];
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"SoChain Price Data";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel * priceLabel = (UILabel*)[cell viewWithTag:25];
    UILabel * exchangeLabel = (UILabel*)[cell viewWithTag:50];
    NSDictionary * data = [prices objectAtIndex:indexPath.row];
    NSString * priceString = data[@"price"];
    NSString * currency = data[@"price_base"];
    NSString * exchange = data[@"exchange"];
    priceLabel.text = [NSString stringWithFormat:@"%.4f %@",[priceString doubleValue]*amount,currency];
    exchangeLabel.text = [NSString stringWithFormat:@"%@",[exchange capitalizedString]];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
