//
//  GolgiStuff.m
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "GolgiStuff.h"
#import "AppData.h"
#import "GOLGI_KEYS.h"
#import "PushButtonScvWrapper.h"

static GolgiStuff *instance = nil;


@interface _ButtonPushedResultReceiver: NSObject <PushButtonButtonPushedResultReceiver>
{
    GolgiStuff *golgiStuff;
}
@end
@implementation _ButtonPushedResultReceiver
- (void)success
{
    NSLog(@"buttonPushed: SUCCESS");
    
    if(golgiStuff.viewController != nil){
        [golgiStuff.viewController responseReceived];
    }

}

- (void)failureWithGolgiException:(GolgiException *)golgiException
{
    NSLog(@"buttonPushed: FAILED '%@'", [golgiException getErrText]);
    
    if(golgiStuff.viewController != nil){
        [golgiStuff.viewController errorReceived];
    }
    
}
- (_ButtonPushedResultReceiver *)initWithGolgiStuff:(GolgiStuff *)_golgiStuff
{
    self = [self init];
    
    golgiStuff = _golgiStuff;
    
    return self;
}


@end

@interface CombinedRequestReceiver: NSObject <PushButtonButtonPushedRequestReceiver>
{
    GolgiStuff *golgiStuff;
}
- (CombinedRequestReceiver *)initWithGolgiStuff:(GolgiStuff *)golgiStuff;
@end
@implementation CombinedRequestReceiver

- (void)buttonPushedWithResultSender:(id<PushButtonButtonPushedResultSender>)resultSender andPushData:(PushData *)pushData
{
    NSLog(@"Received request");
    [resultSender success];
    if(golgiStuff.viewController != nil){
        [golgiStuff.viewController requestReceived];
    }
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = [NSString stringWithFormat:@"Received Request: %@", [pushData getData]];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    NSLog(@"D");
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSLog(@"E");
}


- (CombinedRequestReceiver *)initWithGolgiStuff:(GolgiStuff *)_golgiStuff
{
    self = [self init];
    
    golgiStuff = _golgiStuff;
    
    return self;
}

@end



@implementation GolgiStuff
@synthesize viewController;

+ (GolgiStuff *)getInstance
{
    if(instance == nil){
        instance = [[GolgiStuff alloc] init];
    }
    
    return instance;
}


- (void)sendRequestTo:(NSString *)dest
{
    PushData *pData = [[PushData alloc] init];
    [pData setData:[NSString stringWithFormat:@"%ld", (long)viewController.outboundCount]];
    
    NSLog(@"Sending to %@", dest);
    [PushButtonSvc sendButtonPushedUsingResultReceiver:[[_ButtonPushedResultReceiver alloc] initWithGolgiStuff:self] withTransportOptions:stdGto andDestination:dest withPushData:pData];
    NSLog(@"Gone");
}


// GOLGI
//********************************* Registration ***************************
//
// Setup handling of inbound SendMessage methods and then Register with Golgi
//
- (void)doGolgiRegistration
{
    //
    // Do this before registration because on registering, there may be messages queued
    // up for us that would arrive and be rejected because there is no handler in place
    //
    
    // [TapTelegraphSvc registerSendMessageRequestReceiver:self];
    
    //
    // and now do the main registration with the service
    //
    NSLog(@"Registering with golgiId: '%@'", [AppData getInstanceId]);
    
    
    // [Golgi setOption:@"USE_DEV_CLUSTER" withValue:@"0"];
    
    CombinedRequestReceiver *crr = [[CombinedRequestReceiver alloc] initWithGolgiStuff:self];
    
    [PushButtonSvc registerButtonPushedRequestReceiver:crr];
    
    NSData *pushId = [AppData getPushId];
    
    if(pushId.length > 0){
#ifdef DEBUG
        [Golgi setDevPushToken:pushId];
#else
        [Golgi setProdPushToken:pushId];
#endif
    }
    NSString *instanceId = [AppData getInstanceId];
    if(instanceId.length > 0){
        [Golgi registerWithDevId:GOLGI_DEV_KEY
                           appId:GOLGI_APP_KEY
                          instId:instanceId
                      andAPIUser:self];
    }
}


- (void)setInstanceId:(NSString *)newInstanceId
{
    [AppData setInstanceId:newInstanceId];
    
    [self doGolgiRegistration];
}
//
// Registration worked
//

- (void)golgiRegistrationSuccess
{
    NSLog(@"Golgi Registration: PASS");
}

//
// Registration failed
//

- (void)golgiRegistrationFailure:(NSString *)errorText
{
    NSLog(@"Golgi Registration: FAIL => '%@'", errorText);
}

- (void)setPushId:(NSData *)newPushId
{
    NSData *pushId = [AppData getPushId];
    if(pushId.length != newPushId.length || memcmp([pushId bytes], [newPushId bytes], pushId.length) != 0){
        [AppData setPushId:newPushId];
        [self doGolgiRegistration];
    }
}

- (NSString *)pushTokenToString:(NSData *)token
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    
    for(int i = 0; i < token.length; i++){
        [hexStr appendFormat:@"%02x", ((unsigned char *)[token bytes])[i]];
    }
    
    return [NSString stringWithString:hexStr];
}

- (GolgiStuff *)init
{
    self = [super init];
    viewController = nil;
    
    
    stdGto = [[GolgiTransportOptions alloc] init];
    [stdGto setValidityPeriodInSeconds:3600];
    

    [self doGolgiRegistration];
    
    return self;
}

@end
