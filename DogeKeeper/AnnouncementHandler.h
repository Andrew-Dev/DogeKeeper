//
//  AnnouncementHandler.h
//  DogeKeeper
//
//  Created by Andrew on 7/29/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnouncementHandler : NSObject

+(NSString*)makeUrlRequest:(NSURL*)requestURL;
+(BOOL)isUrgentAnnouncement;
+(BOOL)readUrgentAnnouncement;
+(void)markAsRead;
+(void)markAsRead:(NSString*)announcementid;
+(NSString*)getAnnouncementID;


@end
