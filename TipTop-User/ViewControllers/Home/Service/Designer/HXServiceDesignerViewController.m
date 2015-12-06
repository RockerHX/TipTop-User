//
//  HXServiceDesignerViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceDesignerViewController.h"
#import "HXFilterListManager.h"
#import "REMenu.h"
#import "HXAppApiRequest.h"
#import "MJRefresh.h"
#import "HXServiceDesingerCell.h"
#import "MBProgressHUD.h"
#import "HXHouseDetailViewController.h"
#import "HXNormalServiceDetailViewController.h"

static NSString *ListApi = @"/agent/recommend";

@interface HXServiceDesignerViewController ()
@end

@implementation HXServiceDesignerViewController {
    NSMutableArray<HXNormalAdviser *> *_normalAdvisers;
    
    HXFilterItem *_firstFilter;
    HXFilterItem *_secondFilter;
    HXFilterItem *_thirdFilter;
    
    REMenu *_filterMenu;
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
    
    _normalAdvisers = @[].mutableCopy;
    
    _firstFilter = [[HXFilterItem alloc] init];
    _secondFilter = [[HXFilterItem alloc] init];
    _thirdFilter = [[HXFilterItem alloc] init];
    [[HXFilterListManager share] fetchFilterList:nil];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [_tableView.mj_header beginRefreshing];
}

- (void)viewConfig {
    [super viewConfig];
    
    _filterMenu = [[REMenu alloc] init];
    _filterMenu.highlightedBackgroundColor = [UIColor colorWithRed:0.784 green:0.780 blue:0.804 alpha:1.000];
    _filterMenu.highlightedSeparatorColor = [UIColor clearColor];
    _filterMenu.borderColor = [UIColor whiteColor];
    _filterMenu.backgroundColor = [UIColor whiteColor];
    _filterMenu.separatorColor = [UIColor colorWithRed:0.784 green:0.780 blue:0.804 alpha:1.000];
    _filterMenu.separatorHeight = 0.5f;
    _filterMenu.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f)];
    _filterMenu.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _filterMenu.backgroundView.backgroundColor = [UIColor colorWithWhite:0.4f alpha:0.2f];
    _filterMenu.font = [UIFont systemFontOfSize:16.0f];
}

#pragma mark - Event Response
- (IBAction)leftButtonPressed {
    __weak __typeof__(self)weakSelf = self;
    [_filterMenu closeWithCompletion:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf showFilterMenuWithItem:[HXFilterListManager share].filterList.house[0]];
    }];
}

- (IBAction)centerButtonPressed {
    __weak __typeof__(self)weakSelf = self;
    [_filterMenu closeWithCompletion:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf showFilterMenuWithItem:[HXFilterListManager share].filterList.house[1]];
    }];
}

- (IBAction)rightButtonPressed {
    __weak __typeof__(self)weakSelf = self;
    [_filterMenu closeWithCompletion:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf showFilterMenuWithItem:[HXFilterListManager share].filterList.house[2]];
    }];
}

#pragma mark - Private Methods
- (void)loadNewData {
    [self startFilterRequestWithParameters:@{@"cid": self.cid}];
}

- (void)endLoad {
    [self.tableView.mj_header endRefreshing];
}

- (void)showFilterMenuWithItem:(HXFilterListItem *)listItem {
    NSMutableArray *items = @[].mutableCopy;
    __weak __typeof__(self)weakSelf = self;
    [listItem.data enumerateObjectsUsingBlock:^(HXFilterItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong __typeof__(self)strongSelf = weakSelf;
        REMenuItem *item = [[REMenuItem alloc] initWithTitle:obj.value image:nil highlightedImage:nil action:^(REMenuItem *item) {
            [strongSelf filterDidSelectedWithKey:listItem.key value:obj.key];
        }];
        [items addObject:item];
    }];
    _filterMenu.items = [items copy];
    [_filterMenu showInView:_listContentView];
}

- (void)filterDidSelectedWithKey:(NSString *)key value:(NSString *)value {
    if (!_firstFilter.key || [_firstFilter.key isEqualToString:key]) {
        _firstFilter.key = key;
        _firstFilter.value = value;
    } else if (!_secondFilter.key || [_secondFilter.key isEqualToString:key]) {
        _secondFilter.key = key;
        _secondFilter.value = value;
    } else if (!_thirdFilter.key || [_thirdFilter.key isEqualToString:key]) {
        _thirdFilter.key = key;
        _thirdFilter.value = value;
    }
    NSMutableDictionary *parameters =@{@"cid": self.cid}.mutableCopy;
    if (_firstFilter.key.length) {
        [parameters setValue:_firstFilter.value forKey:_firstFilter.key];
    }
    if (_secondFilter.key.length) {
        [parameters setValue:_secondFilter.value forKey:_secondFilter.key];
    }
    if (_thirdFilter.key.length) {
        [parameters setValue:_thirdFilter.value forKey:_thirdFilter.key];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self startFilterRequestWithParameters:parameters.copy];
}

- (void)startFilterRequestWithParameters:(NSDictionary *)parameter {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:ListApi] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleAdvisers:responseObject[@"data"][@"list"]];
            [strongSelf.tableView reloadData];
        }
        [strongSelf endLoad];
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        [strongSelf endLoad];
    }];
}

- (void)handleAdvisers:(NSArray *)datas {
    [_normalAdvisers removeAllObjects];
    for (NSDictionary *data in datas) {
        HXNormalAdviser *normalAdviser = [HXNormalAdviser mj_objectWithKeyValues:data];
        if (normalAdviser) {
            [_normalAdvisers addObject:normalAdviser];
        }
    }
    [self updateUI];
}

- (void)updateUI {
    self.countLabel.text = @(_normalAdvisers.count).stringValue;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _normalAdvisers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXServiceDesingerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXServiceDesingerCell class]) forIndexPath:indexPath];
    [cell displayWithNormalAdviser:_normalAdvisers[indexPath.row]];
    return cell;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HXNormalServiceDetailViewController *detailViewController = [HXNormalServiceDetailViewController instance];
    detailViewController.listType = self.listType;
    detailViewController.cid = self.cid;
    detailViewController.aid = _normalAdvisers[indexPath.row].ID;
    detailViewController.canReserve = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
