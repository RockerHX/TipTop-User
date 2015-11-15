//
//  HXBiddingSubServiceCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXBiddingSubServiceCell.h"
#import "HXBiddingService.h"
#import "UIConstants.h"

@implementation HXBiddingSubServiceCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.backgroundColor = selected ? UIColorWithRGBA(246.0f, 246.0f, 246.0f, 1.0f) : [UIColor whiteColor];
}

#pragma mark - Public Methods
- (void)displayWithSubService:(HXBiddingSubService *)subService {
    _nameLabel.text = subService.name;
}

@end
