//
//  HXCaseCardCollectionViewCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXCase.h"

@interface HXCaseCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

- (void)displayWithCase:(HXCase *)caseIntance;

@end
