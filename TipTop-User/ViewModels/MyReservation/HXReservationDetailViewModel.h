//
//  HXReservationDetailViewModel.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXReservationDetail.h"

typedef NS_ENUM(NSUInteger, HXDetailCellRow) {
    HXDetailCellRowInfo,
    HXDetailCellRowClient,
    HXDetailCellRowPrompt,
    HXDetailCellRowRemark
};


@interface HXReservationDetailViewModel : NSObject

@property (nonatomic, assign, readonly)   CGFloat  infoHeight;
@property (nonatomic, assign, readonly)   CGFloat  promptHeight;
@property (nonatomic, assign, readonly) NSInteger  rows;
@property (nonatomic, assign, readonly) NSInteger  regularRow;
@property (nonatomic, copy, readonly)    NSString *orderID;

@property (nonatomic, strong, readonly)   NSArray *rowTypes;
@property (nonatomic, strong, readonly)   NSArray *remarks;

@property (nonatomic, strong, readonly) HXReservationDetail *detail;
@property (nonatomic, copy, readonly)              NSString *orderDate;

+ (instancetype)instanceWithOrderID:(NSString *)orderID;
- (instancetype)initWithOrderID:(NSString *)orderID;

- (void)request:(void(^)(void))completed;

- (void)removeRemark:(HXReservationDetailRemark *)remark;

@end
