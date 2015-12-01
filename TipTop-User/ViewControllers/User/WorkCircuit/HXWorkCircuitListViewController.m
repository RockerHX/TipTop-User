//
//  HXWorkCircuitListViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXWorkCircuitListViewController.h"
#import "HXWorkCircuitOrderCell.h"
#import "UIAlertView+BlocksKit.h"
#import "HXWorkCircuitDetailViewController.h"


static NSString *OrderListApi = @"/Order";

@interface HXWorkCircuitListViewController () <HXWorkCircuitOrderCellDelegate>
@end

@implementation HXWorkCircuitListViewController

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
    return @"HXWorkCircuitNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameWorkCircuit;
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
        HXWorkCircuitOrder *order = [HXWorkCircuitOrder mj_objectWithKeyValues:data];
        if (data) {
            [orders addObject:order];
        }
    }
    self.dataList = orders;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXWorkCircuitOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXWorkCircuitOrderCell class]) forIndexPath:indexPath];
    [cell displayWithOrder:self.dataList[indexPath.row]];
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXWorkCircuitOrder *order = self.dataList[indexPath.row];
    HXWorkCircuitDetailViewController *detailViewController = [HXWorkCircuitDetailViewController instance];
    detailViewController.loadURL = [NSString stringWithFormat:@"http://www.tbagame.com:8080/yl_dgg/h5/agent/order/view?id=%@&access_token=b487a6db8f621069fc6785b7b303f7de", order.ID];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - HXWorkCircuitOrderCellDelegate Methods
- (void)orderCell:(HXWorkCircuitOrderCell *)cell shouldCallPhone:(NSString *)phoneNumber {
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

@end
