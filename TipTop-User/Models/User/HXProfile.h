//
//  HXProfile.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <MJExtension/MJExtension.h>

@interface HXProfile : NSObject

@property (nonatomic, assign)  NSString *ID;
@property (nonatomic, strong)  NSString *mobile;
@property (nonatomic, strong)  NSString *realName;
@property (nonatomic, strong)  NSString *avatar;
@property (nonatomic, strong)  NSString *goodAt;
@property (nonatomic, strong)  NSString *introduce;

@property (nonatomic, assign) NSInteger  good;
@property (nonatomic, assign) NSInteger  star;

@end
