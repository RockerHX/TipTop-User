//
//  HXReservationOrder.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXReservationOrder : NSObject

@property (nonatomic, assign)      BOOL  isComplete;
@property (nonatomic, assign) NSInteger  createDate;
@property (nonatomic, assign) NSInteger  star;
@property (nonatomic, assign) NSInteger  good;
@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *agentID;
@property (nonatomic, strong)  NSString *cid;
@property (nonatomic, strong)  NSString *displayID;
@property (nonatomic, strong)  NSString *cate;
@property (nonatomic, strong)  NSString *subCate;
@property (nonatomic, strong)  NSString *agentName;
@property (nonatomic, strong)  NSString *agentMobile;
@property (nonatomic, strong)  NSString *agentAvatar;

@end
