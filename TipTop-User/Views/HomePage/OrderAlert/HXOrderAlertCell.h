//
//  HXOrderAlertCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXNewOrder;

@interface HXOrderAlertCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)displayWithNewOrder:(HXNewOrder *)newOrder row:(NSInteger)row;

@end
