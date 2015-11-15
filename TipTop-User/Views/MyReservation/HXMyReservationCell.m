//
//  HXMyReservationCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/15.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyReservationCell.h"
#import "UIImageView+WebCache.h"
#import "DateTools.h"

@implementation HXMyReservationCell {
    HXReservationOrder *_order;
}

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
}

- (void)viewConfig {
    _avatarImageView.layer.cornerRadius = _avatarImageView.frame.size.height/2;
}

#pragma mark - Event Response
- (void)phoneButonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(orderCell:shouldCallPhone:)]) {
        [_delegate orderCell:self shouldCallPhone:_order.clientMobile];
    }
}

- (IBAction)sendButonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(orderCell:shouldSendOrder:)]) {
        [_delegate orderCell:self shouldSendOrder:_order.ID];
    }
}

#pragma mark - Public Methods
- (void)displayWithOrder:(HXReservationOrder *)order {
    _order = order;
    
    _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:order.createTime] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    _orderNameLabel.text = order.cate;
    _nameLabel.text = order.clientName;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:order.clientAvatar]];
}

@end
