//
//  HXBiddingService.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXBiddingService.h"

@implementation HXBiddingSubService

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"shortName": @"short_name"};
}

@end

@implementation HXBiddingService

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"shortName": @"short_name",
     @"iconActive": @"icon_active",
    @"subServices": @"sub"};
}

+ (NSDictionary *)objectClassInArray {
    return @{@"subServices": @"HXBiddingSubService"};
}

@end
