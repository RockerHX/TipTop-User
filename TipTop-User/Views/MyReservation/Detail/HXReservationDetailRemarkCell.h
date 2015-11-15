//
//  HXReservationDetailRemarkCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"

@class HXReservationDetailRemark;

@interface HXReservationDetailRemarkCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)displayWithDetailRemark:(HXReservationDetailRemark *)remark;

@end
