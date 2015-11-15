//
//  HXCaseCardCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXProfileViewModel;

@protocol HXCaseCardCellDelegate <NSObject>

@required
- (void)cardCellScrollAtIndex:(NSInteger)index;

@end

@interface HXCaseCardCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet               id  <HXCaseCardCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
