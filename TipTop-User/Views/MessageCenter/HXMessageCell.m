//
//  HXMessageCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/9.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMessageCell.h"
#import "UIImageView+WebCache.h"
#import "DateTools.h"

@implementation HXMessageCell

#pragma mark - Public Methods
- (void)displayWithMessage:(HXMessage *)message {
//    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:message.clientAvatar]];
    
    _titleLabel.text = message.name;
    _subTitleLabel.text = message.title;
    _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:message.createDate] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    
    _messageCountView.hidden = ![message.badge integerValue];
    _messageCountLabel.text = message.badge;
}

@end
