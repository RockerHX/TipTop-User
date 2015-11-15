//
//  HXOnlinePayOrder.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXOnlinePayOrder : NSObject

@property (nonatomic, assign)      BOOL  isComplete;
@property (nonatomic, assign) NSInteger  completeTime;
@property (nonatomic, assign) NSInteger  createTime;
@property (nonatomic, assign) NSInteger  money;
@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *displayID;
@property (nonatomic, strong)  NSString *subCate;
@property (nonatomic, strong)  NSString *cate;
@property (nonatomic, strong)  NSString *clientName;
@property (nonatomic, strong)  NSString *clientMobile;
@property (nonatomic, strong)  NSString *clientAvatar;

@end
