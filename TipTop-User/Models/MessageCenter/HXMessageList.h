//
//  HXMessage.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/9.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXMessageList : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *thumb;
@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *content;
@property (nonatomic, assign) NSInteger  createDate;

@end
