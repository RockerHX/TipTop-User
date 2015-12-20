//
//  HXOnlinePayDetailRemarkCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/20.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetailRemarkCell.h"
#import "HXOnlinePayDetail.h"

@implementation HXOnlinePayDetailRemarkCell

#pragma mark - Public Methods
- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order {
    _remarkButton.hidden = !order.hasRemark;
}

@end
