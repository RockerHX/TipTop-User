//
//  HXOnlinePayDetailClientCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetailClientCell.h"
#import "HXOnlinePayDetail.h"
#import "UIImageView+WebCache.h"
#import "UIConstants.h"

@implementation HXOnlinePayDetailClientCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _addressLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 125.0f;
}

- (void)viewConfig {
    _clientHeader.layer.cornerRadius = _clientHeader.frame.size.height/2;
}

#pragma mark - Public Methods
- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order {
    _clientNameLabel.text = order.clientName;
    _addressLabel.text = order.address;
    [_clientHeader sd_setImageWithURL:[NSURL URLWithString:order.clientAvatar]];
}

@end
