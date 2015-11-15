//
//  HXMessage.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/9.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMessage.h"

@implementation HXMessage

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID": @"id",
     @"createDate": @"create_time"};
}

@end
