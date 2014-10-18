//
//  WalletListController.m
//  DogeKeeper
//
//  Created by Andrew on 6/9/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "WalletListController.h"

@implementation WalletListController

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
    walletsTotal = [[NSNumber alloc] initWithDouble:0];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [walletListView addSubview:refreshControl];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotif:) name:@"ReloadWallets" object:nil];
    //navBar.topItem.leftBarButtonItem = self.editButtonItem;
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firststart"] != TRUE)
    {
        [self performSegueWithIdentifier:@"IntroSegue" sender:nil];
        NSLog(@"first run");
    }
}
-(void)refresh:(UIRefreshControl *)refControl
{
    [walletListView reloadData];
    [refreshControl endRefreshing];
}
-(void)recieveNotif:(NSNotification*)notification
{
    [walletListView reloadData];
}
-(IBAction)addWalletButton:(id)sender
{
    [self performSegueWithIdentifier:@"addWalletSegue" sender:nil];
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
    return [[DogecoinWallet getAllWallets] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Saved Wallets";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSMutableArray * walletsData = [DogecoinWallet getAllWallets];
    DogecoinWallet * dogeWallet = [NSKeyedUnarchiver unarchiveObjectWithData:[walletsData objectAtIndex:indexPath.row]];
    UILabel * titleLabel = (UILabel*)[cell viewWithTag:5];
    UILabel * addressLabel = (UILabel*)[cell viewWithTag:10];
    UILabel * balanceLabel = (UILabel*)[cell viewWithTag:15];
    titleLabel.text = dogeWallet.title;
    addressLabel.text = dogeWallet.address;
    balanceLabel.text = @"Loading Balance...";
    DogeChainHandler * chain = [[DogeChainHandler alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        NSString * balance = [chain getDogeBalance:dogeWallet.address];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(balance != nil && ![balance isEqualToString:@"Error."])
            {
                balanceLabel.text = [NSString stringWithFormat:@"Ɖ %@",balance];
            }
            else
            {
                balanceLabel.text = @"Error retrieving balance.";
            }
        });
    });
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //row selected
    NSMutableArray * walletsData = [DogecoinWallet getAllWallets];
    walletData = [walletsData objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"walletListDetailSegue" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */


 // Override to support conditional rearranging of the table view.
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

//deletion
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSMutableArray * wallets = [DogecoinWallet getAllWallets];
        [wallets removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:wallets forKey:@"wallets"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([[segue identifier] isEqualToString:@"walletListDetailSegue"])
     {
         WalletDetailViewController * detail = [segue destinationViewController];
         detail.walletData = walletData;
     }
 }

@end
