//
//  HXServiceViewController.m
//  TipTop-Adviser
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceViewController.h"
#import "MBProgressHUD.h"
#import "HXServiceCell.h"
#import "HXSubServiceCell.h"
#import "HXCategoryManager.h"
#import "UIAlertView+BlocksKit.h"

@interface HXServiceViewController ()
@end

@implementation HXServiceViewController {
    NSInteger _serviceSelectedIndex;
    NSInteger _subServiceSelectedIndex;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _serviceSelectedIndex = -1;
}

- (void)viewConfig {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 36.0f, 36.0f);
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -16.0f, 0.0f, 0.0f);
    [button setImage:[UIImage imageNamed:@"C-BackIcon"] forState:UIControlStateNormal];
    [button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - Event Response
- (IBAction)hotCallButtonPressed {
    [UIAlertView bk_showAlertViewWithTitle:@"拨打24小时热线？"
                                   message:@"400-962540"
                         cancelButtonTitle:@"拨打"
                         otherButtonTitles:@[@"取消"]
                                   handler:
     ^(UIAlertView *alertView, NSInteger buttonIndex) {
         if (buttonIndex == alertView.cancelButtonIndex) {
             ;
         }
     }];
}

#pragma mark - Private Methods

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<HXCategory *> *categories = [HXCategoryManager share].categories;
    if ([tableView isEqual:_serviceTableView]) {
        return categories.count;
    } else if ([tableView isEqual:_subServiceTableView]) {
        return ((_serviceSelectedIndex >= 0) ? (categories[_serviceSelectedIndex]).subItems.count : 0);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<HXCategory *> *categories = [HXCategoryManager share].categories;
    if ([tableView isEqual:_serviceTableView]) {
        HXServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXServiceCell class]) forIndexPath:indexPath];
        [cell displayWithService:categories[indexPath.row]];
        return cell;
    } else if ([tableView isEqual:_subServiceTableView]) {
        HXSubServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXSubServiceCell class]) forIndexPath:indexPath];
        [cell displayWithSubService:(categories[_serviceSelectedIndex]).subItems[indexPath.row]];
        return cell;
    }
    return nil;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_serviceTableView]) {
        _serviceSelectedIndex = indexPath.row;
        [_subServiceTableView reloadData];
    } else if ([tableView isEqual:_subServiceTableView]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        _subServiceSelectedIndex = indexPath.row;
        
    }
}

@end
