//
//  GolgiStuff.h
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreLocation/CoreLocation.h>
#import "PushButtonScvWrapper.h"
#import "ViewController.h"
#import "libGolgi.h"

@class ViewController;

@interface GolgiStuff : NSObject
{
    GolgiTransportOptions *stdGto;
    long launchTime;
}

@property ViewController *viewController;
+ (GolgiStuff *)getInstance;

- (void)sendRequestTo:(NSString *)dest;


- (void)setInstanceId:(NSString *)newInstanceId;


@end
