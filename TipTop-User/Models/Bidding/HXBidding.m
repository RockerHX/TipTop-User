//
//  HXBidding.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXBidding.h"

@implementation HXBidding

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
        @"subCate": @"sub_cate",
     @"createDate": @"create_time",
    @"deliverDate": @"eta"};
}

@end
