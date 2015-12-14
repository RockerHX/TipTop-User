//
//  HXServiceCaseViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceListViewController.h"

@interface HXServiceCaseViewController : HXServiceListViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet           UIView *listContentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)leftButtonPressed;
- (IBAction)centerButtonPressed;
- (IBAction)rightButtonPressed;

@end
