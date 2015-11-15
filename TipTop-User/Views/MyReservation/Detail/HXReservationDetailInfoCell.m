//
//  HXReservationDetailInfoCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationDetailInfoCell.h"
#import "HXReservationDetailViewModel.h"

@implementation HXReservationDetailInfoCell

#pragma mark - Public Methods
- (void)displayWithDetailViewModel:(HXReservationDetailViewModel *)viewModel {
    _dateLabel.text = viewModel.orderDate;
}

@end
