//
//  DogeViewController.m
//  DogeKeeper
//
//  Created by Andrew on 5/17/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "DogeViewController.h"

@interface DogeViewController ()

@end

@implementation DogeViewController

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
    BlockIOHandler * api = [[BlockIOHandler alloc] init];
    if([api checkAccount])
    {
        histBtn.enabled = TRUE;
        sendBtn.enabled = TRUE;
        setupView.hidden = TRUE;
        [self preReload];
        [self performSelector:@selector(reload) withObject:nil afterDelay:1];
        [self performSelector:@selector(reloadAddresses) withObject:nil afterDelay:1];
    }
    else
    {
        setupView.hidden = FALSE;
    }
    //[addressTable setContentInset:UIEdgeInsetsMake(0, 0, 49, 0)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotif:) name:@"SendSuccessNotification" object:nil];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadAddresses) forControlEvents:UIControlEventValueChanged];
    [addressTable addSubview:refreshControl];
    // Do any additional setup after loading the view.
}
-(void)recieveNotif:(NSNotification*)notification
{
    if([[notification name] isEqualToString:@"SendSuccessNotification"])
    {
        [self preReload];
        [self reload];
        [self reloadAddresses];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    BlockIOHandler * api = [[BlockIOHandler alloc] init];
    if(![api checkAccount])
    {
        histBtn.enabled = FALSE;
        sendBtn.enabled = FALSE;
        setupView.hidden = FALSE;
    }
    else
    {
        histBtn.enabled = TRUE;
        sendBtn.enabled = TRUE;
        setupView.hidden = TRUE;
    }
}
-(IBAction)refreshButtonPress:(id)sender
{
    [self reload];
}
-(IBAction)history:(id)sender
{
    [self performSegueWithIdentifier:@"historySegue" sender:nil];
}
-(IBAction)addAddressButton:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create New Address" message:[NSString stringWithFormat:@"Enter a label for the address. Leave blank to use a random label."] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 98; //go josh!
    [alert textFieldAtIndex:0].delegate = self;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 98 && buttonIndex == 1){
        [addressButton setTitle:@"Creating Address..." forState:UIControlStateNormal];
        reloadButton.enabled = FALSE;
        addressButton.enabled = FALSE;
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                (unsigned long)NULL), ^(void) {
           UITextField * labelField = [alertView textFieldAtIndex:0];
           BlockIOHandler * api = [[BlockIOHandler alloc] init];
           if([api addNewAddress:labelField.text])
           {
               dispatch_sync(dispatch_get_main_queue(), ^{
                   [self reloadAddresses];
               });
           }
           else
           {
               UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[api getError] delegate:self   cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               dispatch_sync(dispatch_get_main_queue(), ^{
                   [alert show];
               });
            
           }
           dispatch_sync(dispatch_get_main_queue(), ^{
               addressButton.enabled = TRUE;
               reloadButton.enabled = TRUE;
               [addressButton setTitle:@"New Address" forState:UIControlStateNormal];
               topBar.topItem.title = @"Send/Receive";
           });
       });
    }
}
-(void)preReload
{
    [reloadButton setTitle:@"Loading Balance..." forState:UIControlStateNormal];
    balanceLabel.text = @"Loading Balance...";
    reloadButton.enabled = FALSE;
    addressButton.enabled = FALSE;
}
-(void)reload{
    [self preReload];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        BOOL errorShown = FALSE;
        BlockIOHandler * api = [[BlockIOHandler alloc] init];
        balance = [api getBalance];
        if(balance != nil)
        {
            NSNumberFormatter *numformatter = [[NSNumberFormatter alloc] init];
            [numformatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [numformatter setMaximumFractionDigits:8];
            [numformatter setRoundingMode: NSNumberFormatterRoundUp];
            balanceLabel.text = [numformatter stringFromNumber:balance];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[api getError] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [alert show];
            });
            errorShown = TRUE;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            balanceLabel.text = [NSString stringWithFormat:@"Ɖ%f",[balance doubleValue]];
            [reloadButton setTitle:@"Reload Balance" forState:UIControlStateNormal];
            reloadButton.enabled = TRUE;
            addressButton.enabled = TRUE;
        });
    });
    
}
-(void)reloadAddresses
{
    addresses = nil;
    [addressTable reloadData];
    addressButton.enabled = FALSE;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        BlockIOHandler * api = [[BlockIOHandler alloc] init];
        if([api getAllAddresses] != nil)
        {
            addresses = [api getAllAddresses];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [addressTable reloadData];
            });
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[api getError] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [alert show];
            });
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            addressButton.enabled = TRUE;
        });
    });
    [refreshControl endRefreshing];
}
-(IBAction)send:(id)sender
{
    [self performSegueWithIdentifier:@"sendSegue" sender:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [addresses count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([addresses count] < 1)
    {
        return @"Loading addresses...";
    }
    return @"My Block.io Addresses";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel * addressLabel = (UILabel*)[cell viewWithTag:10];
    NSDictionary * addressdata = [addresses objectAtIndex:indexPath.row];
    NSString * address = addressdata[@"address"];
    addressLabel.text = address;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //row selected
    selectedWallet = [[DogecoinWallet alloc] init];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel * addressLabel = (UILabel*)[cell viewWithTag:10];
    selectedWallet.address = addressLabel.text;
    NSDictionary * addressdata = [addresses objectAtIndex:indexPath.row];
    NSString * label = addressdata[@"label"];
    selectedWallet.title = label;
    selectedWallet.isApi = FALSE;
    [self performSegueWithIdentifier:@"walletApiDetailSegue" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     //Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     if([[segue identifier] isEqualToString:@"walletApiDetailSegue"])
     {
         WalletDetailViewController * detail = [segue destinationViewController];
         detail.walletData = [NSKeyedArchiver archivedDataWithRootObject:selectedWallet];
     }
 }


@end
