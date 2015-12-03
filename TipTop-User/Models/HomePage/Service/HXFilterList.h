//
//  HXFilterList.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXFilterItem : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

@end

@interface HXFilterListItem : NSObject

@property (nonatomic, strong)                 NSString *key;
@property (nonatomic, strong)  NSArray<HXFilterItem *> *data;

@end

@interface HXFilterList : NSObject

@property (nonatomic, strong) NSArray<HXFilterListItem *> *normal;
@property (nonatomic, strong) NSArray<HXFilterListItem *> *house;
@property (nonatomic, strong) NSArray<HXFilterListItem *> *designer;

@end
