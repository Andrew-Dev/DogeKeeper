//
//  BlockIOHandler.h
//  DogeKeeper
//
//  Created by Andrew on 7/26/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//
#import <Foundation/Foundation.h>

@interface BlockIOHandler : NSObject
{
    NSString * error;
    NSString * txid;
    double networkfee;
}
-(BOOL)makeDogeTransaction:(double)amount toAddress:(NSString*)address withPin:(NSString*)pin;
-(NSString*)makeUrlRequest:(NSURL*)requestURL;
-(NSString*)getError;
-(NSString*)getApiKey;
-(double)getNetworkFee;
-(void)addAccount:(NSString*)apikey;
-(void)removeAccount;
-(BOOL)checkAccount;
-(BOOL)validateAccount:(NSString*)apikey;
-(NSArray*)getAllAddresses;
-(NSString*)getTransactionID;
-(NSNumber*)getBalance;
-(BOOL)addNewAddress:(NSString*)addressName;
@end