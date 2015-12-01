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
#import "HXNormalServiceListViewController.h"

@interface HXServiceViewController ()
@end

@implementation HXServiceViewController {
    NSInteger _serviceSelectedIndex;
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
}

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

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
        [cell displayWithSubService:categories[_serviceSelectedIndex].subItems[indexPath.row]];
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
        UIViewController *viewController = nil;
        HXCategory *category = [HXCategoryManager share].categories[_serviceSelectedIndex];
        HXCategoryListType listType = category.subItems[indexPath.row].listType;
        switch (listType) {
            case HXCategoryListTypeNormal:
            case HXCategoryListTypeDesigner: {
                HXNormalServiceListViewController *normalServiceListViewController = [HXNormalServiceListViewController instance];
                normalServiceListViewController.listType = listType;
                normalServiceListViewController.cid = category.ID;
                viewController = normalServiceListViewController;
                break;
            }
            case HXCategoryListTypeCase: {
                ;
                break;
            }
            case HXCategoryListTypeHouseSale: {
                ;
                break;
            }
        }
        if (!viewController) {
            return;
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
