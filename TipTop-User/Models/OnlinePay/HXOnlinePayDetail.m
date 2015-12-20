//
//  HXOnlinePayDetail.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetail.h"

@implementation HXOnlinePayDetailOrder

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
      @"displayID": @"display_id",
        @"subCate": @"sub_cate",
      @"agentName": @"agent_name",
    @"agentAvatar": @"agent_avatar",
    @"agentMobile": @"agent_mobile",
      @"agentStar": @"agent_star",
     @"isComplete": @"is_complete",
      @"hasRemark": @"has_remark",
   @"completeTime": @"complete_time",
     @"createTime": @"create_time"};
}

@end

@implementation HXOnlinePayDetailRemark

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"markTime": @"mark_time",
     @"createTime": @"create_time"};
}

@end

@implementation HXOnlinePayDetail

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"remarks": @"HXOnlinePayDetailRemark"};
}

@end
