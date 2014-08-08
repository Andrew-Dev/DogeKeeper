//
//  PriceHandler.m
//  DogeKeeper
//
//  Created by Andrew on 7/30/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import "PriceHandler.h"

@implementation PriceHandler

+(NSString*)makeUrlRequest:(NSURL*)requestURL
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLRequest* request = [NSURLRequest requestWithURL:requestURL cachePolicy:0 timeoutInterval:15];
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* stringFromServer = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return stringFromServer;
}
+(NSArray*)getPricesFromSoChain
{
    NSURL * request = [[NSURL alloc] initWithString:@"https://chain.so/api/v2/get_price/DOGE"];
    NSString * response = [self makeUrlRequest:request];
    NSMutableDictionary * pricedata;
    if(response != nil)
    {
        pricedata = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    else
    {
        return nil;
    }
    NSDictionary * data = pricedata[@"data"];
    if([pricedata[@"status"] isEqualToString:@"success"])
    {
        NSArray * prices = data[@"prices"];
        return prices;
    }
    return nil;
}

@end
