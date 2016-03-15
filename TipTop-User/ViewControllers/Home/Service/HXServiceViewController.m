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
#import "HXServiceNormalViewController.h"
#import "HXServiceDesignerViewController.h"
#import "HXServiceCaseViewController.h"
#import "HXServiceHouseViewController.h"

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
        HXServiceListViewController *viewController = nil;
        HXCategory *category = [HXCategoryManager share].categories[_serviceSelectedIndex];
        HXCategoryListType listType = category.subItems[indexPath.row].listType;
        switch (listType) {
            case HXCategoryListTypeNormal: {
                HXServiceNormalViewController *normalServiceListViewController = [HXServiceNormalViewController instance];
                viewController = normalServiceListViewController;
                break;
            }
            case HXCategoryListTypeDesigner: {
                HXServiceDesignerViewController *serviceDesignerViewController = [HXServiceDesignerViewController instance];
                viewController = serviceDesignerViewController;
                break;
            }
            case HXCategoryListTypeCase: {
                HXServiceCaseViewController *serviceCaseViewController = [HXServiceCaseViewController instance];
                viewController = serviceCaseViewController;
                break;
            }
            case HXCategoryListTypeHouseSale: {
                HXServiceHouseViewController *serviceHouseViewController = [HXServiceHouseViewController instance];
                viewController = serviceHouseViewController;
                break;
            }
        }
        if (!viewController) {
            return;
        }
        viewController.listType = listType;
        viewController.cid = category.ID;
        viewController.subCid = category.subItems[indexPath.row].ID;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
