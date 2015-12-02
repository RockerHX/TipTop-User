//
//  HXNormalServiceListViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/28.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceListViewController.h"

@interface HXNormalServiceListViewController : HXServiceListViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet      UIView *listContentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

- (IBAction)leftButtonPressed;
- (IBAction)rightButtonPressed;

@end
