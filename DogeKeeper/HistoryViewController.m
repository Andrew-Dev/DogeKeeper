//
//  HistoryViewController.m
//  DogeKeeper
//
//  Created by Andrew on 6/14/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Transactions Sent With DogeKeeper";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[DogeTransaction getAllTransactions] count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     UILabel * valueLabel = (UILabel*)[cell viewWithTag:2];
     UILabel * dateLabel = (UILabel*)[cell viewWithTag:4];
     UITextView * addressView = (UITextView*)[cell viewWithTag:6];
     NSMutableArray * transactions = [DogeTransaction getAllTransactions];
     transactions = (NSMutableArray*)[[transactions reverseObjectEnumerator] allObjects];
     DogeTransaction * transaction = [NSKeyedUnarchiver unarchiveObjectWithData:[transactions objectAtIndex:indexPath.row]];
     NSNumberFormatter *numformatter = [[NSNumberFormatter alloc] init];
     [numformatter setNumberStyle:NSNumberFormatterDecimalStyle];
     [numformatter setMaximumFractionDigits:4];
     [numformatter setRoundingMode: NSNumberFormatterRoundUp];
     NSString * value = [numformatter stringFromNumber:transaction.amount];
     valueLabel.text = [NSString stringWithFormat:@"%@ DOGE",value];
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"mm/dd/yyyy hh:mm a"];
     dateLabel.text = [formatter stringFromDate:transaction.dateSent];
     addressView.text = [NSString stringWithFormat:@"To: %@",transaction.toAddress];
 
     return cell;
 }
-(IBAction)clearHistory:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Clear History" message:@"Are you sure you want to clear your sent transactions history?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}
-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"transactions"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [transactionList reloadData];
    }
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
