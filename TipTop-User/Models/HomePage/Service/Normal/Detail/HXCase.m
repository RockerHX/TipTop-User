//
//  HXCase.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/4.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCase.h"

@implementation HXCase

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"introduce": @"description",
     @"createDate": @"create_time"};
}

@end
