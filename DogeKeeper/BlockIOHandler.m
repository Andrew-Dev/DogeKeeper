//
//  BlockIOHandler.m
//  DogeKeeper
//
//  Created by Andrew on 7/26/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "BlockIOHandler.h"

@implementation BlockIOHandler

-(NSString*)makeUrlRequest:(NSURL*)requestURL
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLRequest* request = [NSURLRequest requestWithURL:requestURL cachePolicy:0 timeoutInterval:15];
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* stringFromServer = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return stringFromServer;
}
-(void)addAccount:(NSString *)apikey
{
    [[NSUserDefaults standardUserDefaults] setObject:apikey forKey:@"blockiokey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)removeAccount
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"blockiokey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString*)getApiKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"blockiokey"];
}
-(NSString*)getTransactionID
{
    return txid;
}
-(NSString*)getError
{
    return error;
}
-(double)getNetworkFee
{
    return networkfee;
}
-(BOOL)checkAccount
{
    NSLog(@"block.io key: %@",[self getApiKey]);
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"blockiokey"] != nil)
    {
        NSLog(@"set");
        return TRUE;
    }
    else if([[NSUserDefaults standardUserDefaults] objectForKey:@"blockiokey"] == nil)
    {
        NSLog(@"notset");
        return FALSE;
    }
    return FALSE;
}
-(BOOL)validateAccount:(NSString *)apikey
{
    NSLog(@"validate account method");
    NSURL * request = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://block.io/api/v1/get_balance/?api_key=%@",apikey]];
    NSLog(@"req absolute string: %@",[request path]);
    NSString * response = [self makeUrlRequest:request];
    NSLog(@"response: %@",response);
    NSMutableDictionary * validationdata;
    if(response != nil)
    {
        validationdata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    else
    {
        error = @"Error retrieving data from Block.io server.";
        return FALSE;
    }
    NSDictionary * data = validationdata[@"data"];
    if([validationdata[@"status"] isEqualToString:@"success"])
    {
        if([data[@"network"] isEqualToString:@"DOGE"])
        {
            return TRUE;
        }
        else
        {
            error = @"The network is not DOGE. You must have entered the wrong API key.";
        }
    }
    else if([validationdata[@"status"] isEqualToString:@"fail"])
    {
        error = data[@"error_message"];
        return FALSE;
    }
    error = @"Error retrieving data from Block.io server.";
    return FALSE;
}
-(BOOL)addNewAddress:(NSString *)addressName
{
    NSURL * request = [[NSURL alloc] init];
    if([addressName isEqualToString:@""])
    {
        request = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://block.io/api/v1/get_new_address/?api_key=%@",[self getApiKey]]];
    }
    else
    {
        request = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://block.io/api/v1/get_new_address/?api_key=%@&label=%@",[self getApiKey],addressName]];
    }
    NSString * response = [self makeUrlRequest:request];
    NSMutableDictionary * addressdata;
    if(response != nil)
    {
        addressdata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    else
    {
        error = @"Error retrieving data from Block.io server.";
        return FALSE;
    }
    NSDictionary * data = addressdata[@"data"];
    if([addressdata[@"status"] isEqualToString:@"success"])
    {
        if([data[@"network"] isEqualToString:@"DOGE"])
        {
            return TRUE;
        }
        else
        {
            error = @"The network is not DOGE. You must have entered the wrong API key.";
        }
    }
    else if([addressdata[@"status"] isEqualToString:@"fail"])
    {
        error = data[@"error_message"];
        return FALSE;
    }
    error = @"Error retrieving address data from Block.io server.";
    return FALSE;
}
-(NSNumber*)getBalance
{
    NSURL * request = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://block.io/api/v1/get_balance/?api_key=%@",[self getApiKey]]];
    NSLog(@"getBalance url: %@",[request absoluteString]);
    NSString * response = [self makeUrlRequest:request];
    NSLog(@"response: %@",response);
    NSMutableDictionary * balancedata;
    if(response != nil)
    {
        balancedata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    else
    {
        error = @"Error retrieving data from Block.io server.";
        return FALSE;
    }
    NSDictionary * data = balancedata[@"data"];
    if([balancedata[@"status"] isEqualToString:@"success"])
    {
        if([data[@"network"] isEqualToString:@"DOGE"])
        {
            NSString * balanceAsString = data[@"available_balance"];
            NSNumber * balance = [[NSNumber alloc] initWithDouble:[balanceAsString doubleValue]];
            return balance;
        }
        else
        {
            error = @"The network is not DOGE. You must have entered the wrong API key.";
        }
    }
    else if([balancedata[@"status"] isEqualToString:@"fail"])
    {
        error = data[@"error_message"];
        return nil;
    }
    error = @"Error retrieving balance data from Block.io server.";
    return nil;
}
-(NSArray*)getAllAddresses
{
    NSArray * addresses = [[NSArray alloc] initWithObjects:@"", nil];
    NSURL * request = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://block.io/api/v1/get_my_addresses/?api_key=%@",[self getApiKey]]];
    NSString * response = [self makeUrlRequest:request];
    NSMutableDictionary * addressdata;
    if(response != nil)
    {
        addressdata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    else
    {
        error = @"Error retrieving data from Block.io server.";
        return FALSE;
    }
    NSDictionary * data = addressdata[@"data"];
    if([addressdata[@"status"] isEqualToString:@"success"])
    {
        if([data[@"network"] isEqualToString:@"DOGE"])
        {
            addresses = data[@"addresses"];
            return addresses;
        }
        else
        {
            error = @"The network is not DOGE. You must have entered the wrong API key.";
        }
    }
    else if([addressdata[@"status"] isEqualToString:@"fail"])
    {
        error = data[@"error_message"];
        return nil;
    }
    error = @"Error retrieving address data from Block.io server.";
    return nil;
}
-(BOOL)makeDogeTransaction:(double)amount toAddress:(NSString*)address withPin:(NSString*)pin
{
    NSURL * request = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://block.io//api/v1/withdraw/?api_key=%@&amount=%.8f&payment_address=%@&pin=%@",[self getApiKey],amount,address,pin]];
    NSString * response = [self makeUrlRequest:request];
    NSMutableDictionary * transactiondata;
    if(response != nil)
    {
        transactiondata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    else
    {
        error = @"Error retrieving data from Block.io server.";
        return FALSE;
    }
    NSDictionary * data = transactiondata[@"data"];
    if([transactiondata[@"status"] isEqualToString:@"success"])
    {
        if([data[@"network"] isEqualToString:@"DOGE"])
        {
            //yay
            txid = data[@"txid"];
            networkfee = [data[@"network_fee"] doubleValue];
            NSLog(@"data[network_fee] = %@",data[@"network_fee"]);
            //networkfee = data[@"network_fee"];
            return TRUE;
        }
        else
        {
            error = @"The network is not DOGE. You must have entered the wrong API key.";
            return FALSE;
        }
    }
    else if([transactiondata[@"status"] isEqualToString:@"fail"])
    {
        error = data[@"error_message"];
        return FALSE;
    }
    error = @"Error retrieving transaction data from Block.io server. Please check your Block.io account to check if any transactions have gone through.";
    return FALSE;
}

@end
