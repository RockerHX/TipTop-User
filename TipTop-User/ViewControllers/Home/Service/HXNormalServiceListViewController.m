//
//  HXNormalServiceListViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/28.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXNormalServiceListViewController.h"
#import "HXFilterListManager.h"
#import "REMenu.h"
#import "HXAppApiRequest.h"
#import "MJRefresh.h"
#import "HXNormalAdviser.h"

static NSString *ListApi = @"/agent";

@interface HXNormalServiceListViewController ()
@end

@implementation HXNormalServiceListViewController {
    NSMutableArray *_normalAdvisers;
    
    HXFilterItem *_firstFilter;
    HXFilterItem *_secondFilter;
    
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
    _normalAdvisers = @[].mutableCopy;
    
    _firstFilter = [[HXFilterItem alloc] init];
    _secondFilter = [[HXFilterItem alloc] init];
    [[HXFilterListManager share] fetchFilterList:nil];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewConfig {
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

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameHome;
}

#pragma mark - Event Response
- (IBAction)leftButtonPressed {
    if (!_filterMenu.isOpen) {
        [self showFilterMenuWithItem:[[HXFilterListManager share].filterList.normal firstObject]];
    }
}

- (IBAction)rightButtonPressed {
    if (!_filterMenu.isOpen) {
        [self showFilterMenuWithItem:[[HXFilterListManager share].filterList.normal lastObject]];
    }
}

#pragma mark - Private Methods
- (void)loadNewData {
    [self startFilterRequestWithParameters:@{@"cid": _cid}];
}

- (void)endLoad {
    [self.tableView.mj_header endRefreshing];
}

- (void)showFilterMenuWithItem:(HXFilterListItem *)listItem {
    NSMutableArray *items = @[].mutableCopy;
    NSDictionary *filterData = listItem.data;
    __weak __typeof__(self)weakSelf = self;
    [filterData.allValues enumerateObjectsUsingBlock:
     ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         __strong __typeof__(self)strongSelf = weakSelf;
         REMenuItem *item = [[REMenuItem alloc] initWithTitle:obj image:nil highlightedImage:nil action:^(REMenuItem *item) {
             [strongSelf filterDidSelectedWithKey:listItem.key value:filterData.allKeys[idx]];
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
    }
    NSMutableDictionary *parameters =@{@"cid": _cid}.mutableCopy;
    if (_firstFilter.key.length) {
        [parameters setValue:_firstFilter.value forKey:_firstFilter.key];
    }
    if (_secondFilter.key.length) {
        [parameters setValue:_secondFilter.value forKey:_secondFilter.key];
    }
    [self startFilterRequestWithParameters:parameters.copy];
}

- (void)startFilterRequestWithParameters:(NSDictionary *)parameter {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:ListApi] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleAdvisers:responseObject[@"data"][@"list"]];
            [strongSelf.tableView reloadData];
            [strongSelf endLoad];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)handleAdvisers:(NSArray *)datas {
    for (NSDictionary *data in datas) {
        HXNormalAdviser *normalAdviser = [HXNormalAdviser mj_objectWithKeyValues:data];
        if (normalAdviser) {
            [_normalAdvisers addObject:normalAdviser];
        }
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray<HXCategory *> *categories = [HXCategoryManager share].categories;
//    if ([tableView isEqual:_serviceTableView]) {
//        HXServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXServiceCell class]) forIndexPath:indexPath];
//        [cell displayWithService:categories[indexPath.row]];
//        return cell;
//    } else if ([tableView isEqual:_subServiceTableView]) {
//        HXSubServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXSubServiceCell class]) forIndexPath:indexPath];
//        [cell displayWithSubService:(categories[_serviceSelectedIndex]).subItems[indexPath.row]];
//        return cell;
//    }
    return nil;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
