//
//  HXMyBiddingViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyBiddingViewController.h"
#import "HXAppApiRequest.h"
#import "MJRefresh.h"
#import "HXBiddingCell.h"
#import "HXBiddingDetailViewController.h"


typedef NS_ENUM(NSUInteger, HXBiddingSelectedType) {
    HXBiddingSelectedTypePending,
    HXBiddingSelectedTypeWin
};


static NSString *BiddingListApi   = @"/biding";

@implementation HXMyBiddingViewController {
    HXBiddingSelectedType _selectedType;
    
    NSMutableArray *_dataList;
}

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
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _dataList = @[].mutableCopy;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self startLoading];
    [self loadNewData];
}

- (void)viewConfig {
    
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyBiddingNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyBidding;
}

#pragma mark - Response Methods
- (IBAction)biddingButtonPressed:(UIButton *)sender {
    _selectedType = sender.tag;
    
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.bottomLine.center = CGPointMake(sender.center.x, strongSelf.bottomLine.center.y);
    }];
    
    [self startLoading];
    [self startBiddingListRequestWithype:_selectedType];
}

#pragma mark - Private Methods
- (void)loadNewData {
    [self startBiddingListRequestWithype:_selectedType];
}

- (void)startLoading {
    [self.tableView.mj_header beginRefreshing];
}

- (void)endLoading {
    [self.tableView.mj_header endRefreshing];
}

- (void)startBiddingListRequestWithype:(HXBiddingSelectedType)type {
    NSMutableDictionary *mutableDictionary = @{@"access_token": [HXUserSession share].adviser.accessToken}.mutableCopy;
    switch (type) {
        case HXBiddingSelectedTypePending: {
            [mutableDictionary setValue:@"pending" forKey:@"status"];
            break;
        }
        case HXBiddingSelectedTypeWin: {
            [mutableDictionary setValue:@"win" forKey:@"status"];
            break;
        }
    }
    
    NSDictionary *parameters = [mutableDictionary copy];
    [self startBiddingListReuqestWithParameters:parameters];
}

- (void)startBiddingListReuqestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:BiddingListApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleBiddingsData:responseObject[@"data"][@"list"]];
            [strongSelf.tableView reloadData];
            [strongSelf endLoading];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleBiddingsData:(NSArray *)biddingsData {
    [_dataList removeAllObjects];
    for (NSDictionary *data in biddingsData) {
        HXBidding *bidding = [HXBidding mj_objectWithKeyValues:data];
        if (data) {
            [_dataList addObject:bidding];
        }
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBiddingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXBiddingCell class]) forIndexPath:indexPath];
    [cell displayWithBidding:_dataList[indexPath.row]];
    return cell;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HXBidding *bidding = _dataList[indexPath.row];
    NSString *url = [DoMain stringByAppendingFormat:@"/h5/agent/biding/view?id=%@&access_token=%@", bidding.ID, [HXUserSession share].adviser.accessToken];
    HXBiddingDetailViewController *detailViewController = [HXBiddingDetailViewController instance];
    detailViewController.loadURL = url;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
