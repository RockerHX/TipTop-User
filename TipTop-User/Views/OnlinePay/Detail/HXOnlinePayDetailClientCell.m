//
//  HXOnlinePayDetailClientCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetailClientCell.h"
#import "HXOnlinePayDetail.h"
#import "UIImageView+WebCache.h"
#import "UIConstants.h"
#import "HXStarView.h"

@implementation HXOnlinePayDetailClientCell

#pragma mark - Public Methods
- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order {
    _clientNameLabel.text = order.agentName;
    _starView.value = order.agentStar;
    _serviceContent.text = [NSString stringWithFormat:@"%@（%@）", order.cate, order.subCate];
    [_clientHeader sd_setImageWithURL:[NSURL URLWithString:order.agentAvatar]];
}

@end
