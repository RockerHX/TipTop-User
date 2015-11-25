//
//  HXHomePageSubCategoryView.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomePageSubCategoryView.h"
#import "HXHomePageCategoryItemView.h"
#import "HXCategory.h"

@implementation HXHomePageSubCategoryView

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
#pragma mark - Config Methods
- (void)initConfig {
    _carousel.type = iCarouselTypeLinear;
    _carousel.pagingEnabled = YES;
}

- (void)viewConfig {
    
}

#pragma mark - Public Methods

#pragma mark - Setter And Getter
- (void)setItems:(NSArray *)items {
    _items = items;
    [_carousel reloadData];
}

#pragma mark - iCarousel Data Source Methods
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    //return the total number of items in the carousel
    return [_items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    HXHomePageCategoryItemView *itemView = nil;
    //create new view if no view is available for recycling
    if (!view){
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, carousel.frame.size.width, carousel.frame.size.height)];
        itemView = [[HXHomePageCategoryItemView alloc] initWithFrame:view.bounds];
        itemView.tag = 1;
        [view addSubview:itemView];
    } else {
        //get a reference to the label in the recycled view
        itemView = (HXHomePageCategoryItemView *)[view viewWithTag:1];
    }
    
    if ((_items.count) && (index < _items.count)) {
        itemView.titleLabel.text = _items[index].name;
    }
    
    return view;
}

#pragma mark - iCarousel Delegate Methods
- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option) {
        case iCarouselOptionSpacing: {
            //add a bit of spacing between the item views
            return value * 1.02f;
            break;
        }
        default: {
            return value;
        }
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    if (_items.count) {
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    if (_items.count) {
    }
}

@end

