//
//  HXProfileIntroduceCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXProfileViewModel;

@interface HXProfileIntroduceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
