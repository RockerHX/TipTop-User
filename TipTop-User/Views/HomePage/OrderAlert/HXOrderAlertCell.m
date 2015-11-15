//
//  HXOrderAlertCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOrderAlertCell.h"
#import "HXThemeManager.h"
#import "HXNewOrder.h"

typedef NS_ENUM(NSUInteger, HXNewOrderRow) {
    HXNewOrderRowSeriveName,
    HXNewOrderRowOrderNumber,
    HXNewOrderRowOrderDate,
    HXNewOrderRowClientName,
    HXNewOrderRowClientPhone,
    HXNewOrderRowServiceAddress
};

@implementation HXOrderAlertCell

#pragma mark - Public Methods
- (void)displayWithNewOrder:(HXNewOrder *)newOrder row:(NSInteger)row {
    NSString *title = nil;
    NSString *content = nil;
    UIColor *textColor = [UIColor blackColor];
    
    switch (row) {
        case HXNewOrderRowSeriveName: {
            title = @"服务项目";
            content = newOrder.cate;
            textColor = [HXThemeManager share].themeColor;
            break;
        }
        case HXNewOrderRowOrderNumber: {
            title = @"订  单  号";
//            content = newOrder.;
            break;
        }
        case HXNewOrderRowOrderDate: {
            title = @"订单时间";
//            content = newOrder.;
            break;
        }
        case HXNewOrderRowClientName: {
            title = @"客户姓名";
//            content = newOrder.;
            break;
        }
        case HXNewOrderRowClientPhone: {
            title = @"联系电话";
//            content = newOrder.;
            break;
        }
        case HXNewOrderRowServiceAddress: {
            title = @"服务地址";
            content = newOrder.address;
            break;
        }
    }
    
    _titleLabel.text = title;
    _contentLabel.text = content;
    _contentLabel.textColor = textColor;
}

@end
