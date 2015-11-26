//
//  HXHomePageSubCategoryView.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXCategoryItem;

@protocol HXHomePageSubCategoryViewDelegate <NSObject>

@optional
- (void)subCategoryViewDidSelected:(NSString *)subID;

@end

@interface HXHomePageSubCategoryView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet               id  <HXHomePageSubCategoryViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray<HXCategoryItem *> *items;

@end
