//
//  HXNormalFilterListView.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXNormalFilterListViewDelegate <NSObject>

@required
- (void)leftFilterDidTap;

@end

@interface HXNormalFilterListView : UIView

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

- (IBAction)leftButtonPressed;
- (IBAction)rightButtonPressed;

@end
