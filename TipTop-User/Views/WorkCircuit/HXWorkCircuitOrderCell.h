//
//  HXWorkCircuitOrderCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXWorkCircuitOrder.h"


@class HXWorkCircuitOrderCell;

@protocol HXWorkCircuitOrderCellDelegate <NSObject>

@optional
- (void)orderCell:(HXWorkCircuitOrderCell *)cell shouldCallPhone:(NSString *)phoneNumber;

@end

@interface HXWorkCircuitOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet      id  <HXWorkCircuitOrderCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *finishedIcon;

- (IBAction)phoneButonPressed;

- (void)displayWithOrder:(HXWorkCircuitOrder *)order;

@end
