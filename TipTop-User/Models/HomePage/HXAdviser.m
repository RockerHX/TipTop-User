//
//  HXAdviser.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/22.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAdviser.h"

@implementation HXAdviser

#pragma mark - Class Methods
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"realName": @"real_name",
       @"latitude": @"lat",
     @"longtitude": @"lng"};
}

@end
