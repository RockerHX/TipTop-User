//
//  HXServiceHouse.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceHouse.h"

@implementation HXServiceHouse

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
        @"agentID": @"agent_id"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    _money /= 100;
}

@end
