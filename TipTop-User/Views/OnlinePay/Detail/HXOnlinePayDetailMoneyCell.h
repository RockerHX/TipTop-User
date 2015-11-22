//
//  HXOnlinePayDetailMoneyCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/22.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXOnlinePayDetailOrder;

@interface HXOnlinePayDetailMoneyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order;

@end
