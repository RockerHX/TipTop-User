//
//  HXCaseContentCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/12.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXProfileViewModel;

@interface HXCaseContentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
