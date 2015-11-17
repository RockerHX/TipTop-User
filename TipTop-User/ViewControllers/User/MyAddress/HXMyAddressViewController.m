//
//  HXMyAddressViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyAddressViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <REFrostedViewController/REFrostedViewController.h>
#import "HXLocationManager.h"
#import "HXAppApiRequest.h"
#import "MBProgressHUD.h"
#import "HXUserSession.h"
#import "UIAlertView+BlocksKit.h"


static NSString *UpdateLocationApi = @"/profile/location";

@interface HXMyAddressViewController () <BMKMapViewDelegate, BMKGeoCodeSearchDelegate>
@end

@implementation HXMyAddressViewController {
    NSTimer *_timer;
    CLLocationCoordinate2D _location;
    NSString *_address;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    [_timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    [self displayUserLocation];
    _timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(displayUserLocation) userInfo:nil repeats:YES];
}

- (void)viewConfig {
    [self configMap];
}

- (void)configMap {
    // 配置百度地图
    _mapView.buildingsEnabled  = YES;                       // 允许双指上下滑动展示3D建筑
    _mapView.showsUserLocation = YES;                       // 显示定位图层
    _mapView.userTrackingMode  = BMKUserTrackingModeFollow; // 定位跟随模式
    _mapView.zoomLevel         = 18.0f;                     // 50米比例尺
}

#pragma mark - Event Response
- (IBAction)menuButtonPressed {
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)enterButtonPressed {
    if (_location.latitude && _location.longitude && _address) {
        [self startUpdateAddressReuqestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken,
                                                                 @"lat": @(_location.latitude).stringValue,
                                                                 @"lng": @(_location.longitude).stringValue,
                                                             @"address": _address}];
    }
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyAddressNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameServicePhone;
}

#pragma mark - Private Methods
- (void)displayUserLocation {
    __weak __typeof__(self)weakSelf = self;
    [[HXLocationManager share] getLocationSuccess:^(BMKUserLocation *userLocation, NSString *latitude, NSString *longitude) {
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf->_location = userLocation.location.coordinate;
        [strongSelf->_mapView updateLocationData:userLocation];     // 根据坐标在地图上显示位置
        [strongSelf getStartAddressWithLocation:userLocation.location];
    } failure:^(NSString *latitude, NSString *longitude, NSError *error) {
    }];
}

- (void)getStartAddressWithLocation:(CLLocation *)location {
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    option.reverseGeoPoint = location.coordinate;
    BMKGeoCodeSearch *search = [[BMKGeoCodeSearch alloc] init];
    search.delegate = self;
    [search reverseGeoCode:option];
}

- (void)startUpdateAddressReuqestWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:UpdateLocationApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [UIAlertView bk_showAlertViewWithTitle:@"地址更新成功"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil handler:nil];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

#pragma mark - BMKGeoCodeSearchDelegate Methods
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    _address = result.address;
    _addressLabel.text = _address;
}

@end
