//
//  HXOnlinePayDetailPayCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/20.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetailPayCell.h"
#import "HXOnlinePayDetail.h"

@implementation HXOnlinePayDetailPayCell

- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order {
    _moneyLabel.text = @(order.money).stringValue;
}

@end
