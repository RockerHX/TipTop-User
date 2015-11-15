//
//  HXProfileIntroduceCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileIntroduceCell.h"
#import "HXProfileViewModel.h"
#import "UIConstants.h"

@implementation HXProfileIntroduceCell

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 40.0f;
}

- (void)viewConfig {
    
}

#pragma mark - Public Methods
- (void)displayWithViewModel:(HXProfileViewModel *)viewModel {
    _contentLabel.text = viewModel.selectType ? viewModel.selectedCase.caseIntroduce : viewModel.profile.introduce;
}

@end
