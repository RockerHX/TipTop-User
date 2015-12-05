//
//  HXDetailCommentCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXStarView;
@class HXComment;

@interface HXDetailCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HXStarView *starView;
@property (weak, nonatomic) IBOutlet    UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet    UILabel *contentLabel;

- (void)displayWithComment:(HXComment *)comment;

@end
