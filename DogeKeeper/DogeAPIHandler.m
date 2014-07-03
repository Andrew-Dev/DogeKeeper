//
//  DogeAPIHandler.m
//  DogeKeeper
//
//  Created by Andrew on 5/16/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "DogeAPIHandler.h"

@implementation DogeAPIHandler

-(void)addDogeAPIAccount:(NSString*)apikey
{
    [[NSUserDefaults standardUserDefaults] setObject:apikey forKey:@"dogeapikey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)removeDogeAPIAccount
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"dogeapikey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)checkDogeAPIAccount
{
    NSLog(@"key: %@",[self getApiKey]);
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"dogeapikey"] != nil)
    {
        NSLog(@"set");
        return TRUE;
    }
    else if([[NSUserDefaults standardUserDefaults] objectForKey:@"dogeapikey"] == nil)
    {
        NSLog(@"notset");
        return FALSE;
    }
    return  FALSE;
}
-(NSString*)makeUrlRequest:(NSURL*)requestURL
{
    NSURLRequest* request = [NSURLRequest requestWithURL:requestURL cachePolicy:0 timeoutInterval:120];
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* stringFromServer = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return stringFromServer;
}
-(BOOL)validateDogeAPIAccount:(NSString*)apikey
{
    NSURL * dogeApiRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.dogeapi.com/wow/v2/?api_key=%@&a=get_balance",apikey]];
    NSString * response = [self makeUrlRequest:dogeApiRequest];
    //NSString * response = [NSString stringWithContentsOfURL:dogeApiRequest encoding:NSUTF8StringEncoding error:nil];
    NSMutableDictionary * validationdata;
    if(response != nil)
    {
        validationdata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    else
    {
        error = @"Error retrieving data from DogeAPI server.";
        return FALSE;
    }
    if(validationdata[@"error"] != nil)
    {
        error = validationdata[@"error"];
        if([error isEqual:@"Unauthorized Shibe"])
        {
            error = @"Unauthorized Shibe. You need to enable DogeAPI v2 in your DogeAPI settings.";
        }
        return FALSE;
    }
    else if(validationdata[@"data"] != nil)
    {
        return TRUE;
    }
    else
    {
        error = @"There was an error processing this request. Please try again later.";
    }
    return FALSE;
}
-(BOOL)addNewAddress
{
    ///wow/v2/?api_key={API_KEY}&a=get_new_address&address_label={ADDRESS_LABEL}
    NSURL * dogeApiRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.dogeapi.com/wow/v2/?api_key=%@&a=get_balance",[self getApiKey]]];
    NSString * response = [self makeUrlRequest:dogeApiRequest];
    //NSString * response = [NSString stringWithContentsOfURL:dogeApiRequest encoding:NSUTF8StringEncoding error:nil];
    if(response == nil || [response  isEqual: @""])
    {
        error = @"No data recieved from DogeAPI server.  DogeAPI may be having issues, or you may be experiencing connection problems. Please try again later.";
        return FALSE;
    }
    NSMutableDictionary * addressdata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    if(addressdata[@"error"] != nil)
    {
        error = addressdata[@"error"];
        if([error isEqual:@"Unauthorized Shibe"])
        {
            error = @"Unauthorized Shibe. You need to enable DogeAPI v2 in your DogeAPI settings.";
        }
        return FALSE;
    }
    else if(addressdata[@"data"] != nil)
    {
        return TRUE;
    }
    else
    {
        error = @"There was an error processing this request. Please try again later.";
    }
    return FALSE;
}
-(NSNumber*)getDogeAPIBalance
{
    NSURL * dogeApiRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.dogeapi.com/wow/v2/?api_key=%@&a=get_balance",[self getApiKey]]];
    NSString * response = [self makeUrlRequest:dogeApiRequest];
    //NSString * response = [NSString stringWithContentsOfURL:dogeApiRequest encoding:NSUTF8StringEncoding error:nil];
    if(response == nil || [response  isEqual: @""])
    {
        error = @"No data recieved from DogeAPI server. DogeAPI may be having issues, or you may be experiencing connection problems. Please try again later.";
        return nil;
    }
    NSMutableDictionary * balancedata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    if(balancedata[@"error"] != nil)
    {
        error = balancedata[@"error"];
        if([error isEqual:@"Unauthorized Shibe"])
        {
            error = @"Unauthorized Shibe. You need to enable DogeAPI v2 in your DogeAPI settings.";
        }
        return nil;
    }
    else if(balancedata[@"data"] != nil)
    {
        error = @"There was an error processing this request. Please try again later.";
        NSDictionary * data = balancedata[@"data"];
        NSString * balanceAsString = data[@"balance"];
        NSNumber * balance = [[NSNumber alloc] initWithDouble:[balanceAsString doubleValue]];
        [[NSUserDefaults standardUserDefaults] setObject:balance forKey:@"lastbalance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return balance;
    }
    else
    {
        error = @"There was an error processing this request. Please try again later.";
        if([response rangeOfString:@"403 Forbidden"].location != NSNotFound)
        {
            error = @"403 Error recieved from DogeAPI Server. Please try again later.";
        }
        NSLog(@"balance response: %@",response);
    }
    return nil;
}
-(NSString*)getApiKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"dogeapikey"];
}
-(NSString*)getTransactionID
{
    return txid;
}
-(NSString*)getError
{
    return error;
}
-(NSNumber*)getDogeBTCRate
{
    NSURL * dogeApiRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.dogeapi.com/wow/v2/?a=get_current_price&convert_to=BTC&amount_doge=1"]];//,[doge doubleValue]]];
    NSString * response = [self makeUrlRequest:dogeApiRequest];
    //NSString * response = [NSString stringWithContentsOfURL:dogeApiRequest encoding:NSUTF8StringEncoding error:nil];
    if(response == nil || [response isEqual:@""])
    {
        error = @"No data recieved from DogeAPI server.  DogeAPI may be having issues, or you may be experiencing connection problems. Please try again later.";
        return nil;
    }
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    if ([formatter numberFromString:response] != nil)
    {
        return [formatter numberFromString:response];
    }
    else
    {
        error = @"Invalid data recieved from DogeAPI server.";
        return nil;
    }
}
-(NSNumber*)getDogeUSDRate
{
    NSURL * dogeApiRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.dogeapi.com/wow/v2/?a=get_current_price&convert_to=BTC&amount_doge=1"]];//,[doge doubleValue]]];
    NSString * response = [self makeUrlRequest:dogeApiRequest];
    //NSString * response = [NSString stringWithContentsOfURL:dogeApiRequest encoding:NSUTF8StringEncoding error:nil];
    if(response == nil || [response isEqual:@""])
    {
        error = @"No data recieved from DogeAPI server. DogeAPI may be having issues, or you may be experiencing connection problems. Please try again later.";
        return nil;
    }
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    if ([formatter numberFromString:response] != nil)
    {
        return [formatter numberFromString:response];
    }
    else
    {
        error = @"Invalid data recieved from DogeAPI server.";
        return nil;
    }
}
-(NSArray*)getAllDogeAPIAddresses
{
    NSArray * addresses = [[NSArray alloc] initWithObjects:@"", nil];
    NSURL * dogeApiRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://dogeapi.com/wow/v2/?api_key=%@&a=get_my_addresses",[self getApiKey]]];
    NSString * response = [self makeUrlRequest:dogeApiRequest];
    //NSString * response = [NSString stringWithContentsOfURL:dogeApiRequest encoding:NSUTF8StringEncoding error:nil];
    if(response == nil || [response  isEqual: @""])
    {
        error = @"No data recieved from DogeAPI server. DogeAPI may be having issues, or you may be experiencing connection problems. Please try again later.";
        return nil;
    }
    NSMutableDictionary * addressdata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    if(addressdata[@"error"] != nil)
    {
        error = addressdata[@"error"];
        if([error isEqual:@"Unauthorized Shibe"])
        {
            error = @"Unauthorized Shibe. You need to enable DogeAPI v2 in your DogeAPI settings.";
        }
        NSLog(@"%@",error);
        return nil;
    }
    else if(addressdata[@"data"] != nil)
    {
        NSLog(@"type data: %@",NSStringFromClass([addressdata[@"data"] class]));
        NSDictionary * data = addressdata[@"data"];
        NSLog(@"%@",NSStringFromClass([data[@"addresses"] class]));
        addresses = data[@"addresses"];
        return addresses;
    }
    return nil;
}
//Makes transactiona and adds to transaction history list
-(BOOL)makeDogeTransaction:(double)amount toAddress:(NSString*)address withPin:(NSString*)pin
{
    NSURL * dogeApiRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.dogeapi.com/wow/v2/?api_key=%@&a=withdraw&amount_doge=%f&pin=%@&payment_address=%@",[self getApiKey],amount,pin,address]];
    //NSString * response = [NSString stringWithContentsOfURL:dogeApiRequest encoding:NSASCIIStringEncoding error:nil];
    NSString * response = [self makeUrlRequest:dogeApiRequest];
    NSLog(@"resp: %@",response);
    if(response == nil || [response  isEqual: @""])
    {
        error = @"No data recieved from DogeAPI server. DogeAPI may be having issues, or you may be experiencing connection problems. Please try again later. WARNING: CHECK YOUR DOGEAPI ACCOUNT TO SEE IF ANY TRANSACTIONS HAVE GONE THROUGH.";
        return FALSE;
    }
    NSMutableDictionary * transactiondata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    if(transactiondata[@"error"] != nil)
    {
        error = transactiondata[@"error"];
        if([error isEqual:@"Unauthorized Shibe"])
        {
            error = @"Unauthorized Shibe. You have entered the wrong PIN or you need to enable DogeAPI v2 in your DogeAPI settings.";
        }
        return FALSE;
    }
    else if(transactiondata[@"data"] != nil)
    {
        NSDictionary * data = transactiondata[@"data"];
        txid = data[@"txid"];
        return TRUE;
    }
    error = @"There was an error processing this request. Please try again later.";
    return  FALSE;
}
@end
