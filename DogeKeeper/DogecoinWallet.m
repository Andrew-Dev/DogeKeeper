//
//  DogecoinWallet.m
//  DogeKeeper
//
//  Created by Andrew on 5/20/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import "DogecoinWallet.h"

@implementation DogecoinWallet
@synthesize title,address,isApi;

- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        title = [decoder decodeObjectForKey:@"title"];
        address = [decoder decodeObjectForKey:@"address"];
        isApi = [decoder decodeBoolForKey:@"isApi"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:title forKey:@"title"];
    [encoder encodeObject:address forKey:@"address"];
    [encoder encodeBool:isApi forKey:@"isApi"];
}
+(NSMutableArray*)getAllWallets
{
    NSMutableArray * wallets = [[NSMutableArray alloc] init];
    for(NSData * w in [[NSUserDefaults standardUserDefaults] objectForKey:@"wallets"])
    {
        [wallets addObject:w];
    }
    return wallets;
}

@end
