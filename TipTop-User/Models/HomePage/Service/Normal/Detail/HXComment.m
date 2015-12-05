//
//  HXComment.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXComment.h"

@implementation HXComment

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
     @"createDate": @"create_time"};
}

@end
