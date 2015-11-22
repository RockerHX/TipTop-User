//
//  HXProfile.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfile.h"

@implementation HXProfile

MJCodingImplementation

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"realName": @"real_name"};
}

@end
