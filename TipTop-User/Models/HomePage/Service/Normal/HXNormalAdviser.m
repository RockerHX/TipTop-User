//
//  HXNormalAdviser.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXNormalAdviser.h"

@implementation HXNormalAdviser

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"realName": @"real_name",
         @"goodAt": @"good_at",
      @"caseTotal": @"case_total",
     @"orderTotal": @"order_total"};
}


@end
