//
//  HXFilterListManager.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXFilterList.h"

@interface HXFilterListManager : NSObject

@property (nonatomic, strong, nullable, readonly) HXFilterList *filterList;

+ (nonnull instancetype)share;

- (void)fetchFilterList:(nullable void(^)(HXFilterList * _Nullable filterList, BOOL compeleted))compeleted;

@end
