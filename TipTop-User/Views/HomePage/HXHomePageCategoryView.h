//
//  HXHomePageCategoryView.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXCategory;

@protocol HXHomePageCategoryViewDelegate <NSObject>

@optional
- (void)categoryViewDidSelected:(NSArray *)subItems;

@end

@interface HXHomePageCategoryView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet               id  <HXHomePageCategoryViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray<HXCategory *> *items;

@end
