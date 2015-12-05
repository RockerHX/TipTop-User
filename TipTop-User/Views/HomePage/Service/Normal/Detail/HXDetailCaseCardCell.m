//
//  HXDetailCaseCardCell.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXDetailCaseCardCell.h"
#import "HXCaseCardCollectionViewCell.h"
#import "UIConstants.h"

@implementation HXDetailCaseCardCell {
    NSArray *_cases;
}

#pragma mark - Public Methods
- (void)displayWithCases:(NSArray *)cases {
    _cases = cases;
    [_collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cases.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXCaseCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXCaseCardCollectionViewCell class]) forIndexPath:indexPath];
    [cell displayWithCase:_cases[indexPath.row]];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH - 40.0f, self.frame.size.height);
}

#pragma mark - Scroll View Delegate Methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (_delegate && [_delegate respondsToSelector:@selector(cardCellScrollAtIndex:)]) {
        [_delegate cardCellScrollAtIndex:index];
    }
}

@end
