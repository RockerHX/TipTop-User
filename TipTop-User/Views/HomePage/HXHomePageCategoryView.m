//
//  HXHomePageCategoryView.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomePageCategoryView.h"
#import "HXHomePageCategoryCell.h"

@implementation HXHomePageCategoryView {
    HXHomePageCategoryCell *_cell;
}

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
#pragma mark - Config Methods
- (void)initConfig {
}

- (void)viewConfig {
    
}

#pragma mark - Public Methods

#pragma mark - Setter And Getter
- (void)setItems:(NSArray *)items {
    _items = items;
    [_collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXHomePageCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXHomePageCategoryCell class]) forIndexPath:indexPath];
    HXCategory *category = _items[indexPath.row];
    [cell displayWithCategory:category];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = 60.0f;
    NSString *name = _items[indexPath.row].name;
    if (name.length == 3) {
        width = 75.0f;
    } else if (name.length == 4) {
        width = 90.0f;
    } else if (name.length == 5) {
        width = 105.0f;
    }
    return CGSizeMake(width, 40.0f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(categoryViewDidSelected:)]) {
        [_delegate categoryViewDidSelected:_items[indexPath.row].subItems];
    }
}

@end
