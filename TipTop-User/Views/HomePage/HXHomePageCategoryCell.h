//
//  HXHomePageCategoryCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXCategory.h"

@interface HXHomePageCategoryCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet        UIImageView *bgView;
@property (weak, nonatomic) IBOutlet            UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

- (void)displayWithCategory:(HXCategory *)category;
- (void)displayWithSubCategory:(HXCategoryItem *)subCategory;

@end
