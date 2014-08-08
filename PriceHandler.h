//
//  PriceHandler.h
//  DogeKeeper
//
//  Created by Andrew on 7/30/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceHandler : NSObject

+(NSString*)makeUrlRequest:(NSURL*)requestURL;
+(NSArray*)getPricesFromSoChain;

@end
