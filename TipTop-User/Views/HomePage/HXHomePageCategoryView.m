//
//  HXHomePageCategoryView.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomePageCategoryView.h"
#import "HXHomePageCategoryItemView.h"
#import "HXCategory.h"

@implementation HXHomePageCategoryView

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
    HXCategory *category = nil;
    if (index < _items.count) {
        category = _items[index];
    }
    
    if (!view){
        CGFloat width = 80.0f;
        NSString *name = category.name;
        if (name.length == 3) {
            width = 100.0f;
        } else if (name.length == 4) {
            width = 120.0f;
        }
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, carousel.frame.size.height)];
        itemView = [HXHomePageCategoryItemView instance];
        itemView.frame = view.bounds;
        itemView.tag = 1;
        [view addSubview:itemView];
    } else {
        //get a reference to the label in the recycled view
        itemView = (HXHomePageCategoryItemView *)[view viewWithTag:1];
    }
    itemView.titleLabel.text = category.name;
    
    return view;
}

#pragma mark - iCarousel Delegate Methods
//- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
//    switch (option) {
//        case iCarouselOptionSpacing: {
//            //add a bit of spacing between the item views
//            return value * 1.02f;
//            break;
//        }
//        default: {
//            return value;
//        }
//    }
//}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    if (_items.count) {
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    if (_items.count) {
    }
}

@end
