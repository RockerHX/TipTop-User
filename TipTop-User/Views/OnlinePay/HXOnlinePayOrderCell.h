//
//  HXOnlinePayOrderCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXOnlinePayOrder.h"


@class HXOnlinePayOrderCell;

@protocol HXOnlinePayOrderCellDelegate <NSObject>

@optional
- (void)orderCell:(HXOnlinePayOrderCell *)cell shouldCallPhone:(NSString *)phoneNumber;

@end

@interface HXOnlinePayOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet      id  <HXOnlinePayOrderCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

- (IBAction)phoneButonPressed;

- (void)displayWithOrder:(HXOnlinePayOrder *)order;

@end
