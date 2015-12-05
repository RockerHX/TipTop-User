//
//  HXOnlinePayOrderCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayOrderCell.h"
#import "UIImageView+WebCache.h"
#import "DateTools.h"

@implementation HXOnlinePayOrderCell {
    HXOnlinePayOrder *_order;
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
        [_delegate orderCell:self shouldCallPhone:_order.agentMobile];
    }
}

#pragma mark - Public Methods
- (void)displayWithOrder:(HXOnlinePayOrder *)order {
    _order = order;
    
    _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:order.createTime] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    _orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@", order.displayID];
    _orderNameLabel.text = [NSString stringWithFormat:@"%@（%@）", order.cate, order.subCate];
    _nameLabel.text = order.agentName;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:order.agentAvatar]];
}

@end
