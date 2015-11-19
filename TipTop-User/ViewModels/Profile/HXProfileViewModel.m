//
//  HXProfileViewModel.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileViewModel.h"
#import "HXAppApiRequest.h"
#import "DateTools.h"
#import "HXUserSession.h"

typedef void(^BLOCK)(void);

static NSString *ProfileApi = @"/profile";
static NSString *CaseListApi = @"/case";

@implementation HXProfileViewModel {
    NSString *_token;
    BLOCK _completedBlock;
    
    NSArray *_rowTypes;
}

#pragma mark - Class Methods
+ (instancetype)instanceWithToken:(NSString *)token {
    return [[HXProfileViewModel alloc] initWithToken:token];
}

#pragma mark - Init Methods
- (instancetype)initWithToken:(NSString *)token {
    self = [super init];
    if (self) {
        _token = [token copy];
    }
    return self;
}

#pragma mark - Setter And Getter
- (CGFloat)selectedHeight {
    return _profile ? 44.0f : 0.0f;
}

- (CGFloat)editHeight {
    return _profile ? 60.0f : 0.0f;
}

- (CGFloat)nullContentHeight {
    return _profile ? 240.0f : 0.0f;
}

- (CGFloat)cardHeight {
    return  _profile ? 200.0f : 0.0f;
}

static NSInteger RegularRow = 4;
- (NSInteger)rows {
    return (_profile ? ((_selectType && _cases.count) ? RegularRow+2 : RegularRow): 0);
}

- (BOOL)hasIntroduce {
//    return _profile.introduce ? YES : NO;
    return YES;
}

- (HXCase *)selectedCase {
    return _cases.count ? _cases[_selectIndex] : nil;
}

#pragma mark - Public Methods
- (void)requestWithType:(HXProfileSelectType)type completed:(void(^)(void))completed {
    _selectType = type;
    _completedBlock = completed;
    switch (type) {
        case HXProfileSelectTypeIntroduce: {
            [self startProfileReuqestWithParameters:@{@"access_token": _token}];
            break;
        }
        case HXProfileSelectTypeCase: {
            [self startCasesReuqestWithParameters:@{@"access_token": _token}];
            break;
        }
    }
}

#pragma mark - Private Methods
- (void)setupRowTypes {
    _rowTypes = @[@(HXProfileCellRowHeader),
                  @(HXProfileCellRowSelected),
                  @(HXProfileCellRowEdit)];
}

- (void)reloadRowTypes {
    [self setupRowTypes];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:_rowTypes];
    switch (_selectType) {
        case HXProfileSelectTypeIntroduce: {
            [array addObject:(self.hasIntroduce ? @(HXProfileCellRowIntroduce) : @(HXProfileCellRowNoContent))];
            break;
        }
        case HXProfileSelectTypeCase: {
            if (_cases.count) {
                [array addObject:@(HXProfileCellRowCaseContent)];
                [array addObject:@(HXProfileCellRowCaseCard)];
                [array addObject:@(HXProfileCellRowIntroduce)];
            } else {
                [array addObject:@(HXProfileCellRowNoContent)];
            }
            break;
        }
    }
    _rowTypes = [array copy];
}

- (void)startProfileReuqestWithParameters:(NSDictionary *)parameters {
    [self setupRowTypes];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:ProfileApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleProfileData:responseObject[@"data"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)startCasesReuqestWithParameters:(NSDictionary *)parameters {
    [self setupRowTypes];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:CaseListApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleCasesData:responseObject[@"data"][@"list"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleProfileData:(NSDictionary *)data {
    if (data) {
        _profile = [HXProfile mj_objectWithKeyValues:data];
    }
    [self reloadRowTypes];
    if (_completedBlock) {
        _completedBlock();
    }
}

- (void)handleCasesData:(NSArray *)lists {
    if (lists) {
        _cases = nil;
        NSMutableArray *cases = [NSMutableArray arrayWithCapacity:lists.count];
        for (NSDictionary *data in lists) {
            [cases addObject:[HXCase mj_objectWithKeyValues:data]];
        }
        _cases = [cases copy];
    }
    [self reloadRowTypes];
    if (_completedBlock) {
        _completedBlock();
    }
}

@end
