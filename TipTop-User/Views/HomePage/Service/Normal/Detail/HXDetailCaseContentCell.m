//
//  HXDetailCaseContentCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXDetailCaseContentCell.h"
#import "UIConstants.h"

@implementation HXDetailCaseContentCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [self initConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    self.contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30.0f;
}

@end
