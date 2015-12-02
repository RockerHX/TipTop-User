//
//  HXCaseServiceViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXCaseServiceViewController.h"
#import "HXAppApiRequest.h"
#import "MJRefresh.h"
#import "HXServiceCaseCell.h"
#import "HXServiceCaseDetailViewController.h"
#import "UIConstants.h"

static NSString *ListApi = @"/agent/houseDesign";

@interface HXCaseServiceViewController ()
@end

@implementation HXCaseServiceViewController {
    NSMutableArray<HXServiceCase *> *_cases;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    [super initConfig];
    
    _cases = @[].mutableCopy;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [_collectionView.mj_header beginRefreshing];
}

- (void)viewConfig {
    [super viewConfig];
}

#pragma mark - Private Methods
- (void)loadNewData {
    [self startFilterRequestWithParameters:@{@"cid": self.cid}];
}

- (void)endLoad {
    [_collectionView.mj_header endRefreshing];
}

- (void)startFilterRequestWithParameters:(NSDictionary *)parameter {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:ListApi] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleAdvisers:responseObject[@"data"][@"list"]];
            [strongSelf.collectionView reloadData];
        }
        [strongSelf endLoad];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)handleAdvisers:(NSArray *)datas {
    [_cases removeAllObjects];
    for (NSDictionary *data in datas) {
        HXServiceCase *serviceCase = [HXServiceCase mj_objectWithKeyValues:data];
        if (serviceCase) {
            [_cases addObject:serviceCase];
        }
    }
    [self updateUI];
}

- (void)updateUI {
    self.countLabel.text = @(_cases.count).stringValue;
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cases.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXServiceCaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXServiceCaseCell class]) forIndexPath:indexPath];
    [cell displayWithCase:_cases[indexPath.row]];
    return cell;
}

#pragma mark - Collection View Delegete Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (SCREEN_WIDTH - 60.0f)/2;
    CGFloat height = width + 20.0f;
    return (CGSize){width, height};
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HXServiceCaseDetailViewController *detailViewController = [HXServiceCaseDetailViewController instance];
    detailViewController.hid = _cases[indexPath.row].ID;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
