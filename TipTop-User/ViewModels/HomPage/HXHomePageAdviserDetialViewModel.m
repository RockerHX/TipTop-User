//
//  HXHomePageAdviserDetialViewModel.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomePageAdviserDetialViewModel.h"
#import "HXAppApiRequest.h"
#import "DateTools.h"
#import "HXUserSession.h"

typedef void(^BLOCK)(void);

static NSString *DetailApi = @"/agent/view";

@implementation HXHomePageAdviserDetialViewModel {
    HXCategoryListType _listType;
    BLOCK _completedBlock;
    
    NSArray *_rowTypes;
}

#pragma mark - Class Methods
+ (instancetype)instanceWithListType:(HXCategoryListType)listType {
    return [[HXHomePageAdviserDetialViewModel alloc] initWithListType:listType];
}

#pragma mark - Init Methods
- (instancetype)initWithListType:(HXCategoryListType)listType {
    self = [super init];
    if (self) {
        _listType = listType;
    }
    return self;
}

#pragma mark - Setter And Getter
- (CGFloat)selectedHeight {
    return 0.0f;
}

- (CGFloat)editHeight {
    return 0.0f;
}

- (CGFloat)nullContentHeight {
    return 0.0f;
}

- (CGFloat)cardHeight {
    return 0.0f;
}

static NSInteger RegularRow = 3;
- (NSInteger)rows {
    return RegularRow;
}

- (HXCase *)selectedCase {
    return _cases.count ? _cases[_selectIndex] : nil;
}

#pragma mark - Public Methods
- (void)requestWithID:(NSString *)ID cid:(NSString *)cid completed:(void(^)(void))completed; {
    _completedBlock = completed;
    [self startProfileReuqestWithParameters:@{@"id": ID,
                                             @"cid": cid}];}

#pragma mark - Private Methods
- (void)setupRowTypes {
    HXHomePageAdviserDetialCellRow firstRow = HXHomePageAdviserDetialCellRowNormalAdviser;
    if (_listType == HXCategoryListTypeDesigner) {
        firstRow = HXHomePageAdviserDetialCellRowDesigner;
    }
    _rowTypes = @[@(firstRow),
                  @(HXHomePageAdviserDetialCellRowServiceContent),
                  @(HXHomePageAdviserDetialCellRowPersonalIntroduce)];
}

- (void)reloadRowTypes {
    [self setupRowTypes];
    
    NSMutableArray *rowTypes = [NSMutableArray arrayWithArray:_rowTypes];
    if (_cases.count) {
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowCaseContent)];
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowCase)];
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowCaseIntroduce)];
    }
    if (_advisoryAdvisers.count) {
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowAdvisoryMore)];
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowAdvisoryAdviser)];
    }
    if (_comment.count) {
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowCommentPrompt)];
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowComment)];
    }
    _rowTypes = [rowTypes copy];
}

- (void)startProfileReuqestWithParameters:(NSDictionary *)parameters {
    [self setupRowTypes];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:DetailApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleProfileData:responseObject[@"data"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleProfileData:(NSDictionary *)data {
    if (data) {
        _adviser = [HXNormalAdviser mj_objectWithKeyValues:data[@"agent"]];
        
        NSArray *cases = data[@"case"][@"list"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:cases.count];
        for (NSDictionary *dic in cases) {
            HXCase *detailCase = [HXCase mj_objectWithKeyValues:dic];
            [array addObject:detailCase];
        }
        _cases = [array copy];
        
        NSArray *advisers = data[@"recommend"];
        array = [NSMutableArray arrayWithCapacity:advisers.count];
        for (NSDictionary *dic in advisers) {
            HXNormalAdviser *adviser = [HXNormalAdviser mj_objectWithKeyValues:dic];
            [array addObject:adviser];
        }
        _advisoryAdvisers = [array copy];
    }
    [self reloadRowTypes];
    if (_completedBlock) {
        _completedBlock();
    }
}

@end
