//
//  HXComment.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXComment : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *content;
@property (nonatomic, assign) NSInteger  star;
@property (nonatomic, assign) NSInteger  createDate;

@end
