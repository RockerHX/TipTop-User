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


static NSString *AgentNearbyApi       = @"/agent/nearby";

typedef NS_ENUM(NSUInteger, HXHomePageConnectState) {
    HXHomePageConnectStateOnline,
    HXHomePageConnectStateOffline,
};

static NSString *NewOrderEvent = @"new_order";

@interface HXHomeViewController () <BMKMapViewDelegate>
@end

@implementation HXHomeViewController {
    NSTimer *_timer;
    CLLocationCoordinate2D _location;
    NSArray *_advisers;
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
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(displayUserLocation) userInfo:nil repeats:YES];
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [[HXSocketManager manager] openWithURL:[NSURL URLWithString:@"ws://115.29.45.120:8081"] opened:^(HXSocketManager *manager) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        [strongSelf displayWithConnectSatae:HXHomePageConnectStateOnline];
    } receiveData:^(HXSocketManager *manager, id data) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf handleData:data];
    } closed:^(HXSocketManager *manager, NSInteger code) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        [manager reConnect];
    } failed:^(HXSocketManager *manager, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf displayWithConnectSatae:HXHomePageConnectStateOffline];
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
//    NSInteger errorCode = [receiveData[@"error"] integerValue];
//    if (!errorCode) {
//        NSString *event = receiveData[@"event"];
//        NSString *extra = receiveData[@"extra"];
//        if ([event isEqualToString:NewOrderEvent]) {
//        } else if ([event isEqualToString:@""]) {
//            
//        }
//    } else {
//    }
}

- (void)displayWithConnectSatae:(HXHomePageConnectState)state {
    switch (state) {
        case HXHomePageConnectStateOnline: {
            break;
        }
        case HXHomePageConnectStateOffline: {
            break;
        }
    }
}

- (void)displayUserLocation {
    __weak __typeof__(self)weakSelf = self;
    [[HXLocationManager share] getLocationSuccess:
     ^(BMKUserLocation *userLocation, NSString *latitude, NSString *longtitude){
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf->_location = userLocation.location.coordinate;
        [strongSelf->_mapView updateLocationData:userLocation];     // 根据坐标在地图上显示位置
         [strongSelf starGetAgentNearbyRequestWithParameters:@{@"cid": @"1",
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

#pragma mark - Baidu MapView Delegate Methods
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
//    BMKAnnotationView *annotationView = [[BMKAnnotationView alloc] init];
////    annotationView.annotation =
//    return annotationView;
//}

@end
