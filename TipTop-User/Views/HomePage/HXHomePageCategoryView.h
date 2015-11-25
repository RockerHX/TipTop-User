//
//  HXHomePageCategoryView.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <iCarousel/iCarousel.h>

@class HXCategory;

@interface HXHomePageCategoryView : UIView <iCarouselDelegate, iCarouselDataSource>

@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@property (nonatomic, strong) NSArray<HXCategory *> *items;

@end
