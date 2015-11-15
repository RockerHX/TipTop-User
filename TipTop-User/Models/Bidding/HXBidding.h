//
//  HXBidding.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXBidding : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *cate;
@property (nonatomic, strong)  NSString *subCate;
@property (nonatomic, assign) NSInteger  createDate;
@property (nonatomic, assign) NSInteger  deliverDate;

@end