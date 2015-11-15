//
//  HXProfileSelectedCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileSelectedCell.h"

@implementation HXProfileSelectedCell

#pragma mark - Event Response
- (IBAction)buttonPressed:(UIButton *)sender {
    _bottomLineCenterX.constant = sender.center.x;
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        __strong __typeof__(self)strongSelf = weakSelf;
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(selectedCellStateChange:)]) {
            [strongSelf.delegate selectedCellStateChange:sender.tag];
        }
        BOOL isIntroduceButton = [sender isEqual:strongSelf.introduceButton];
        [strongSelf.introduceButton setTitleColor:(isIntroduceButton ? [UIColor orangeColor] : [UIColor blackColor]) forState:UIControlStateNormal];
        [strongSelf.caseButton setTitleColor:(isIntroduceButton ? [UIColor blackColor] : [UIColor orangeColor]) forState:UIControlStateNormal];
    }];
}

@end
