//
//  HXBiddingCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXBiddingCell.h"
#import "DateTools.h"

@implementation HXBiddingCell

#pragma mark - Public Methods
- (void)displayWithBidding:(HXBidding *)bidding {
    _biddingDateLabel.text = [[NSDate dateWithTimeIntervalSince1970:bidding.createDate] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    _deliverDateLabel.text = [[NSDate dateWithTimeIntervalSince1970:bidding.deliverDate] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    _nameLabel.text = [bidding.cate stringByAppendingFormat:@"(%@)", bidding.subCate];
}

@end
