//
//  HXNormalAdviserCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXNormalAdviserCell.h"
#import "HXStarView.h"
#import "UIConstants.h"
#import "UIImageView+WebCache.h"

@implementation HXNormalAdviserCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _serviceLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 101;
}

- (void)viewConfig {
}

#pragma mark - Event Response
- (IBAction)callButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(normalAdviserCellTakeCall:)]) {
        [_delegate normalAdviserCellTakeCall:self];
    }
}

#pragma mark - Public Methods
- (void)displayWithNormalAdviser:(HXNormalAdviser *)adviser {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:adviser.avatar]];
    _nameLabel.text = adviser.realName;
    _starView.value = adviser.star;
    _goodCountLabel.text = @(adviser.good).stringValue;
    _serviceLabel.text = [NSString stringWithFormat:@"擅长领域：%@", adviser.goodAt];
    _moblieLabel.text = adviser.mobile;

}

@end
