//
//  HXListViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXAppApiRequest.h"

@interface HXListViewController : UITableViewController

@property (nonatomic, copy) NSArray *dataList;

- (void)initConfig;
- (void)viewConfig;

- (void)loadNewData;

- (void)endLoad;

@end
