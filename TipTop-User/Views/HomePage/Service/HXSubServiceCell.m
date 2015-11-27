//
//  HXSubServiceCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXSubServiceCell.h"
#import "HXCategory.h"
#import "UIConstants.h"

@implementation HXSubServiceCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.backgroundColor = selected ? UIColorWithRGBA(246.0f, 246.0f, 246.0f, 1.0f) : [UIColor whiteColor];
}

#pragma mark - Public Methods
- (void)displayWithSubService:(HXCategoryItem *)categoryItem {
    _nameLabel.text = categoryItem.name;
}

@end
