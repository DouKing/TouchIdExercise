//
//  ViewController.m
//  TouchId
//
//  Created by WuYikai on 15/7/1.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)handleAuthenticateButtonAction:(UIButton *)sender {
  LAContext *context = [[LAContext alloc] init];
  NSError *error = nil;
  if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
    // Authenticate User
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Are you the device owner" reply:^(BOOL success, NSError *error) {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
          [[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"There was a problem verifying your identify" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
          return;
        }
        if (success) {
          [[[UIAlertView alloc] initWithTitle:@"SUCCESS" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
          [[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"You are not the device owner" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
      });
    }];
  } else {
    [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot authenticate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
