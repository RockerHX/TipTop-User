//
//  HXProfileEditCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileEditCell.h"
#import "HXProfileViewModel.h"

@implementation HXProfileEditCell {
    NSString *_editIconImageName;
}

#pragma mark - Event Response
- (IBAction)addButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
        [_delegate cellShouldEdit:HXProfileEditActionAdd];
    }
}

- (IBAction)editButtonPressed {
    BOOL isEdit = [_editIconImageName isEqualToString:@"UCP-EditIcon-S"];
    if (isEdit) {
        if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
            [_delegate cellShouldEdit:HXProfileEditActionEdit];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
            [_delegate cellShouldEdit:HXProfileEditActionAdd];
        }
    }
}

- (IBAction)deleteButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(cellShouldEdit:)]) {
        [_delegate cellShouldEdit:HXProfileEditActionDelete];
    }
}

#pragma mark - Public Methods
- (void)displayWithViewModel:(HXProfileViewModel *)viewModel {
    _whiteBGView.hidden = !viewModel.hasIntroduce;
    
    BOOL isIntroduce = !viewModel.selectType;
    _editIconImageName = (isIntroduce ? @"UCP-EditIcon-S" : @"UCP-AddIcon-S");
    [_editButton setImage:[UIImage imageNamed:_editIconImageName] forState:UIControlStateNormal];
    
    if (!viewModel.cases.count) {
        isIntroduce = YES;
    }
    _addButton.hidden = isIntroduce;
    _addButtonBottomLine.hidden = isIntroduce;
    _deleteButton.hidden = isIntroduce;
    _deleteButtonBottomLine.hidden = isIntroduce;
}

@end
