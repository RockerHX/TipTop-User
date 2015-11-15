//
//  HXCase.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <MJExtension/MJExtension.h>

@interface HXCase : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *image;
@property (nonatomic, strong)  NSString *contentIntroduce;
@property (nonatomic, strong)  NSString *caseIntroduce;
@property (nonatomic, assign) NSInteger  createDate;

@end
