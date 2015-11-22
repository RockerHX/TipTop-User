//
//  HXOnlinePayDetail.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetail.h"

@implementation HXOnlinePayDetailOrder

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"displayID": @"display_id",
        @"subCate": @"sub_cate",
      @"agentName": @"agent_name",
    @"agentAvatar": @"agent_avatar",
    @"agentMobile": @"agent_mobile",
     @"isComplete": @"is_complete",
   @"completeTime": @"complete_time",
     @"createTime": @"create_time"};
}

@end

@implementation HXOnlinePayDetailRemark

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"markTime": @"mark_time",
     @"createTime": @"create_time"};
}

@end

@implementation HXOnlinePayDetail

+ (NSDictionary *)objectClassInArray {
    return @{@"remarks": @"HXOnlinePayDetailRemark"};
}

@end
