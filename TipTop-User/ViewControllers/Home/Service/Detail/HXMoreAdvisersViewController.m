//
//  HXMoreAdvisersViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMoreAdvisersViewController.h"
#import "HXAppApiRequest.h"
#import "HXNormalAdviserCell.h"
#import "HXNormalServiceDetailViewController.h"

static NSString *AdviserListApi = @"/agent/recommend";

@interface HXMoreAdvisersViewController ()
@end

@implementation HXMoreAdvisersViewController {
    NSMutableArray<HXNormalAdviser *> *_advisers;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Config Methods
- (void)initConfig {
    [super initConfig];
    
    _advisers = @[].mutableCopy;
}

- (void)viewConfig {
    [super viewConfig];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameList;
}

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Public Methods
- (void)loadNewData {
    [self startAdvisersRequestWithParameters:@{@"cid": _cid}];
}

- (void)startAdvisersRequestWithParameters:(NSDictionary *)parameter {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:AdviserListApi] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleAdvisers:responseObject[@"data"][@"list"]];
            [strongSelf.tableView reloadData];
        }
        [strongSelf endLoad];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)handleAdvisers:(NSArray *)datas {
    [_advisers removeAllObjects];
    for (NSDictionary *data in datas) {
        HXNormalAdviser *normalAdviser = [HXNormalAdviser mj_objectWithKeyValues:data];
        if (normalAdviser) {
            [_advisers addObject:normalAdviser];
        }
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _advisers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXNormalAdviserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXNormalAdviserCell class]) forIndexPath:indexPath];
    [cell displayWithNormalAdviser:_advisers[indexPath.row]];
    return cell;
}

#pragma mark - Table View Delegete Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    __weak __typeof__(self)weakSelf = self;
    height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXNormalAdviserCell class]) cacheByIndexPath:indexPath configuration:^(HXNormalAdviserCell *cell) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [cell displayWithNormalAdviser:strongSelf->_advisers[indexPath.row]];
    }];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXNormalServiceDetailViewController *detailViewController = [HXNormalServiceDetailViewController instance];
    detailViewController.cid = self.cid;
    detailViewController.aid = _advisers[indexPath.row].ID;
    detailViewController.canReserve = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
