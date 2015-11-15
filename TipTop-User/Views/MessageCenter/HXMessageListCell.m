//
//  HXMessageCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/9.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMessageListCell.h"
#import "UIImageView+WebCache.h"
#import "DateTools.h"
#import "UIConstants.h"

static CGFloat Offset = 20.0f;

@implementation HXMessageListCell;

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20.0f - Offset*2;
}

- (void)viewConfig {
    self.layer.cornerRadius = 5.0f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5f;
}

#pragma mark - Setter And Getter Methods
- (void)setFrame:(CGRect)frame {
    frame.origin.x = frame.origin.x + Offset;
    frame.origin.y = frame.origin.y + Offset;
    frame.size.width = frame.size.width - Offset*2;
    frame.size.height = frame.size.height - Offset;
    [super setFrame:frame];
}

#pragma mark - Public Methods
- (void)displayWithList:(HXMessageList *)list {
    [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:list.thumb]];
    
    _titleLabel.text = list.title;
    _contentLabel.text = list.content;
    _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:list.createDate] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
}

@end
