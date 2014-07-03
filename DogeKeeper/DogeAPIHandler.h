//
//  DogeAPIHandler.h
//  DogeKeeper
//
//  Created by Andrew on 5/16/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-SA 4.0
//

#import <Foundation/Foundation.h>
#import "DogeTransaction.h"

@interface DogeAPIHandler : NSObject
{
    NSString * error;
    NSString * txid;
}
-(BOOL)makeDogeTransaction:(double)amount toAddress:(NSString*)address withPin:(NSString*)pin;
-(NSString*)getCurrentAddress;
-(NSString*)getError;
-(NSString*)getApiKey;
-(void)addDogeAPIAccount:(NSString*)apikey;
-(void)removeDogeAPIAccount;
-(BOOL)checkDogeAPIAccount;
-(BOOL)validateDogeAPIAccount:(NSString*)apikey;
-(NSArray*)getAllDogeAPIAddresses;
-(NSString*)getTransactionID;
-(NSNumber*)getDogeAPIBalance;
-(NSNumber*)getDogeUSDRate;
-(NSNumber*)getDogeBTCRate;
-(BOOL)addNewAddress;

@end
