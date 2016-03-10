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
#import "HXStarView.h"

@implementation HXMyReservationCell

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
}

#pragma mark - Public Methods
- (void)displayWithOrder:(HXReservationOrder *)order {
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:order.agentAvatar]];
    _nameLabel.text = order.agentName;
    _starView.value = order.star;
    _moblieLabel.text = order.agentMobile;
    _serviceNameLabel.text = order.cate;
//    _gootCountLabel.text = order.;
}

@end
