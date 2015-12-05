//
//  HXDetailCommentCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXDetailCommentCell.h"
#import "UIConstants.h"
#import "HXComment.h"
#import "HXStarView.h"
#import "DateTools.h"

@implementation HXDetailCommentCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [self initConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 23.0f;
}

#pragma mark - Public Methods
- (void)displayWithComment:(HXComment *)comment {
    _starView.value = comment.star;
    _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:comment.createDate] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    _contentLabel.text = comment.content;
}

@end
