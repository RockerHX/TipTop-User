//
//  HXMapPaoPaoView.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/22.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXAdviser;
@class HXStarView;

@interface HXMapPaoPaoView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet    UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet HXStarView *starView;

+ (instancetype)instance;

- (void)displayWithAdviser:(HXAdviser *)adviser;

@end
