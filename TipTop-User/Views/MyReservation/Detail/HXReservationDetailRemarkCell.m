//
//  HXReservationDetailRemarkCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationDetailRemarkCell.h"
#import "HXReservationDetail.h"
#import "UIConstants.h"
#import "DateTools.h"

@implementation HXReservationDetailRemarkCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _eventLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 83.0f;
}

#pragma mark - Public Methods
- (void)displayWithDetailRemark:(HXReservationDetailRemark *)remark {
    _eventLabel.text = remark.content;
    _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:[remark.markTime integerValue]] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
}

@end
