//
//  ViewController.h
//  PushButton
//
//  Created by Brian Kelly on 9/17/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GolgiStuff.h"

@class GolgiStuff;

@interface ViewController : UIViewController
{
    NSString *targetId;
}

@property NSInteger inboundCount;
@property NSInteger outboundCount;
@property NSInteger responseCount;
@property NSInteger errorCount;
@property IBOutlet UISwitch *a2bSwitch;
@property IBOutlet UISwitch *b2aSwitch;
@property IBOutlet UILabel *inboundLabel;
@property IBOutlet UILabel *outboundLabel;
@property IBOutlet UIButton *sendButton;
@property GolgiStuff *golgiStuff;

- (IBAction)sendPressed:(UIButton *)sender;
- (IBAction)resetPressed:(UIButton *)sender;
- (void)requestReceived;
- (void)responseReceived;
- (void)errorReceived;



@end
