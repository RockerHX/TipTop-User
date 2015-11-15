//
//  HXMessage.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/9.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXMessage : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *badge;
@property (nonatomic, strong)  NSString *name;
@property (nonatomic, strong)  NSString *title;
@property (nonatomic, assign) NSInteger  createDate;

@end
