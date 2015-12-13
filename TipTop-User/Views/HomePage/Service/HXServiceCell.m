//
//  HXServiceCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceCell.h"
#import "UIButton+WebCache.h"
#import "UIConstants.h"

@implementation HXServiceCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    _icon.tintColor = selected ? [UIColor orangeColor] : [UIColor lightGrayColor];
    _nameLabel.textColor = selected ? [UIColor orangeColor] : [UIColor darkGrayColor];
    self.backgroundColor = selected ? [UIColor whiteColor] : UIColorWithRGBA(246.0f, 246.0f, 246.0f, 1.0f);
}

#pragma mark - Public Methods
- (void)displayWithService:(HXCategory *)category {
    [_icon sd_setImageWithURL:[NSURL URLWithString:category.icon] forState:UIControlStateNormal];
    [_icon sd_setImageWithURL:[NSURL URLWithString:category.iconActive] forState:UIControlStateSelected];
    _nameLabel.text = category.name;
}

@end
