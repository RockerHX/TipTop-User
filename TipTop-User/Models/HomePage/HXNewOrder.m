//
//  HXNewOrder.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXNewOrder.h"

@implementation HXNewOrder

#pragma mark - Class Methods
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
        @"subCate": @"sub_cate"};
}

@end
