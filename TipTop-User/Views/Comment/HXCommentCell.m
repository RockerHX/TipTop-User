//
//  HXCommentCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCommentCell.h"
#import "UIConstants.h"
#import "DateTools.h"
#import "UIImageView+WebCache.h"

@implementation HXCommentCell

- (void)awakeFromNib {
    _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 80.0f;
}

- (void)displayWithComment:(HXComment *)comment {
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:comment.clientAvatar]];
    
    _nameLabel.text = comment.clientName;
    _mobileLabel.text = comment.clientMobile;
    _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:comment.createDate] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    _starView.value = comment.star;
    _contentLabel.text = comment.content;
}

@end
