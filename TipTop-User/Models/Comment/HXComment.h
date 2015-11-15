//
//  HXComment.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXComment : NSObject

@property (nonatomic, assign) NSInteger  star;
@property (nonatomic, assign) NSInteger  createDate;
@property (nonatomic, assign)  NSString *ID;
@property (nonatomic, strong)  NSString *clientAvatar;
@property (nonatomic, strong)  NSString *clientMobile;
@property (nonatomic, strong)  NSString *clientName;
@property (nonatomic, strong)  NSString *content;

@end
