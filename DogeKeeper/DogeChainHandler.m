//
//  DogeChainHandler.m
//  DogeKeeper
//
//  Created by Andrew on 5/20/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "DogeChainHandler.h"

@implementation DogeChainHandler

-(NSString*)getError
{
    return error;
}
-(NSString*)makeDogeChainRequest:(NSURL*)reqUrl
{
    NSURL * dogeChainRequest = reqUrl;
    NSString * response = [NSString stringWithContentsOfURL:dogeChainRequest encoding:NSUTF8StringEncoding error:nil];
    if(response == nil || [response isEqual:@""])
    {
        error = @"No data recieved from DogeChain server.";
        return @"Error.";
    }
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    if ([formatter numberFromString:response] != nil)
    {
        return response;
    }
    else
    {
        error = @"Invalid data recieved from DogeChain server.";
        return @"Error.";
    }
}
-(NSString*)getDogeBalance:(NSString*)address
{
    NSURL * dogeChainRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://dogechain.info/chain/Dogecoin/q/addressbalance/%@",address]];
    return [self makeDogeChainRequest:dogeChainRequest];
}
-(NSNumber*)getTotalBalance:(NSMutableArray*)addresses
{
    NSNumber * walletsTotal;
    double totalBalance = 0;
    for(int i=0;i<[addresses count];i++)
    {
        NSString * balanceAsString = [self getDogeBalance:[addresses objectAtIndex:i]];
        double balance = [balanceAsString doubleValue];
        totalBalance = totalBalance + balance;
        NSLog(@"tb: %f",totalBalance);
    }
    walletsTotal = [[NSNumber alloc] initWithDouble:totalBalance];
    return walletsTotal;
}
-(NSString*)getDogeRecieved:(NSString*)address
{
    NSURL * dogeChainRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://dogechain.info/chain/Dogecoin/q/getreceivedbyaddress/%@",address]];
    return [self makeDogeChainRequest:dogeChainRequest];
}
-(NSString*)getBlockCount
{
    NSURL * dogeChainRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://dogechain.info/chain/Dogecoin/q/getblockcount"]];
    return [self makeDogeChainRequest:dogeChainRequest];
}
-(NSString*)getTotalMined
{
    NSURL * dogeChainRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://dogechain.info/chain/Dogecoin/q/totalbc"]];
    return [self makeDogeChainRequest:dogeChainRequest];
}
-(NSString*)getDifficulty
{
    NSURL * dogeChainRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://dogechain.info/chain/Dogecoin/q/getdifficulty"]];
    return [self makeDogeChainRequest:dogeChainRequest];
}
@end
