//
//  HXProfileNoContentCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileNoContentCell.h"

@implementation HXProfileNoContentCell

#pragma mark - Event Response
- (IBAction)buttonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(noContentCellShouldAddSomething)]) {
        [_delegate noContentCellShouldAddSomething];
    }
}

#pragma mark - Public Methods
- (void)displayWithSelectType:(HXProfileSelectType)selectType {
    _topPromptLabel.text = selectType ? @"您还没有添加成功案例" : @"您还没有添加个人简介";
    _bottomPromptLabel.text = selectType ? @"请添加成功案例" : @"请编辑个人简介";
    [_addButton setImage:[UIImage imageNamed:(selectType ? @"UCP-AddIcon-B" : @"UCP-EditIcon-B")] forState:UIControlStateNormal];
}

@end
