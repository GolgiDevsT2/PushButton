/* IS_AUTOGENERATED_SO_ALLOW_AUTODELETE=YES */
/* The previous line is to allow auto deletion */

#import "PushButtonSvcGen.h"

@implementation PushData

@synthesize dataIsSet;
- (NSString *)getData
{
    return data;
}
- (void)setData:(NSString *)_data
{
    data = _data;
    dataIsSet = (_data != nil) ? YES : NO;
}

+ (PushData *)deserialiseFromString: (NSString *)string
{
    return [PushData deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}

+ (PushData *)deserialiseFromPayload: (GolgiPayload *)payload
{
    PushData *inst = [[PushData alloc] initWithIsSet:NO];
    BOOL corrupt = NO;

    {
        NSString *str;
        if((str = [payload getStringWithTag:@"1:"]) != nil){
            inst.data = str;
        }
        else{
            corrupt = YES;
        }
    }

    return (corrupt) ? nil : inst;
}

- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}

- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];

    if(dataIsSet){
        [str appendFormat:@"%@1: \"%@\"\n", prefix, [CSL  NTLEscapeString:data]];
    }

    return [NSString stringWithString:str];
}

- (PushData *)init
{
    return [self initWithIsSet:YES];
}

- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        data = @"";
        dataIsSet = defIsSet;
    }

    return self;

}

@end
@implementation PushButton_buttonPushed_reqArg
@synthesize pushDataIsSet;
- (PushData *)getPushData
{
    return pushData;
}
- (void)setPushData:(PushData *)_pushData
{
    pushData = _pushData;
    pushDataIsSet = (_pushData != nil) ? YES : NO;
}
+ (PushButton_buttonPushed_reqArg *)deserialiseFromString: (NSString *)string
{
    return [PushButton_buttonPushed_reqArg deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}
+ (PushButton_buttonPushed_reqArg *)deserialiseFromPayload: (GolgiPayload *)payload
{
    PushButton_buttonPushed_reqArg *inst = [[PushButton_buttonPushed_reqArg alloc] initWithIsSet:NO];
    BOOL corrupt = NO;
    {
        GolgiPayload *nestedPayload;
        if((nestedPayload = [payload getNestedWithTag:@"1"]) != nil){
            [inst setPushData:[PushData deserialiseFromPayload:nestedPayload]];
        }
        else{
            [inst setPushData:nil];
        }
    }
    if([inst getPushData] == nil){
        corrupt = YES;
    }
    return (corrupt) ? nil : inst;
}
- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}
- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(pushDataIsSet){
        [str appendString:[pushData serialiseWithPrefix:[NSString stringWithFormat:@"%@%s.", prefix, "1"]]];
    }
    return [NSString stringWithString:str];
}
- (PushButton_buttonPushed_reqArg *)init
{
    return [self initWithIsSet:YES];
}
- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        pushData = [[PushData alloc] initWithIsSet:defIsSet];
        pushDataIsSet = defIsSet;
    }
    return self;
}
@end
@implementation PushButton_buttonPushed_rspArg
@synthesize internalSuccess_IsSet;
- (NSInteger)getInternalSuccess_
{
    return internalSuccess_;
}
- (void)setInternalSuccess_:(NSInteger )_internalSuccess_
{
    internalSuccess_ = _internalSuccess_;
    internalSuccess_IsSet = YES;
}
@synthesize golgiExceptionIsSet;
- (GolgiException *)getGolgiException
{
    return golgiException;
}
- (void)setGolgiException:(GolgiException *)_golgiException
{
    golgiException = _golgiException;
    golgiExceptionIsSet = (_golgiException != nil) ? YES : NO;
}
+ (PushButton_buttonPushed_rspArg *)deserialiseFromString: (NSString *)string
{
    return [PushButton_buttonPushed_rspArg deserialiseFromPayload:[GolgiPayload payloadWithString:string]];
}
+ (PushButton_buttonPushed_rspArg *)deserialiseFromPayload: (GolgiPayload *)payload
{
    PushButton_buttonPushed_rspArg *inst = [[PushButton_buttonPushed_rspArg alloc] initWithIsSet:NO];
    BOOL corrupt = NO;
    {
        NSNumber *num;
        if((num = [payload getIntWithTag:@"1:"]) != nil){
            inst.internalSuccess_ = [num intValue];
        }
    }
    {
        GolgiPayload *nestedPayload;
        if((nestedPayload = [payload getNestedWithTag:@"3"]) != nil){
            [inst setGolgiException:[GolgiException deserialiseFromPayload:nestedPayload]];
        }
        else{
            [inst setGolgiException:nil];
        }
    }
    return (corrupt) ? nil : inst;
}
- (NSString *)serialise
{
    return [self serialiseWithPrefix:@""];
}
- (NSString *)serialiseWithPrefix:(NSString *)prefix
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(internalSuccess_IsSet){
        [str appendFormat:@"%@1: %ld\n", prefix, (long)internalSuccess_];
    }
    if(golgiExceptionIsSet){
        [str appendString:[golgiException serialiseWithPrefix:[NSString stringWithFormat:@"%@%s.", prefix, "3"]]];
    }
    return [NSString stringWithString:str];
}
- (PushButton_buttonPushed_rspArg *)init
{
    return [self initWithIsSet:YES];
}
- (id)initWithIsSet:(BOOL)defIsSet
{
    if((self = [super init]) != nil){
        golgiException = [[GolgiException alloc] initWithIsSet:defIsSet];
    }
    return self;
}
@end

@interface ButtonPushedInternalResultSender : NSObject <PushButtonButtonPushedResultSender>
{
    NSString *sender;
    NSString *msgId;
    PushButton_buttonPushed_rspArg *rsp;
}
- (ButtonPushedInternalResultSender *) initWithSender:(NSString *)sender andMessageId:(NSString *)msgId;
@end
@implementation ButtonPushedInternalResultSender
- (ButtonPushedInternalResultSender *) initWithSender:(NSString *)_sender andMessageId:(NSString *)_msgId
{
    self = [self init];
    sender = _sender;
    msgId = _msgId;
    rsp = [[PushButton_buttonPushed_rspArg alloc] initWithIsSet:NO];

    return self;
}

- (void)sendResponse
{
    [Golgi sendResponsePayload:[rsp serialise] to:sender forMethod:@"buttonPushed.PushButton" withMessageId:msgId];
}

- (void)failureWithGolgiException:(GolgiException *)golgiException
{
    [rsp setGolgiException:golgiException];
    [self sendResponse];
}

- (void)success
{
    [rsp setInternalSuccess_:1];
    [self sendResponse];
}

@end

@interface ButtonPushedInternalRequestHandler : NSObject <GolgiInternalInboundRequestHandler>
{
    id<PushButtonButtonPushedRequestReceiver> receiver;
}

- (ButtonPushedInternalRequestHandler *)initWithReceiver:(id<PushButtonButtonPushedRequestReceiver>)receiver;
@end

@implementation ButtonPushedInternalRequestHandler

- (void)incomingMsg:(NSString *)payload from:(NSString *)sender withMessageId:(NSString *)msgId
{
    PushButton_buttonPushed_reqArg *req = [PushButton_buttonPushed_reqArg deserialiseFromString:payload];

    if(req == nil){
        [Golgi sendRemoteError:@"Garbled Payload at Remote End" to:sender forMethod:@"buttonPushed.PushButton" withMessageId:msgId];
    }
    else{
        // Process req here
        ButtonPushedInternalResultSender *resultSender;
        resultSender = [ButtonPushedInternalResultSender alloc];
        resultSender = [resultSender initWithSender:sender andMessageId:msgId];
        [receiver buttonPushedWithResultSender:resultSender andPushData:[req getPushData]];
    }
}

- (ButtonPushedInternalRequestHandler *)initWithReceiver:(id<PushButtonButtonPushedRequestReceiver>)_receiver
{
    self = [self init];
    receiver = _receiver;

    return self;
}
@end

@interface ButtonPushedInternalResponseHandler : NSObject <GolgiInternalInboundResponseHandler>
{
    id<PushButtonButtonPushedResultReceiver> receiver;
}

- (ButtonPushedInternalResponseHandler *)initWithReceiver:(id<PushButtonButtonPushedResultReceiver>)receiver;
@end
@implementation ButtonPushedInternalResponseHandler

- (void)processResponsePayload:(NSString *)payload
{
    PushButton_buttonPushed_rspArg *rsp = [PushButton_buttonPushed_rspArg deserialiseFromString:payload];

    if(rsp == nil){
        GolgiException *golgiException = [[GolgiException alloc]init];

        [golgiException setErrText:@"Corrupt Response"];
        [golgiException setErrType:GOLGI_ERRTYPE_PAYLOAD_MISMATCH];
        [receiver failureWithGolgiException:golgiException];
    }
    else if(rsp.internalSuccess_IsSet && ([rsp getInternalSuccess_] != 0)){
        [receiver success];
    }
    else if(rsp.golgiExceptionIsSet){
        [receiver failureWithGolgiException:[rsp getGolgiException]];
    }
    else{
        NSLog(@"WARNING: result for 'buttonPushed' in Golgi Service 'PushButton' has no expected response fields set!");
    }

}

- (void)processGolgiException:(GolgiException *)golgiException
{
	[receiver failureWithGolgiException:golgiException];
}

- (ButtonPushedInternalResponseHandler *)initWithReceiver:(id<PushButtonButtonPushedResultReceiver>)_receiver
{
    self = [self init];
    receiver = _receiver;
    return self;
}

@end



/********************************************************/
/********************************************************/
/********************************************************/


@implementation PushButtonSvc
//
// buttonPushed
//
+ (void)sendButtonPushedUsingResultReceiver:(id<PushButtonButtonPushedResultReceiver>)resultReceiver andDestination:(NSString *)_dst withPushData:(PushData *)pushData
{
    [self sendButtonPushedUsingResultReceiver:resultReceiver withTransportOptions:nil andDestination:_dst withPushData:pushData];
}

//
// buttonPushed with transport options
//
+ (void)sendButtonPushedUsingResultReceiver:(id<PushButtonButtonPushedResultReceiver>)resultReceiver withTransportOptions:(GolgiTransportOptions *)options andDestination:(NSString *)_dst withPushData:(PushData *)pushData
{
    NSString *_payload;
    PushButton_buttonPushed_reqArg *_reqArg = [[PushButton_buttonPushed_reqArg alloc] init];
    ButtonPushedInternalResponseHandler *_iRspHndlr;
    _iRspHndlr = [ButtonPushedInternalResponseHandler alloc];
    _iRspHndlr = [_iRspHndlr initWithReceiver:resultReceiver];

    [_reqArg setPushData:pushData];
    _payload = [_reqArg serialise];

    [Golgi sendRequestPayload:_payload withTransportOptions:options to:_dst withMethod:@"buttonPushed.PushButton" andResponseHandler:_iRspHndlr];

}

+ (void)registerButtonPushedRequestReceiver:(id<PushButtonButtonPushedRequestReceiver>)requestReceiver
{
    ButtonPushedInternalRequestHandler *reqHandler;
    reqHandler = [ButtonPushedInternalRequestHandler alloc];
    reqHandler = [reqHandler initWithReceiver:requestReceiver];
    [Golgi registerRequestHandler:reqHandler forMethod:@"buttonPushed.PushButton"];
}

@end