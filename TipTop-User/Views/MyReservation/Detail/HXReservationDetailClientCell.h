//
//  HXReservationDetailClientCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"

@class HXReservationDetailOrder;

@interface HXReservationDetailClientCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *clientHeader;
@property (weak, nonatomic) IBOutlet     UILabel *clientNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *addressLabel;

- (void)displayWithDetailOrder:(HXReservationDetailOrder *)order;

@end
