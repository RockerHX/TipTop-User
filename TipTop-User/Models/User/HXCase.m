//
//  HXCase.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCase.h"

@implementation HXCase

+ (NSDictionary *)replacedKeyFromPropertyName {
     return @{@"ID": @"id",
@"contentIntroduce": @"description",
   @"caseIntroduce": @"content",
      @"createDate": @"create_time"};
}

@end
