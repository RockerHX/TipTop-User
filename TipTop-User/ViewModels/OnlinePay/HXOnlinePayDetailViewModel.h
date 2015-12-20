//
//  HXOnlinePayDetailViewModel.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXOnlinePayDetail.h"

typedef NS_ENUM(NSUInteger, HXDetailCellRow) {
    HXDetailCellRowOrder,
    HXDetailCellRowClient,
    HXDetailCellRowMoeny,
    HXDetailCellRowRemark,
    HXDetailCellRowAliPay,
    HXDetailCellRowWeiXin,
    HXDetailCellRowPay,
};


@interface HXOnlinePayDetailViewModel : NSObject

@property (nonatomic, assign, readonly)   CGFloat  orderHeight;
@property (nonatomic, assign, readonly)   CGFloat  adviserHeight;
@property (nonatomic, assign, readonly)   CGFloat  moneyHeight;
@property (nonatomic, assign, readonly)   CGFloat  remarkHeight;
@property (nonatomic, assign, readonly)   CGFloat  alipayHeight;
@property (nonatomic, assign, readonly)   CGFloat  payHeight;
@property (nonatomic, assign, readonly) NSInteger  rows;
@property (nonatomic, assign, readonly) NSInteger  regularRow;
@property (nonatomic, copy, readonly)    NSString *orderID;

@property (nonatomic, strong, readonly)   NSArray *rowTypes;
@property (nonatomic, strong, readonly)   NSArray *remarks;

@property (nonatomic, strong, readonly) HXOnlinePayDetail *detail;
@property (nonatomic, copy, readonly)            NSString *orderDate;

+ (instancetype)instanceWithOrderID:(NSString *)orderID;
- (instancetype)initWithOrderID:(NSString *)orderID;

- (void)request:(void(^)(void))completed;

- (void)removeRemark:(HXOnlinePayDetailRemark *)remark;

@end
