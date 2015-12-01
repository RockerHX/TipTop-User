//
//  HXMyReservationListViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/15.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyReservationListViewController.h"
#import "HXMyReservationCell.h"
#import "UIAlertView+BlocksKit.h"
#import "HXReservationDetailViewController.h"
#import "MBProgressHUD.h"


static NSString *OrderListApi   = @"/Order";
static NSString *SendOrderApi   = @"/order/confirm";

@interface HXMyReservationListViewController ()
@end

@implementation HXMyReservationListViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.canPan = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.canPan = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyReservationNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyReservation;
}

#pragma mark - Config Methods
- (void)initConfig {
    [super initConfig];
}

- (void)viewConfig {
    [super viewConfig];
}

#pragma mark - Public Methods
- (void)loadNewData {
    [self startOrderListReuqestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken,
                                                        @"type": @"appointment"}];
}

#pragma mark - Private Methods
- (void)startOrderListReuqestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:OrderListApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleOrdersData:responseObject[@"data"][@"list"]];
            [strongSelf.tableView reloadData];
        }
        [strongSelf endLoad];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleOrdersData:(NSArray *)ordersData {
    NSMutableArray *orders = [NSMutableArray arrayWithCapacity:ordersData.count];
    for (NSDictionary *data in ordersData) {
        HXReservationOrder *order = [HXReservationOrder mj_objectWithKeyValues:data];
        if (data) {
            [orders addObject:order];
        }
    }
    self.dataList = orders;
}

- (void)sendOrderWithOrderID:(NSString *)orderID {
    [self startSendOrderReuqestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken,
                                                @"id": orderID}];
}

- (void)startSendOrderReuqestWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:SendOrderApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [UIAlertView bk_showAlertViewWithTitle:@"发送成功！"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil
                                           handler:nil];
        }
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXMyReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMyReservationCell class]) forIndexPath:indexPath];
    [cell displayWithOrder:self.dataList[indexPath.row]];
    return cell;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXReservationOrder *order = self.dataList[indexPath.row];
    HXReservationDetailViewController *detailViewController = [HXReservationDetailViewController instance];
    detailViewController.orderID = order.ID;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - HXWorkCircuitOrderCellDelegate Methods
- (void)orderCell:(HXMyReservationCell *)cell shouldCallPhone:(NSString *)phoneNumber {
    [UIAlertView bk_showAlertViewWithTitle:@"是否拨打电话？"
                                   message:phoneNumber
                         cancelButtonTitle:@"拨打"
                         otherButtonTitles:@[@"取消"] handler:
     ^(UIAlertView *alertView, NSInteger buttonIndex) {
         if (buttonIndex == alertView.cancelButtonIndex) {
             NSString *mobile = [[NSString alloc] initWithFormat:@"tel:%@", phoneNumber];
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobile]];
         }
     }];
}

- (void)orderCell:(HXMyReservationCell *)cell shouldSendOrder:(NSString *)orderID {
    [self sendOrderWithOrderID:orderID];
}

@end
