//
//  HXFilterList.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXFilterList.h"

@implementation HXFilterItem
@end

@implementation HXFilterListItem

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data": @"HXFilterItem"};
}

@end

@implementation HXFilterList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"normal": @"HXFilterListItem",
              @"house": @"HXFilterListItem",
           @"designer": @"HXFilterListItem"};
}

@end
