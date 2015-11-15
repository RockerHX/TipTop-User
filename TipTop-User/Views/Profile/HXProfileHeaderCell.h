//
//  HXProfileHeaderCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXProfileViewModel;
@class HXStarView;

@interface HXProfileHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet     UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet  HXStarView *starView;
@property (weak, nonatomic) IBOutlet     UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet     UILabel *goodCountLabel;
@property (weak, nonatomic) IBOutlet     UILabel *goodAtLabel;

- (void)displayWithViewModel:(HXProfileViewModel *)viewModel;

@end
