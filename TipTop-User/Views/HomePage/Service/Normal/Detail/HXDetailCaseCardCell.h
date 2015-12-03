//
//  HXDetailCaseCardCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXProfileViewModel;

@protocol HXDetailCaseCardCellDelegate <NSObject>

@required
- (void)cardCellScrollAtIndex:(NSInteger)index;

@end

@interface HXDetailCaseCardCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet               id  <HXDetailCaseCardCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
