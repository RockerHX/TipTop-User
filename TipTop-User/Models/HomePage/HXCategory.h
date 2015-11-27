//
//  HXCategory.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

typedef NS_ENUM(NSUInteger, HXCategoryListType) {
    HXCategoryListTypeNormal,
    HXCategoryListTypeDesigner,
    HXCategoryListTypeCase,
    HXCategoryListTypeHouseSale
};


@interface HXCategoryItem : NSObject

@property (nonatomic, strong)           NSString *ID;
@property (nonatomic, strong)           NSString *name;
@property (nonatomic, strong)           NSString *shortName;
@property (nonatomic, assign) HXCategoryListType  listType;

@end

@interface HXCategory : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *iconActive;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortName;

@property (nonatomic, strong) NSArray<HXCategoryItem *> *subItems;

@end
