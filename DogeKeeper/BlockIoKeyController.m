//
//  BlockIoKeyController.m
//  DogeKeeper
//
//  Created by Andrew on 7/27/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import "BlockIoKeyController.h"

@interface BlockIoKeyController ()

@end

@implementation BlockIoKeyController

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
    BlockIOHandler * api = [[BlockIOHandler alloc] init];
    if([api checkAccount])
    {
        validLabel.textColor = [UIColor colorWithRed:0.156 green:0.512 blue:0.001 alpha:1.000];
        validLabel.text = @"Block.io API Key Set";
    }
    keyField.inputAccessoryView = keyboardBar;
}
- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
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
    //NSLog(@"%f",kHeight);
    [self keyboardResize:kHeight];
}
-(void)keyboardResize:(int)height
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [instructionScroll setContentInset:UIEdgeInsetsMake(0, 0, height, 0)];
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification*)notification
{
    if([[[notification userInfo] valueForKey:@"UIKeyboardFrameChangedByUserInteraction"] intValue] == 0)
    {
        [instructionScroll setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
-(IBAction)keyboardDone:(id)sender
{
    [keyField resignFirstResponder];
}
-(IBAction)blockIoReg:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://block.io/users/sign_up"]];
}
-(IBAction)blockIoLogin:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://block.io/users/sign_in"]];
}
-(IBAction)close:(id)sender
{
    BlockIOHandler * api = [[BlockIOHandler alloc] init];
    [self dismissViewControllerAnimated:TRUE completion:^{
        if([api checkAccount])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SendSuccessNotification" object:nil];
        }
    }];
}
-(IBAction)validateKey:(id)sender
{
    if([keyField.text isEqual: @""])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid key into the field." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [validateButton setTitle:@"Validating..." forState:UIControlStateNormal];
    doneButton.enabled = FALSE;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        BlockIOHandler * api = [[BlockIOHandler alloc] init];
        validateButton.enabled = FALSE;
        __block BOOL isValid;
        isValid = [api validateAccount:[keyField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        if(isValid)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [api addAccount:[keyField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                validLabel.textColor = [UIColor colorWithRed:0.156 green:0.512 blue:0.001 alpha:1.000];
                validLabel.text = @"Block.io API Key Set";
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Such Validate" message:@"Your Block.io account is properly setup and is ready for use with DogeKeeper!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
