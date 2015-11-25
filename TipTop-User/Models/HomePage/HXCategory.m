//
//  HXCategory.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCategory.h"


@implementation HXCategoryItem

MJCodingImplementation

#pragma mark - Class Methods
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"shortName": @"short_name",
       @"listType": @"list_type"};
}

@end

@implementation HXCategory

MJCodingImplementation

#pragma mark - Class Methods
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"shortName": @"short_name",
     @"iconActive": @"icon_active"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"sub": @"HXCategoryItem"};
}

@end
