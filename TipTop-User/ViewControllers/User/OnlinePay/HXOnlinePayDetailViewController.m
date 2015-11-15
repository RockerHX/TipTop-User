//
//  HXOnlinePayDetailViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/28.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOnlinePayDetailViewController.h"
#import "HXOnlinePayDetailViewModel.h"
#import "MJRefresh.h"
#import "HXOnlinePayDetailInfoCell.h"
#import "HXOnlinePayDetailClientCell.h"
#import "UIAlertView+BlocksKit.h"

@interface HXOnlinePayDetailViewController ()

@end

@implementation HXOnlinePayDetailViewController {
    HXOnlinePayDetailViewModel *_viewModel;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _viewModel = [HXOnlinePayDetailViewModel instanceWithOrderID:_orderID];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewConfig {
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameOnlinePay;
}

#pragma mark - Event Response
- (void)phoneButonPressed {
    NSString *moblie = _viewModel.detail.order.clientMobile;
    [UIAlertView bk_showAlertViewWithTitle:@"是否拨打电话？"
                                   message:moblie
                         cancelButtonTitle:@"拨打"
                         otherButtonTitles:@[@"取消"] handler:
     ^(UIAlertView *alertView, NSInteger buttonIndex) {
         if (buttonIndex == alertView.cancelButtonIndex) {
             NSString *mobile = [[NSString alloc] initWithFormat:@"tel:%@", moblie];
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobile]];
         }
     }];
}

#pragma mark - Private Methods
- (void)loadData {
    __weak __typeof__(self)weakSelf = self;
    [_viewModel request:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)endLoad {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXDetailCellRow rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXDetailCellRowInfo: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailInfoCell class]) forIndexPath:indexPath];
            [(HXOnlinePayDetailInfoCell *)cell displayWithDetailViewModel:_viewModel];
            break;
        }
        case HXDetailCellRowClient: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailClientCell class]) forIndexPath:indexPath];
            [(HXOnlinePayDetailClientCell *)cell displayWithDetailOrder:_viewModel.detail.order];
            break;
        }
        case HXDetailCellRowPrompt: {
            break;
        }
        case HXDetailCellRowRemark: {
            break;
        }
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row >= _viewModel.regularRow) ? YES : NO;
}

#pragma mark - Table View Delegete Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXDetailCellRow row = [_viewModel.rowTypes[indexPath.row] integerValue];
    __weak __typeof__(self)weakSelf = self;
    switch (row) {
        case HXDetailCellRowInfo: {
            height = _viewModel.infoHeight;
            break;
        }
        case HXDetailCellRowClient: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailClientCell class])
                                              cacheByIndexPath:indexPath
                                                 configuration:
                      ^(HXOnlinePayDetailClientCell *cell) {
                          __strong __typeof__(self)strongSelf = weakSelf;
                          [cell displayWithDetailOrder:strongSelf->_viewModel.detail.order];
                      }];
            break;
        }
        case HXDetailCellRowPrompt: {
            break;
        }
        case HXDetailCellRowRemark: {
            break;
        }
    }
    return height;
}

@end
