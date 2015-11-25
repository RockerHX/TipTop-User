//
//  HXUser.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUser.h"

@implementation HXUser

MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"uid": @"id",
        @"realName": @"real_name",
     @"accessToken": @"access_token",
    @"tokenExpired": @"token_expired"};
}

@end
