//
//  HXReservationDetail.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationDetail.h"

@implementation HXReservationDetailOrder

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"displayID": @"display_id",
        @"subCate": @"sub_cate",
     @"clientName": @"client_name",
   @"clientAvatar": @"client_avatar",
   @"clientMobile": @"client_mobile",
     @"isComplete": @"is_complete",
   @"completeTime": @"complete_time",
     @"createTime": @"create_time"};
}

@end

@implementation HXReservationDetailRemark

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"markTime": @"mark_time",
     @"createTime": @"create_time"};
}

@end

@implementation HXReservationDetail

+ (NSDictionary *)objectClassInArray {
    return @{@"remarks": @"HXReservationDetailRemark"};
}

@end
