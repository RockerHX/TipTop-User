//
//  HXServiceCaseCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXServiceCase.h"

@interface HXServiceCaseCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;

- (void)displayWithCase:(HXServiceCase *)serviceCase;

@end
