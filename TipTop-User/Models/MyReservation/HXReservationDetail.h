//
//  HXReservationDetail.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXReservationDetailOrder : NSObject

@property (nonatomic, assign)      BOOL  isComplete;
@property (nonatomic, assign) NSInteger  completeTime;
@property (nonatomic, assign) NSInteger  createTime;
@property (nonatomic, assign) NSInteger  money;
@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *displayID;
@property (nonatomic, strong)  NSString *cate;
@property (nonatomic, strong)  NSString *subCate;
@property (nonatomic, strong)  NSString *clientName;
@property (nonatomic, strong)  NSString *clientMobile;
@property (nonatomic, strong)  NSString *clientAvatar;
@property (nonatomic, strong)  NSString *address;

@end

@interface HXReservationDetailRemark : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *content;
@property (nonatomic, strong)  NSString *markTime;
@property (nonatomic, strong)  NSString *createTime;

@end

@interface HXReservationDetail : NSObject

@property (nonatomic, strong) HXReservationDetailOrder *order;
@property (nonatomic, strong)                  NSArray *remarks;

@end