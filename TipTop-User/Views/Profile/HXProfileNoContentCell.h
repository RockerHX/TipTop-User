//
//  HXProfileNoContentCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXProfileViewModel.h"

@protocol HXProfileNoContentCellDelegate <NSObject>

@optional
- (void)noContentCellShouldAddSomething;

@end

@interface HXProfileNoContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet       id  <HXProfileNoContentCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet  UILabel *topPromptLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet  UILabel *bottomPromptLabel;

- (IBAction)buttonPressed;

- (void)displayWithSelectType:(HXProfileSelectType)selectType;

@end
