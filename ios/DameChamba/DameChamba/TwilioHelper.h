//
//  TwilioHelper.h
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwilioHelper : NSObject

+ (void)sendMessageToNumber: (NSString *)number withMessage: (NSString *)message;

@end
