//
//  HXOrderAlertView.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXNewOrder.h"

@interface HXOrderAlertView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet      UIView *containerView;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)hanleButtonPressed;

+ (instancetype)showWithNewOrder:(HXNewOrder *)newOrder hanlde:(void(^)(HXNewOrder *newOrder))handle;

- (void)showWithNewOrder:(HXNewOrder *)newOrder hanlde:(void(^)(HXNewOrder *newOrder))handle;
- (void)hidden;

@end
