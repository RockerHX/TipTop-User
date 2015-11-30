//
//  HXNormalAdviser.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXNormalAdviser : NSObject

@property (nonatomic, assign) NSInteger  star;
@property (nonatomic, assign) NSInteger  good;
@property (nonatomic, assign) NSInteger  caseTotal;
@property (nonatomic, assign) NSInteger  orderTotal;
@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *realName;
@property (nonatomic, strong)  NSString *mobile;
@property (nonatomic, strong)  NSString *avatar;
@property (nonatomic, strong)  NSString *services;
@property (nonatomic, strong)  NSString *goodAt;
@property (nonatomic, strong)  NSString *about;

@end
