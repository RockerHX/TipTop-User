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

- (void)mj_keyValuesDidFinishConvertingToObject {
    HXFilterItem *item = [HXFilterItem new];
    item.key = @"";
    item.value = @"全部";
    
    NSMutableArray *normalRegions = _normal.firstObject.data.mutableCopy;
    [normalRegions insertObject:item atIndex:0];
    _normal.firstObject.data = normalRegions.copy;
    
    NSMutableArray *houseRegions = _house.firstObject.data.mutableCopy;
    [houseRegions insertObject:item atIndex:0];
    _house.firstObject.data = houseRegions.copy;
}

@end
