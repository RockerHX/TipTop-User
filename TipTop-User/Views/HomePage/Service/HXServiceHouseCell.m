//
//  HXServiceHouseCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceHouseCell.h"
#import "UIImageView+WebCache.h"

@implementation HXServiceHouseCell

#pragma mark - Public Methods
- (void)displayWithHouse:(HXServiceHouse *)house {
    [_thumbnail sd_setImageWithURL:[NSURL URLWithString:house.thumb]];
    _nameLabel.text = house.title;
    _contentLabel.text = house.address;
    _sizeLabel.text = [NSString stringWithFormat:@"%@平米", @(house.area).stringValue];
    _priceLabel.text = [@(house.money/10000).stringValue stringByAppendingString:house.unit];
}

@end
