//
//  HXOnlinePayDetailOrderCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetailOrderCell.h"
#import "HXOnlinePayDetailViewModel.h"

@implementation HXOnlinePayDetailOrderCell

#pragma mark - Public Methods
- (void)displayWithDetailViewModel:(HXOnlinePayDetailViewModel *)viewModel {
    _dateLabel.text = viewModel.orderDate;
    _orderNumberLabel.text = viewModel.detail.order.displayID;
}

@end
