//
//  HXHomePageCategoryCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomePageCategoryCell.h"

@implementation HXHomePageCategoryCell

- (void)setSelected:(BOOL)selected {
    _bgView.hidden = !selected;
    _titleLabel.textColor = selected ? [UIColor orangeColor] : [UIColor blackColor];
}

#pragma mark - Public Methods
- (void)displayWithCategory:(HXCategory *)category {
    _titleLabel.text = category.name;
    
    CGFloat width = 4.0f;
    NSString *name = category.name;
    if (name.length == 3) {
        width = 7.0f;
    } else if (name.length == 4) {
        width = 10.0f;
    } else if (name.length == 5) {
        width = 13.0f;
    }
    _leftConstraint.constant = width;
}

- (void)displayWithSubCategory:(HXCategoryItem *)subCategory {
    _titleLabel.text = subCategory.name;
}

@end
