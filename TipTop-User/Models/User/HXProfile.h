//
//  HXProfile.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <MJExtension/MJExtension.h>

@interface HXProfile : NSObject

@property (nonatomic, assign) NSInteger  credit;
@property (nonatomic, assign)  NSString *ID;
@property (nonatomic, strong)  NSString *avatar;
@property (nonatomic, strong)  NSString *number;
@property (nonatomic, strong)  NSString *company;
@property (nonatomic, strong)  NSString *displayId;
@property (nonatomic, strong)  NSString *industry;
@property (nonatomic, strong)  NSString *mobile;
@property (nonatomic, strong)  NSString *realName;
@property (nonatomic, strong)  NSString *wechat;

@end
