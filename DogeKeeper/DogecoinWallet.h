//
//  DogecoinWallet.h
//  DogeKeeper
//
//  Created by Andrew on 5/20/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-SA 4.0
//

#import <Foundation/Foundation.h>

@interface DogecoinWallet : NSObject

@property NSString * title;
@property NSString * address;
@property BOOL isApi;

+(NSMutableArray*)getAllWallets;

@end
