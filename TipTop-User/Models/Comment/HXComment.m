//
//  HXComment.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXComment.h"

@implementation HXComment

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID": @"id",
   @"clientAvatar": @"client_avatar",
   @"clientMobile": @"client_mobile",
     @"clientName": @"client_name",
     @"createDate": @"create_time"};
}

@end
