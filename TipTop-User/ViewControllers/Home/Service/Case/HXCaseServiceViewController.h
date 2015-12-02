//
//  HXCaseServiceViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceListViewController.h"

@interface HXCaseServiceViewController : HXServiceListViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet           UIView *listContentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
