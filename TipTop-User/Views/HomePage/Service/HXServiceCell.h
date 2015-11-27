//
//  HXServiceCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXCategory.h"

@interface HXServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet  UILabel *nameLabel;

- (void)displayWithService:(HXCategory *)category;

@end
