//
//  HXMyReservationCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/15.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXReservationOrder.h"


@class HXMyReservationCell;

@protocol HXMyReservationCellDelegate <NSObject>

@optional
- (void)orderCell:(HXMyReservationCell *)cell shouldCallPhone:(NSString *)phoneNumber;
- (void)orderCell:(HXMyReservationCell *)cell shouldSendOrder:(NSString *)orderID;

@end

@interface HXMyReservationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet      id  <HXMyReservationCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

- (IBAction)phoneButonPressed;
- (IBAction)sendButonPressed;

- (void)displayWithOrder:(HXReservationOrder *)order;

@end