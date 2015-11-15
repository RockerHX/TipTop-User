//
//  HXBiddingServiceCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBiddingService.h"

@interface HXBiddingServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet  UILabel *nameLabel;

- (void)displayWithService:(HXBiddingService *)service;

@end
