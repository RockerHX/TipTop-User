//
//  HXMessageCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/9.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXMessage.h"

@interface HXMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet     UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet     UILabel *dateLabel;

- (void)displayWithMessage:(HXMessage *)message;

@end
