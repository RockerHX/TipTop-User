//
//  HXMapPaoPaoView.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/22.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMapPaoPaoView.h"
#import "HXStarView.h"
#import "HXAdviser.h"
#import "UIImageView+WebCache.h"

@implementation HXMapPaoPaoView

#pragma mark - Class Methods
+ (instancetype)instance {
    HXMapPaoPaoView *paopaoView = [[[NSBundle mainBundle] loadNibNamed:@"HXMapPaoPaoView" owner:self options:nil] firstObject];
    return paopaoView;
}

#pragma mark - Public Methods
- (void)displayWithAdviser:(HXAdviser *)adviser {
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:adviser.avatar]];
    _nameLabel.text = adviser.realName;
    _starView.value = adviser.star;
}

@end
