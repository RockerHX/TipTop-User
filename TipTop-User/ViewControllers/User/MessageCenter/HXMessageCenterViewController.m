//
//  HXMessageCenterViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMessageCenterViewController.h"
#import "HXMessageCell.h"
#import "HXMessageListViewController.h"
#import "HXMessageList.h"


static NSString *MessageListApi = @"/notification/category";

@implementation HXMessageCenterViewController

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

#pragma mark - Config Methods
- (void)initConfig {
    [super initConfig];
}

- (void)viewConfig {
    [super viewConfig];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMessageCenterNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMessageCenter;
}

#pragma mark - Public Methods
- (void)loadNewData {
    [self startMessageListReuqestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken,
                                                           @"app": @"agent"}];
}

#pragma mark - Private Methods
- (void)startMessageListReuqestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi commonApiURLWithApi:MessageListApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleOrdersData:responseObject[@"data"]];
            [strongSelf.tableView reloadData];
            [strongSelf endLoad];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)handleOrdersData:(NSArray *)ordersData {
    NSMutableArray *messages = [NSMutableArray arrayWithCapacity:ordersData.count];
    for (NSDictionary *data in ordersData) {
        HXMessage *message = [HXMessage mj_objectWithKeyValues:data];
        if (data) {
            [messages addObject:message];
        }
    }
    self.dataList = messages;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMessageCell class]) forIndexPath:indexPath];
    [cell displayWithMessage:self.dataList[indexPath.row]];
    return cell;
}

#pragma mark - Table View Data Source Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXMessageListViewController *listViewController = [HXMessageListViewController instance];
    listViewController.cid = ((HXMessageList *)self.dataList[indexPath.row]).ID;
    [self.navigationController pushViewController:listViewController animated:YES];
}

@end
