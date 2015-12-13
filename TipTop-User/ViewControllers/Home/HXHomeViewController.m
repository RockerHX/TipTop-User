//
//  HXHomeViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHomeViewController.h"
#import <REFrostedViewController/REFrostedViewController.h>
#import "MBProgressHUD.h"
#import "HXSocketManager.h"
#import "HXLocationManager.h"
#import "HXAppApiRequest.h"
#import "HXAdviser.h"
#import "HXMapPaoPaoView.h"
#import "HXCategoryManager.h"
#import "HXHomePageCategoryView.h"
#import "HXHomePageSubCategoryView.h"


static NSString *AgentNearbyApi = @"/agent/nearby";
static NSString *NewOrderEvent  = @"new_order";

@interface HXHomeViewController () <BMKMapViewDelegate, HXHomePageCategoryViewDelegate, HXHomePageSubCategoryViewDelegate>
@end

@implementation HXHomeViewController {
    NSString *_cid;
    
    CLLocationCoordinate2D _location;
    NSArray *_advisers;
    
    BMKAnnotationView *_selectedAnnotationView;
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    [self displayUserLocationWithID:@"0"];
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    HXCategoryManager *categoryManager = [HXCategoryManager share];
    [categoryManager fetchCategories:^(NSArray<HXCategory *> * _Nullable categories, BOOL compeleted) {
        __strong __typeof__(self)strongSelf = weakSelf;
        if (compeleted) {
            strongSelf.categoryView.items = categories;
        }
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}

- (void)viewConfig {
    [self configMap];
}

- (void)configMap {
    // 配置百度地图
    _mapView.buildingsEnabled  = YES;                       // 允许双指上下滑动展示3D建筑
    _mapView.showsUserLocation = YES;                       // 显示定位图层
    _mapView.userTrackingMode  = BMKUserTrackingModeFollow; // 定位跟随模式
    _mapView.zoomLevel         = 15.0f;                     // 500米比例尺
}

- (void)openSocket {
    __weak __typeof__(self)weakSelf = self;
    [[HXSocketManager manager] openWithURL:[NSURL URLWithString:@"ws://115.29.45.120:8081"] opened:^(HXSocketManager *manager) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf loginAction];
    } receiveData:^(HXSocketManager *manager, id data) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf handleData:data];
    } closed:^(HXSocketManager *manager, NSInteger code) {
        [manager reConnect];
    } failed:^(HXSocketManager *manager, NSError *error) {
    }];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXHomePageNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameHome;
}

#pragma mark - Event Response
- (IBAction)callButtonPressed {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *data = @{@"event": @"order",
                         @"address": @"sb",
                             @"cid": _cid};
    [[HXSocketManager manager] sendData:data];
}

- (IBAction)avatarButtonPressed {
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)categoryButtonPressed {
    
}

#pragma mark - Private Methods
- (void)handleData:(NSString *)data {
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *receiveData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    [self hanleEventWithReceiveData:receiveData];
}

- (void)hanleEventWithReceiveData:(NSDictionary *)receiveData {
    NSInteger errorCode = [receiveData[@"error"] integerValue];
    if (!errorCode) {
        NSString *event = receiveData[@"event"];
//        NSString *extra = receiveData[@"extra"];
        if ([event isEqualToString:NewOrderEvent]) {
        } else if ([event isEqualToString:@""]) {
        }
    } else {
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)loginAction {
    NSDictionary *data = @{@"event": @"login",
                            @"type": @"client",
                    @"access_token": [HXUserSession share].user.accessToken};
    [[HXSocketManager manager] sendData:data];
}

- (void)displayUserLocationWithID:(NSString *)ID {
    _cid = ID;
    __weak __typeof__(self)weakSelf = self;
    [[HXLocationManager share] getLocationSuccess:
     ^(BMKUserLocation *userLocation, NSString *latitude, NSString *longtitude){
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf->_location = userLocation.location.coordinate;
        [strongSelf->_mapView updateLocationData:userLocation];     // 根据坐标在地图上显示位置
         [strongSelf starGetAgentNearbyRequestWithParameters:@{@"cid": ID,
                                                               @"lat": latitude,
                                                               @"lng": longtitude}];
    } failure:^(NSString *latitude, NSString *longitude, NSError *error) {
    }];
}

- (void)starGetAgentNearbyRequestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:AgentNearbyApi] parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleAdvisersWithDatas:responseObject[@"data"]];
        }
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}

- (void)handleAdvisersWithDatas:(NSArray *)datas {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:datas.count];
    for (NSDictionary *data in datas) {
        HXAdviser *adviser = [HXAdviser mj_objectWithKeyValues:data];
        [mutableArray addObject:adviser];
    }
    _advisers = [mutableArray copy];
    
    [self handleAnnotationWithAdvisers:_advisers];
}


- (void)handleAnnotationWithAdvisers:(NSArray *)advisers {
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:advisers.count];
    for (HXAdviser *adviser in advisers) {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        CLLocationCoordinate2D coor;
        coor.latitude = [adviser.latitude doubleValue];
        coor.longitude = [adviser.longtitude doubleValue];
        annotation.coordinate = coor;
        annotation.title = adviser.realName;
        [annotations addObject:annotation];
    }
    [self showAnnotationWithAnnotation:[annotations copy]];
}

- (void)showAnnotationWithAnnotation:(NSArray *)annotations {
    [_mapView addAnnotations:annotations];
}

- (void)displayAnnotationView:(BMKAnnotationView *)annotationView {
    NSArray *subViews = annotationView.paopaoView.subviews;
    HXMapPaoPaoView *paopaoView = nil;
    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:[HXMapPaoPaoView class]]) {
            paopaoView = (HXMapPaoPaoView *)subView;
            break;
        }
    }
    [paopaoView displayWithAdviser:[self adviserWithAnnotation:annotationView.annotation]];
}

- (HXAdviser *)adviserWithAnnotation:(id <BMKAnnotation>)annotation {
    HXAdviser *adviser = nil;
    for (adviser in _advisers) {
        if ([adviser.realName isEqualToString:annotation.title]) {
            return adviser;
        }
    }
    return adviser;
}

#pragma mark - Baidu MapView Delegate Methods
static NSString *annotationIdentifier = @"annotationIdentifier";
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    BMKAnnotationView *annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    HXMapPaoPaoView *paopaoView = [HXMapPaoPaoView instance];
    BMKActionPaopaoView *actionPaopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paopaoView];
    annotationView.paopaoView = actionPaopaoView;
    annotationView.image = [UIImage imageNamed:@"HP-PinIcon-O"];
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    _selectedAnnotationView.image = [UIImage imageNamed:@"HP-PinIcon-O"];
    if ([NSStringFromClass([view class]) isEqualToString:NSStringFromClass([BMKAnnotationView class])]) {
        view.image = [UIImage imageNamed:@"HP-PinIcon-B"];
        _selectedAnnotationView = view;
        [self displayAnnotationView:view];
    }
}

#pragma mark - HXHomePageCategoryViewDelegate Methods
- (void)categoryViewDidSelected:(NSArray *)subItems {
    _subCategoryView.items = subItems;
}

#pragma mark - HXHomePageSubCategoryViewDelegate Methods
- (void)subCategoryViewDidSelected:(NSString *)subID {
    [self displayUserLocationWithID:subID];
}

@end
