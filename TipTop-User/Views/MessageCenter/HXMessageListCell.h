//
//  HXMessageCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/9.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXMessageList.h"

@interface HXMessageListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet     UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet     UILabel *dateLabel;

- (void)displayWithList:(HXMessageList *)list;

@end
