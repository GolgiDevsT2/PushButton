//
//  AppData.h
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject
{
    NSString *instanceId;
    NSData *pushId;
}

+ (NSString *)getInstanceId;
+ (void)setInstanceId:(NSString *)instanceId;
+ (NSData *)getPushId;
+ (void)setPushId:(NSData *)pushId;


@end
