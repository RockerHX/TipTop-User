//
//  HXMyBiddingViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXMyBiddingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet      UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)biddingButtonPressed:(UIButton *)sender;

@end
