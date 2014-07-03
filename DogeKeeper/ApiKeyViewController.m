//
//  ApiKeyViewController.m
//  DogeKeeper
//
//  Created by Andrew on 5/18/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "ApiKeyViewController.h"

@interface ApiKeyViewController ()

@end

@implementation ApiKeyViewController

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
    [instructionScroll addSubview:instructionView];
    ((UIScrollView *)instructionScroll).contentSize = instructionView.frame.size;
    DogeAPIHandler * api = [[DogeAPIHandler alloc] init];
    if([api checkDogeAPIAccount])
    {
        validLabel.textColor = [UIColor colorWithRed:0.156 green:0.512 blue:0.001 alpha:1.000];
        validLabel.text = @"DogeAPI Key Set";
    }
    keyField.inputAccessoryView = keyboardBar;
}
- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}
-(IBAction)keyboardDone:(id)sender
{
    [keyField resignFirstResponder];
}
-(IBAction)dogeApiRegister:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.dogeapi.com/register"]];
}
-(IBAction)dogeApiSettings:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.dogeapi.com/settings"]];
}
-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SendSuccessNotification" object:nil];
    }];
}
-(IBAction)validateKey:(id)sender
{
    if([keyField.text  isEqual: @""])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid key into the field." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [validateButton setTitle:@"Validating..." forState:UIControlStateNormal];
    doneButton.enabled = FALSE;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        DogeAPIHandler * api = [[DogeAPIHandler alloc] init];
        validateButton.enabled = FALSE;
        __block BOOL isValid;
        isValid = [api validateDogeAPIAccount:keyField.text];
        if(isValid)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [api addDogeAPIAccount:keyField.text];
                validLabel.textColor = [UIColor colorWithRed:0.156 green:0.512 blue:0.001 alpha:1.000];
                validLabel.text = @"DogeAPI Key Set";
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Such Validate" message:@"Your DogeAPI account is properly setup and is ready for use with DogeKeeper!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                NSLog(@"key %@",[api getApiKey]);
            });
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[api getError] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            });
            
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            validateButton.enabled = TRUE;
            doneButton.enabled = TRUE;
            [validateButton setTitle:@"Validate Key and Save" forState:UIControlStateNormal];
        });
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
