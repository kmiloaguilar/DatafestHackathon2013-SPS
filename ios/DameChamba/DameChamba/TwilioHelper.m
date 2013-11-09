//
//  TwilioHelper.m
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import "TwilioHelper.h"

@implementation TwilioHelper

+ (void)sendMessageToNumber: (NSString *)phoneNumber withMessage: (NSString *)messageBody{
    NSDictionary *paramsDict = [[NSDictionary alloc] initWithObjects:@[phoneNumber, messageBody] forKeys:@[@"number",@"message"]];
    [PFCloud callFunctionInBackground:@"smsWithTwilio"
                       withParameters:paramsDict
                                block:^(id object, NSError *error) {
                                    NSLog(@"error: %@",error.description);
                                    NSLog(@"object: %@",object);
                                }];
    
    
}


@end
