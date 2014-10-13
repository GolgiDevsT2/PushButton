//
//  AppDelegate.h
//  PushButton
//
//  Created by Brian Kelly on 9/17/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GolgiStuff.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    GolgiStuff *golgiStuff;
}
+ (NSString *)getInstanceId;
+ (void)setInstanceId:(NSString *)instanceId;
+ (NSData *)getPushId;
+ (void)setPushId:(NSData *)pushId;

@property (strong, nonatomic) UIWindow *window;

@end
