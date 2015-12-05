//
//  HXHomePageAdviserDetialViewModel.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomePageAdviserDetialViewModel.h"
#import "HXAppApiRequest.h"

typedef void(^BLOCK)(void);

static NSString *DetailApi = @"/agent/view";
static NSString *CommentsApi = @"/agent/review";

@implementation HXHomePageAdviserDetialViewModel {
    HXCategoryListType _listType;
    BLOCK _requestCompletedBlock;
    BLOCK _commentCompletedBlock;
    
    NSArray *_rowTypes;
    
    NSString *_id;
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
- (CGFloat)designerHeight {
    return 110.0f;
}

- (CGFloat)caseCardHeight {
    return 200.0f;
}

- (CGFloat)advisoryMoreHeight {
    return 50.0f;
}

- (CGFloat)advisoryAdviserHeight {
    return 110.0f;
}

- (CGFloat)commentPromptHeight {
    return 50.0f;
}

- (NSInteger)regularRow {
    return 7;
}

- (NSInteger)rows {
    return _rowTypes.count;
}

- (HXCase *)selectedCase {
    return _cases.count ? _cases[_selectIndex] : nil;
}

#pragma mark - Public Methods
- (void)requestWithID:(NSString *)ID cid:(NSString *)cid completed:(void(^)(void))completed; {
    _id = ID;
    _requestCompletedBlock = completed;
    [self startDetialReuqestWithParameters:@{@"id": ID,
                                            @"cid": cid}];
}

- (void)fetchCommentWithID:(NSString *)ID completed:(void(^)(void))completed {
    _commentCompletedBlock = completed;
    [self startCommentsReuqestWithParameters:@{@"agent_id": ID}];
}

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
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowCaseIntroduce)];
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowCase)];
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowCaseContent)];
    }
    if (_advisoryAdvisers.count) {
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowAdvisoryMore)];
        [_advisoryAdvisers enumerateObjectsUsingBlock:
         ^(HXNormalAdviser * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             [rowTypes addObject:@(HXHomePageAdviserDetialCellRowAdvisoryAdviser)];
         }];
    }
    _rowTypes = [rowTypes copy];
}

- (void)startDetialReuqestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:DetailApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleDetailData:responseObject[@"data"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)startCommentsReuqestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:CommentsApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleCommentsData:responseObject[@"data"][@"list"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleDetailData:(NSDictionary *)data {
    if (data) {
        _adviser = [HXNormalAdviser mj_objectWithKeyValues:data[@"agent"]];
        
        NSArray *cases = data[@"cases"];
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
    
    __weak __typeof__(self)weakSelf = self;
    [self fetchCommentWithID:_id completed:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        if (strongSelf->_requestCompletedBlock) {
            strongSelf->_requestCompletedBlock();
        }
    }];
}

- (void)handleCommentsData:(NSArray *)data {
    if (data.count) {
        NSMutableArray *comments = [NSMutableArray arrayWithCapacity:data.count];
        for (NSDictionary *dic in data) {
            HXComment *comment = [HXComment mj_objectWithKeyValues:dic];
            [comments addObject:comment];
        }
        _comments = [comments copy];
    }
    
    _exceptCommentRow = _rowTypes.count + 1;
    NSMutableArray *rowTypes = [NSMutableArray arrayWithArray:_rowTypes];
    if (_comments.count) {
        [rowTypes addObject:@(HXHomePageAdviserDetialCellRowCommentPrompt)];
        [_comments enumerateObjectsUsingBlock:
         ^(HXComment * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             [rowTypes addObject:@(HXHomePageAdviserDetialCellRowComment)];
        }];
    }
    _rowTypes = [rowTypes copy];

    if (_commentCompletedBlock) {
        _commentCompletedBlock();
    }
}

@end
