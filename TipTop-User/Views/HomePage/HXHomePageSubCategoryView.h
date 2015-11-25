//
//  HXHomePageSubCategoryView.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <iCarousel/iCarousel.h>

@class HXCategoryItem;

@interface HXHomePageSubCategoryView : UIView <iCarouselDelegate, iCarouselDataSource>

@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@property (nonatomic, strong) NSArray<HXCategoryItem *> *items;

@end
