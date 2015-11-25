//
//  HXCategoryManager.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCategory.h"

@interface HXCategoryManager : NSObject

@property (nonatomic, strong, nullable) NSArray<HXCategory *> *categories;

+ (nonnull instancetype)share;

- (void)fetchCategories:(nullable void(^)(BOOL compeleted))compeleted;

@end
