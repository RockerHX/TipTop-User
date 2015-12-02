//
//  HXServiceHouseCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXServiceHouse.h"

@interface HXServiceHouseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet     UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet     UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet     UILabel *priceLabel;

- (void)displayWithHouse:(HXServiceHouse *)house;

@end
