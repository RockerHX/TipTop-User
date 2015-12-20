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
#import "HXOnlinePayDetailOrderCell.h"
#import "HXOnlinePayDetailClientCell.h"
#import "HXOnlinePayDetailMoneyCell.h"
#import "HXOnlinePayDetailRemarkCell.h"
#import "HXOnlinePayDetailAliPayCell.h"
#import "HXOnlinePayDetailWeiXinCell.h"
#import "HXOnlinePayDetailPayCell.h"
#import "UIAlertView+BlocksKit.h"
#import "HXRemarkDetailViewController.h"
#import "HXApi.h"
#import "HXUserSession.h"
#import <iOS-AlipaySDK/AlipaySDK/AlipaySDK.h>

typedef NS_ENUM(NSInteger, HXAliPayCode) {
    HXAliPayCodePaySuccess    = 9000,
    HXAliPayCodePayProcessing = 8000,
    HXAliPayCodePayFailure    = 4000,
    HXAliPayCodeUserCancel    = 6001,
    HXAliPayCodeNetworkError  = 6002
};

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
    NSString *moblie = _viewModel.detail.order.agentMobile;
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

- (IBAction)remarkButonPressed {
    HXRemarkDetailViewController *remarkDetailViewController = [HXRemarkDetailViewController instance];
    remarkDetailViewController.loadURL = [HXApi webViewURLWithURL:[NSString stringWithFormat:@"/h5/agent/order/remark?id=%@&access_token=%@", _viewModel.detail.order.ID, [HXUserSession share].user.accessToken]];
    [self.navigationController pushViewController:remarkDetailViewController animated:YES];
}

- (IBAction)payButonPressed {
    __weak __typeof__(self)weakSelf = self;
    [[AlipaySDK defaultService] payOrder:_viewModel.detail.order.aliPayment fromScheme:@"com.yunlinker.dingguaguauser1" callback:^(NSDictionary *resultDic) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf alipayResult:resultDic];
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

- (void)alipayResult:(NSDictionary *)reslut {
    HXAliPayCode code = [reslut[@"resultStatus"] integerValue];
    switch (code) {
        case HXAliPayCodePaySuccess: {
            [self showAlertWithMessage:@"支付成功"];
            break;
        }
        case HXAliPayCodePayProcessing: {
            [self showAlertWithMessage:@"交易进行中"];
            break;
        }
        case HXAliPayCodePayFailure: {
            [self showAlertWithMessage:@"支付失败"];
            break;
        }
        case HXAliPayCodeUserCancel: {
            [self showAlertWithMessage:@"用户取消"];
            break;
        }
        case HXAliPayCodeNetworkError: {
            [self showAlertWithMessage:@"网络错误"];
            break;
        }
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXDetailCellRow rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXDetailCellRowOrder: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailOrderCell class]) forIndexPath:indexPath];
            [(HXOnlinePayDetailOrderCell *)cell displayWithDetailViewModel:_viewModel];
            break;
        }
        case HXDetailCellRowClient: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailClientCell class]) forIndexPath:indexPath];
            [(HXOnlinePayDetailClientCell *)cell displayWithDetailOrder:_viewModel.detail.order];
            break;
        }
        case HXDetailCellRowMoeny: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailMoneyCell class]) forIndexPath:indexPath];
            [(HXOnlinePayDetailMoneyCell *)cell displayWithDetailOrder:_viewModel.detail.order];
            break;
            break;
        }
        case HXDetailCellRowRemark: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailRemarkCell class]) forIndexPath:indexPath];
            [(HXOnlinePayDetailRemarkCell *)cell displayWithDetailOrder:_viewModel.detail.order];
            break;
        }
        case HXDetailCellRowAliPay: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailAliPayCell class]) forIndexPath:indexPath];
            break;
        }
        case HXDetailCellRowWeiXin: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailWeiXinCell class]) forIndexPath:indexPath];
            break;
        }
        case HXDetailCellRowPay: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlinePayDetailPayCell class]) forIndexPath:indexPath];
            [(HXOnlinePayDetailPayCell *)cell displayWithDetailOrder:_viewModel.detail.order];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegete Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXDetailCellRow rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXDetailCellRowOrder: {
            height = _viewModel.orderHeight;
            break;
        }
        case HXDetailCellRowClient: {
            height = _viewModel.adviserHeight;
            break;
        }
        case HXDetailCellRowMoeny: {
            height = _viewModel.moneyHeight;
            break;
        }
        case HXDetailCellRowRemark: {
            height = _viewModel.remarkHeight;
            break;
        }
        case HXDetailCellRowAliPay: {
            height = _viewModel.alipayHeight;
            break;
        }
        case HXDetailCellRowWeiXin:
        case HXDetailCellRowPay: {
            height = _viewModel.payHeight;
            break;
        }
    }
    return height;
}

@end
