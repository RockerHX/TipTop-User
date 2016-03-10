//
//  HXMyReservationCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/15.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXReservationOrder.h"

@class HXStarView;

@interface HXMyReservationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet     UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet  HXStarView *starView;
@property (weak, nonatomic) IBOutlet     UILabel *moblieLabel;
@property (weak, nonatomic) IBOutlet     UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *gootCountLabel;

- (void)displayWithOrder:(HXReservationOrder *)order;

@end