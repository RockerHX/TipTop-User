//
//  HXCategoryManager.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCategoryManager.h"
#import "HXAppApiRequest.h"

typedef void(^BLOCK)(NSArray<HXCategory *> * _Nullable categories, BOOL compeleted);

static NSString *CategoriesDataPath = @"/categories.data";

static NSString *CategoryApi = @"/category";

static HXCategoryManager *manager = nil;

@implementation HXCategoryManager {
    BLOCK _block;
}

#pragma mark - Class Methods
+ (nonnull instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXCategoryManager alloc] init];
    });
    return manager;
}

#pragma mark - Private Methods
- (void)fetchCategories:(nullable void(^)(NSArray<HXCategory *> * _Nullable categories, BOOL compeleted))compeleted {
    _block = compeleted;
    [self startCategoriesRequest];
}

- (void)startCategoriesRequest {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi commonApiURLWithApi:CategoryApi] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            NSArray *categories = responseObject[@"data"];
            NSMutableArray *mutableArray = @[].mutableCopy;
            for (NSDictionary *data in categories) {
                HXCategory *category = [HXCategory mj_objectWithKeyValues:data];
                [mutableArray addObject:category];
            }
            strongSelf.categories = [mutableArray copy];
            if (strongSelf->_block) {
                strongSelf->_block(strongSelf.categories, YES);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.categories = nil;
        if (strongSelf->_block) {
            strongSelf->_block(strongSelf.categories, YES);
        }
    }];
}

@end
