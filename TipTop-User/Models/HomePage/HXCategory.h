//
//  HXCategory.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"


@interface HXCategoryItem : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *name;
@property (nonatomic, strong)  NSString *shortName;
@property (nonatomic, assign) NSInteger  listType;

@end

@interface HXCategory : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *iconActive;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortName;

@property (nonatomic, strong) NSArray<HXCategoryItem *> *subItems;

@end
