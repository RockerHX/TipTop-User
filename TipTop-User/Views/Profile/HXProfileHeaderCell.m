//
//  HXProfileHeaderCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileHeaderCell.h"
#import "HXProfileViewModel.h"
#import "HXStarView.h"
#import "UIConstants.h"
#import "UIImageView+WebCache.h"

@implementation HXProfileHeaderCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _goodAtLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 106.0f;
}

- (void)viewConfig {
    
}

#pragma mark - Public Methods
- (void)displayWithViewModel:(HXProfileViewModel *)viewModel {
    HXProfile *profile = viewModel.profile;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:profile.avatar]];
    _nameLabel.text = profile.realName;
    _starView.value = profile.star;
    _mobileLabel.text = profile.mobile;
    _goodCountLabel.text = @(profile.good).stringValue;
    _goodAtLabel.text = profile.goodAt;
}

@end
