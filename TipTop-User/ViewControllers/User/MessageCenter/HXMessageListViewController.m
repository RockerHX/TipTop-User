//
//  HXMessageDetailViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMessageListViewController.h"
#import "HXMessageListCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HXMessageDetailViewController.h"


static NSString *MessageDetailListApi = @"/notification";

@implementation HXMessageListViewController

#pragma mark - View Controller Life Cycle
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
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMessageCenter;
}

#pragma mark - Public Methods
- (void)loadNewData {
    [self startMessageListReuqestWithParameters:@{@"access_token": [HXUserSession share].adviser.accessToken,
                                                           @"app": @"agent",
                                                           @"cid": _cid}];
}

#pragma mark - Private Methods
- (void)startMessageListReuqestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi commonApiURLWithApi:MessageDetailListApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleOrdersData:responseObject[@"data"][@"list"]];
            [strongSelf.tableView reloadData];
            [strongSelf endLoad];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)handleOrdersData:(NSArray *)ordersData {
    NSMutableArray *messageLists = [NSMutableArray arrayWithCapacity:ordersData.count];
    for (NSDictionary *data in ordersData) {
        HXMessageList *list = [HXMessageList mj_objectWithKeyValues:data];
        if (data) {
            [messageLists addObject:list];
        }
    }
    self.dataList = messageLists;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMessageListCell class]) forIndexPath:indexPath];
    [cell displayWithList:self.dataList[indexPath.row]];
    return cell;
}

#pragma mark - Table View Data Source Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXMessageListCell class]) cacheByIndexPath:indexPath configuration:^(HXMessageListCell *cell) {
        [cell displayWithList:self.dataList[indexPath.row]];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXMessageDetailViewController *listViewController = [HXMessageDetailViewController instance];
    listViewController.cid = ((HXMessageList *)self.dataList[indexPath.row]).ID;
    [self.navigationController pushViewController:listViewController animated:YES];
}

@end
