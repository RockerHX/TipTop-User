//
//  HXOnlinePayDetailRemarkCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/20.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXOnlinePayDetailOrder;

@interface HXOnlinePayDetailRemarkCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *remarkButton;

- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order;

@end
