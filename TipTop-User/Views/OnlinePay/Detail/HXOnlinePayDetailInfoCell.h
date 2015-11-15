//
//  HXOnlinePayDetailInfoCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXOnlinePayDetailViewModel;

@interface HXOnlinePayDetailInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

- (void)displayWithDetailViewModel:(HXOnlinePayDetailViewModel *)viewModel;

@end
