//
//  HXFilterListManager.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXFilterListManager.h"
#import "HXAppApiRequest.h"

typedef void(^BLOCK)(HXFilterList * _Nullable filterList, BOOL compeleted);

static NSString *FilterListDataPath = @"/FilterList.data";

static NSString *FilterListApi = @"/system/listFilter";

static HXFilterListManager *manager = nil;

@implementation HXFilterListManager {
    BLOCK _block;
}

#pragma mark - Class Methods
+ (nonnull instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXFilterListManager alloc] init];
    });
    return manager;
}

#pragma mark - Private Methods
- (void)fetchFilterList:(nullable void(^)(HXFilterList * _Nullable filterList, BOOL compeleted))compeleted {
    _block = compeleted;
    [self startCategoriesRequest];
}

- (void)startCategoriesRequest {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:FilterListApi] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            HXFilterList *list = [HXFilterList mj_objectWithKeyValues:responseObject[@"data"]];
            _filterList = list;
            if (strongSelf->_block) {
                strongSelf->_block(list, YES);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        if (strongSelf->_block) {
            strongSelf->_block(strongSelf.filterList, YES);
        }
    }];
}

@end
