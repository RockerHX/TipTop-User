//
//  HXServiceCaseCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceCaseCell.h"
#import "UIImageView+WebCache.h"

@implementation HXServiceCaseCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    self.layer.cornerRadius = 4.0f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5f;
}

- (void)viewConfig {
    
}

#pragma mark - Public Methods
- (void)displayWithCase:(HXServiceCase *)serviceCase {
    [_thumbnail sd_setImageWithURL:[NSURL URLWithString:serviceCase.thumb]];
    _titleLabel.text = serviceCase.title;
}

@end
