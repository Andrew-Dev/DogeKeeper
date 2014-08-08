//
//  AnnouncementHandler.m
//  DogeKeeper
//
//  Created by Andrew on 7/29/14.
//  Copyright (c) 2014 Andrew Arpasi. All rights reserved.
//

#import "AnnouncementHandler.h"

@implementation AnnouncementHandler

+(NSString*)makeUrlRequest:(NSURL*)requestURL
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLRequest* request = [NSURLRequest requestWithURL:requestURL cachePolicy:0 timeoutInterval:15];
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* stringFromServer = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return stringFromServer;
}
+(BOOL)isUrgentAnnouncement
{
    NSString * idresponse = [self makeUrlRequest:[[NSURL alloc] initWithString:@"http://dogekeeper.com/urgent.php?a=id"]];
    NSLog(@"idresponse: %@",idresponse);
    NSString * contentresponse = [self makeUrlRequest:[[NSURL alloc] initWithString:@"http://dogekeeper.com/urgent.php"]];
    NSLog(@"cr: %@",contentresponse);
    if([idresponse isEqualToString:@"0"] || [contentresponse rangeOfString:@"<!--{{{URGENT}}}-->"].location == NSNotFound)
    {
        NSLog(@"not urgent");
        return FALSE;
    }
    return TRUE;
    NSLog(@"urgent");
}
+(BOOL)readUrgentAnnouncement
{
    if([[self getAnnouncementID] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"lastannouncement"]])
    {
        return TRUE;
    }
    return FALSE;
}
+(void)markAsRead
{
    NSString * announcementid = [self getAnnouncementID];
    [[NSUserDefaults standardUserDefaults] setObject:announcementid forKey:@"lastannouncement"];
}
+(NSString*)getAnnouncementID
{
    NSString * idresponse = [self makeUrlRequest:[[NSURL alloc] initWithString:@"http://dogekeeper.com/urgent.php?a=id"]];
    if(idresponse.length < 4)
    {
        return idresponse;
    }
    else
    {
        return FALSE;
    }
}

@end
