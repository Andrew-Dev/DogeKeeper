//
//  DogeChainHandler.h
//  DogeKeeper
//
//  Created by Andrew on 5/20/14.
//  Copyright (c) 2014 Andrew Arpasi. Licensed under CC BY-NC-ND 4.0
//

#import <Foundation/Foundation.h>

@interface DogeChainHandler : NSObject
{
    NSString * error;
}
-(NSString*)getDogeBalance:(NSString*)address;
-(NSString*)getDogeRecieved:(NSString*)address;
-(NSString*)getBlockCount;
-(NSString*)getTotalMined;
-(NSString*)getDifficulty;
-(NSString*)getError;
-(NSNumber*)getTotalBalance:(NSArray*)addresses;

@end
