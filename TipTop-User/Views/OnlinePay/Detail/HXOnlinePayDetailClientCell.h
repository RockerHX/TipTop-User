//
//  HXOnlinePayDetailClientCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"

@class HXOnlinePayDetailOrder;

@interface HXOnlinePayDetailClientCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *clientHeader;
@property (weak, nonatomic) IBOutlet     UILabel *clientNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *addressLabel;

- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order;

@end
