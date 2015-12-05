//
//  HXServiceDetialContentCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceDetialContentCell.h"
#import "UIConstants.h"

@implementation HXServiceDetialContentCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [self initConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 98.0f;
}

@end
