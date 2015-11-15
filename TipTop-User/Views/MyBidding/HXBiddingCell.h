//
//  HXBiddingCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBidding.h"

@interface HXBiddingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *biddingDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliverDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)displayWithBidding:(HXBidding *)bidding;

@end
