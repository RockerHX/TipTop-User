//
//  HXCommentCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXComment.h"
#import "HXStarView.h"

@interface HXCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet     UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet     UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet  HXStarView *starView;
@property (weak, nonatomic) IBOutlet     UILabel *contentLabel;

- (void)displayWithComment:(HXComment *)comment;

@end
