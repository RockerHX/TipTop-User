//
//  HXCaseCardCollectionViewCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCaseCardCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HXCaseCardCollectionViewCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
}

- (void)viewConfig {
    _cardImageView.layer.cornerRadius = 10.0f;
}

#pragma mark - Public Methods
- (void)displayWithCase:(HXCase *)caseIntance {
    [_cardImageView sd_setImageWithURL:[NSURL URLWithString:caseIntance.image]];
}

@end
