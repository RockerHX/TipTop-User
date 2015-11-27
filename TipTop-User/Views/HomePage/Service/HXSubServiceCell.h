//
//  HXSubServiceCell.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXCategoryItem;

@interface HXSubServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)displayWithSubService:(HXCategoryItem *)categoryItem;

@end
