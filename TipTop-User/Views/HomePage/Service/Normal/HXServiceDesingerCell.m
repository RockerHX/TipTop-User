//
//  HXServiceDesingerCell.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceDesingerCell.h"

@implementation HXServiceDesingerCell

- (void)displayWithNormalAdviser:(HXNormalAdviser *)adviser {
    [super displayWithNormalAdviser:adviser];
    _worksLabel.text = [NSString stringWithFormat:@"设计作品：%@张", @(adviser.caseTotal).stringValue];
    _reservationLabel.text = [NSString stringWithFormat:@"预约：%@次", @(adviser.orderTotal).stringValue];
}

@end
