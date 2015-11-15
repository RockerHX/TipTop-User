//
//  HXReservationDetailInfoCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXReservationDetailViewModel;

@interface HXReservationDetailInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)displayWithDetailViewModel:(HXReservationDetailViewModel *)viewModel;

@end
