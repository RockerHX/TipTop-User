//
//  HXHomePageCategoryItemView.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomePageCategoryItemView.h"

@implementation HXHomePageCategoryItemView

#pragma mark - Class Methods
+ (instancetype)instance {
    HXHomePageCategoryItemView *itemView = [[[NSBundle mainBundle] loadNibNamed:@"HXHomePageCategoryItemView" owner:self options:nil] firstObject];
    return itemView;
}

@end
