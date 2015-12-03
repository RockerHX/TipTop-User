//
//  HXNormalAdviserCell.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"
#import "HXNormalAdviser.h"

@class HXStarView;
@class HXNormalAdviserCell;

@protocol HXNormalAdviserCellDelegate <NSObject>

@optional
- (void)normalAdviserCellTakeCall:(HXNormalAdviserCell *)cell;

@end

@interface HXNormalAdviserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet          id  <HXNormalAdviserCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet  HXStarView *starView;
@property (weak, nonatomic) IBOutlet     UILabel *goodCountLabel;
@property (weak, nonatomic) IBOutlet     UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet     UILabel *moblieLabel;

- (IBAction)callButtonPressed;

- (void)displayWithNormalAdviser:(HXNormalAdviser *)adviser;

@end
