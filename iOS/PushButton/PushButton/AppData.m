//
//  AppData.m
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "AppData.h"
#import "libGolgi.h"

static AppData *instance = nil;


@implementation AppData

+ (AppData *)getInstance
{
    if(instance == nil){
        instance = [[AppData alloc] init];
    }
    
    return instance;
}

+ (NSString *)getInstanceId
{
    return [[AppData getInstance] _getInstanceId];
}

+ (void)setInstanceId:(NSString *)_instanceId
{
    [[AppData getInstance] _setInstanceId:_instanceId];
}

+ (NSData *)getPushId
{
    return [[AppData getInstance] _getPushId];
}

+ (void)setPushId:(NSData *)_pushId
{
    [[AppData getInstance] _setPushId:_pushId];
}



/*********************************************************************/

- (NSString *)_getInstanceId
{
    return instanceId;
}

- (void)_setInstanceId:(NSString *)_instanceId
{
    instanceId = _instanceId;
    [self save];
}

- (NSData *)_getPushId
{
    return pushId;
}

- (void)_setPushId:(NSData *)_pushId
{
    pushId = _pushId;
    [self save];
}



- (void)save
{
    NSString *error = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"AppData.plist"];
    
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
                               [NSArray arrayWithObjects:
                                [NSString stringWithString:instanceId],
                                [pushId base64EncodedDataWithOptions:0],
                                nil]
                               
                                                          forKeys:[NSArray arrayWithObjects:
                                                                   @"instanceId",
                                                                   @"pushId",
                                                                   nil]
                               ];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(@"Error Writing GameData: %@", error);
    }
}

- (AppData *)init
{
    self = [super init];
    
    instanceId = @"";
    pushId = [[NSData alloc]init];
    
    NSString *str;
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"AppData.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"AppData" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, (int)format);
    }
    else {
        if((str = [temp objectForKey:@"instanceId"]) != nil){
            instanceId = str;
        }
        if((str = [temp objectForKey:@"pushId"]) != nil){
            pushId = [[NSData alloc] initWithBase64EncodedString:str options:0];
        }
    }
    
    NSLog(@"Instance Id: '%@'", instanceId);
    NSLog(@"    Push Id: '%@'", pushId);
    
#ifdef DEBUG
    [Golgi setDevPushToken:pushId];
#else
    [Golgi setProdPushToken:pushId];
#endif

    
    return self;
}



@end
