//
//  HXBiddingServiceViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXBiddingServiceViewController.h"
#import "HXAppApiRequest.h"
#import "MBProgressHUD.h"
#import "HXBiddingServiceCell.h"
#import "HXBiddingSubServiceCell.h"


static NSString *CategoryApi    = @"/category";

@interface HXBiddingServiceViewController ()
@end

@implementation HXBiddingServiceViewController {
    NSMutableArray *_dataList;
    
    NSInteger _serviceSelectedIndex;
    NSInteger _subServiceSelectedIndex;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _dataList = @[].mutableCopy;
    [self startCategoryDataReuqest];
}

- (void)viewConfig {
    
}

#pragma mark - Private Methods
- (void)startCategoryDataReuqest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi commonApiURLWithApi:CategoryApi] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleServicesData:responseObject[@"data"]];
            [strongSelf.serviceTableView reloadData];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

- (void)handleServicesData:(NSArray *)sevicesData {
    [_dataList removeAllObjects];
    for (NSDictionary *data in sevicesData) {
        HXBiddingService *service = [HXBiddingService mj_objectWithKeyValues:data];
        if (data) {
            [_dataList addObject:service];
        }
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_serviceTableView]) {
        return _dataList.count;
    } else if ([tableView isEqual:_subServiceTableView]) {
        return (_dataList.count ? ((HXBiddingService *)_dataList[_serviceSelectedIndex]).subServices.count : 0);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_serviceTableView]) {
        HXBiddingServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXBiddingServiceCell class]) forIndexPath:indexPath];
        [cell displayWithService:_dataList[indexPath.row]];
        return cell;
    } else if ([tableView isEqual:_subServiceTableView]) {
        HXBiddingSubServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXBiddingSubServiceCell class]) forIndexPath:indexPath];
        [cell displayWithSubService:((HXBiddingService *)_dataList[_serviceSelectedIndex]).subServices[indexPath.row]];
        return cell;
    }
    return nil;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_serviceTableView]) {
        _serviceSelectedIndex = indexPath.row;
        [_subServiceTableView reloadData];
    } else if ([tableView isEqual:_subServiceTableView]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        _subServiceSelectedIndex = indexPath.row;
        
        if (_delegate && [_delegate respondsToSelector:@selector(serviceDidSelectedServiceID:subService:)]) {
            HXBiddingService *service = _dataList[_serviceSelectedIndex];
            [_delegate serviceDidSelectedServiceID:service.ID subService:service.subServices[indexPath.row]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
