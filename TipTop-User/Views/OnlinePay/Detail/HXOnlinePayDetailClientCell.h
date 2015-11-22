//
//  HXOnlinePayDetailClientCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXOnlinePayDetailOrder;
@class HXStarView;

@interface HXOnlinePayDetailClientCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *clientHeader;
@property (weak, nonatomic) IBOutlet     UILabel *clientNameLabel;
@property (weak, nonatomic) IBOutlet  HXStarView *starView;
@property (weak, nonatomic) IBOutlet     UILabel *serviceContent;

- (void)displayWithDetailOrder:(HXOnlinePayDetailOrder *)order;

@end
