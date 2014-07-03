//
//  DogeTransaction.h
//  DogeKeeper
//
//  Created by Andrew on 5/17/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-SA 4.0
//


#import <Foundation/Foundation.h>

@interface DogeTransaction : NSObject

@property NSString * transactionID;
@property NSNumber * amount;
@property NSString * toAddress;
@property NSDate * dateSent;

+(NSMutableArray*)getAllTransactions;
+(void)addTransactionToHistory:(DogeTransaction*)transaction;
@end
