//
//  ViewController.m
//  PushButton
//
//  Created by Brian Kelly on 9/17/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "ViewController.h"
#import "AppData.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize a2bSwitch;
@synthesize b2aSwitch;
@synthesize inboundCount;
@synthesize outboundCount;
@synthesize inboundLabel;
@synthesize outboundLabel;
@synthesize sendButton;
@synthesize golgiStuff;
@synthesize responseCount;
@synthesize errorCount;

- (void)showCounts
{
    inboundLabel.text = [NSString stringWithFormat:@"%ld", (long)inboundCount];
    outboundLabel.text = [NSString stringWithFormat:@"%ld [%ld/%ld]", (long)outboundCount, (long)responseCount, (long)errorCount];
}

- (IBAction)sendPressed:(UIButton *)sender
{
    NSLog(@"Send Pressed");
    outboundCount++;
    [self showCounts];
    [golgiStuff sendRequestTo:targetId];
}

- (IBAction)resetPressed:(UIButton *)sender
{
    NSLog(@"Reset Pressed");
    inboundCount = 0;
    outboundCount = 0;
    a2bSwitch.enabled = YES;
    b2aSwitch.enabled = YES;
    [self showCounts];
    
    
}


- (void)switchChanged:(UISwitch *)sw
{
    NSString *title;
    UISwitch *sw2;
    NSString *ourId;
    
    if((sw == a2bSwitch && a2bSwitch.on == YES) || (sw == b2aSwitch && b2aSwitch.on == NO)){
        ourId = @"A";
        targetId = @"B";
    }
    else{
        title = @"B2A";
        ourId = @"B";
        targetId = @"A";
    }
    
    
    NSLog(@"Switch changed");

    if(sw == a2bSwitch){
        sw2 = b2aSwitch;
    }
    else{
        sw2 = a2bSwitch;
    }
    
    [sw2 setOn:!(sw.on) animated:YES];
    
    a2bSwitch.enabled = NO;
    b2aSwitch.enabled = NO;
    sendButton.hidden = NO;
    
    [golgiStuff setInstanceId:ourId];
    
    if(targetId == nil || [targetId compare:ourId] != NSOrderedSame){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Role Change"
                                                        message:@"You must kill and restart after a role change."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    targetId = ourId;

}

- (void)viewDidAppear:(BOOL)animated
{
    if(a2bSwitch.enabled){
        sendButton.hidden = YES;
    }
    else{
        sendButton.hidden = NO;
    }
    NSLog(@"Setting viewController in Golgi");
    
}

- (void)requestReceived
{
    inboundCount++;
    [self showCounts];
}

- (void)responseReceived
{
    responseCount++;
    [self showCounts];
}

- (void)errorReceived
{
    errorCount++;
    [self showCounts];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *instanceId = [AppData getInstanceId];
	// Do any additional setup after loading the view, typically from a nib.
    
    [a2bSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [b2aSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    if([instanceId compare:@"A"] == NSOrderedSame){
        [a2bSwitch setOn:YES];
        [b2aSwitch setOn:NO];
        a2bSwitch.enabled = NO;
        b2aSwitch.enabled = NO;
        sendButton.hidden = NO;
        targetId = @"B";

    }
    else if([instanceId compare:@"B"] == NSOrderedSame){
        [a2bSwitch setOn:NO];
        [b2aSwitch setOn:YES];
        a2bSwitch.enabled = NO;
        b2aSwitch.enabled = NO;
        sendButton.hidden = NO;
        targetId = @"A";
    }
    else{
        sendButton.hidden = YES;
    }
    
    golgiStuff = [GolgiStuff getInstance];
    golgiStuff.viewController = self;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
