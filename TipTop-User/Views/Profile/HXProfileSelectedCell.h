//
//  HXProfileSelectedCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXProfileViewModel.h"


@protocol HXProfileSelectedCellDelegate <NSObject>

@required
- (void)selectedCellStateChange:(HXProfileSelectType)type;

@end

@interface HXProfileSelectedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet       id  <HXProfileSelectedCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *introduceButton;
@property (weak, nonatomic) IBOutlet UIButton *caseButton;
@property (weak, nonatomic) IBOutlet   UIView *bottomLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineCenterX;

- (IBAction)buttonPressed:(UIButton *)sender;

@end
