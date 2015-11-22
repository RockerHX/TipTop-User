//
//  HXOnlinePayDetailMoneyCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/22.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetailMoneyCell.h"
#import "HXOnlinePayDetail.h"

@implementation HXOnlinePayDetailMoneyCell

- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order {
    _moneyLabel.text = @(order.money).stringValue;
}

@end
