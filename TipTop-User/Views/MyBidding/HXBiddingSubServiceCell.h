//
//  HXBiddingSubServiceCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBiddingSubService;

@interface HXBiddingSubServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)displayWithSubService:(HXBiddingSubService *)subService;

@end
