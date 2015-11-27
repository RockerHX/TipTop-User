//
//  HXServiceViewController.h
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXServiceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;
@property (weak, nonatomic) IBOutlet UITableView *subServiceTableView;

- (IBAction)backButtonPressed;
- (IBAction)hotCallButtonPressed;

@end
