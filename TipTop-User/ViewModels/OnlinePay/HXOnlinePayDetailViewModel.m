//
//  HXOnlinePayDetailViewModel.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetailViewModel.h"
#import "HXAppApiRequest.h"
#import "DateTools.h"
#import "HXUserSession.h"

typedef void(^BLOCK)(void);

static NSString *OrderDetailApi = @"/order/view";

@implementation HXOnlinePayDetailViewModel {
    BLOCK _completedBlock;
    
    NSArray *_rowTypes;
    NSArray *_remarks;
}

#pragma mark - Class Methods
+ (instancetype)instanceWithOrderID:(NSString *)orderID {
    return [[HXOnlinePayDetailViewModel alloc] initWithOrderID:orderID];
}

#pragma mark - Init Methods
- (instancetype)initWithOrderID:(NSString *)orderID {
    self = [super init];
    if (self) {
        _orderID = [orderID copy];
        [self setupRowTypes];
    }
    return self;
}

#pragma mark - Setter And Getter
- (CGFloat)orderHeight {
    return _detail ? 116.0f : 0.0f;
}

- (CGFloat)adviserHeight {
    return _detail ? 110.0f : 0.0f;
}

- (CGFloat)moneyHeight {
    return _detail ? 44.0f : 0.0f;
}

- (CGFloat)remarkHeight {
    return _detail ? 50.0f : 0.0f;
}

- (CGFloat)alipayHeight {
    return _detail ? 90.0f : 0.0f;
}

- (CGFloat)payHeight {
    return _detail ? 60.0f : 0.0f;
}

static NSInteger RegularRow = 2;
- (NSInteger)rows {
    return _detail ? _rowTypes.count : 0;
}

- (NSInteger)regularRow {
    return RegularRow + 1;
}

#pragma mark - Public Methods
- (void)request:(void (^)(void))completed {
    _completedBlock = completed;
    [self startOrderDetailReuqestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken,
                                                            @"id": _orderID}];
}

- (void)removeRemark:(HXOnlinePayDetailRemark *)remark {
    NSMutableArray *remarks = [NSMutableArray arrayWithArray:_remarks];
    for (HXOnlinePayDetailRemark *item in remarks) {
        if ([item isEqual:remark]) {
            [remarks removeObject:item];
            break;
        }
    }
    _remarks = [remarks copy];
}

#pragma mark - Private Methods

- (void)setupRowTypes {
    _rowTypes = @[@(HXDetailCellRowOrder),
                  @(HXDetailCellRowClient),
                  @(HXDetailCellRowMoeny),
                  @(HXDetailCellRowRemark),
                  @(HXDetailCellRowAliPay),
                  @(HXDetailCellRowWeiXin),
                  @(HXDetailCellRowPay)];
}

- (void)startOrderDetailReuqestWithParameters:(NSDictionary *)parameters {
    [self setupRowTypes];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:OrderDetailApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleDetailData:responseObject[@"data"]];
        }
    } failure:nil];
}

- (void)handleDetailData:(NSDictionary *)data {
    if (data) {
        _detail = [HXOnlinePayDetail mj_objectWithKeyValues:data];
        
        _remarks = _detail.remarks;
        _orderDate = [[NSDate dateWithTimeIntervalSince1970:_detail.order.createTime] formattedDateWithFormat:@"yyyy-MM-dd hh:mm:ss"];
    }
    if (_completedBlock) {
        _completedBlock();
    }
}

@end
