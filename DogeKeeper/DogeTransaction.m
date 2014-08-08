//
//  DogeTransaction.m
//  DogeKeeper
//
//  Created by Andrew on 5/17/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "DogeTransaction.h"

@implementation DogeTransaction
@synthesize transactionID,amount,toAddress,dateSent,networkFee;

- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        toAddress = [decoder decodeObjectForKey:@"toAddress"];
        amount = [decoder decodeObjectForKey:@"amount"];
        transactionID = [decoder decodeObjectForKey:@"transactionID"];
        dateSent = [decoder decodeObjectForKey:@"dateSent"];
        networkFee = [decoder decodeObjectForKey:@"networkFee"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:toAddress forKey:@"toAddress"];
    [encoder encodeObject:amount forKey:@"amount"];
    [encoder encodeObject:transactionID forKey:@"transactionID"];
    [encoder encodeObject:dateSent forKey:@"dateSent"];
    [encoder encodeObject:networkFee forKey:@"networkFee"];
}
+(NSMutableArray*)getAllTransactions
{
    NSMutableArray * transactions = [[NSMutableArray alloc] init];
    for(NSData * w in [[NSUserDefaults standardUserDefaults] objectForKey:@"transactions"])
    {
        [transactions addObject:w];
    }
    return transactions;
}
+(void)addTransactionToHistory:(DogeTransaction*)transaction
{
    NSMutableArray * transactions = [self getAllTransactions];
    NSData * transactionData = [NSKeyedArchiver archivedDataWithRootObject:transaction];
    [transactions addObject:transactionData];
    [[NSUserDefaults standardUserDefaults] setObject:transactions forKey:@"transactions"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
