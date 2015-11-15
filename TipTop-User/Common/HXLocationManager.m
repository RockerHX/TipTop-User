//
//  HXLocationManager.m
//
//  Copyright (c) 2014年 ShiCang. All rights reserved.
//

#import "HXLocationManager.h"

typedef void(^SuccessBlock)(BMKUserLocation *userLocation, NSString *latitude, NSString *longitude);
typedef void(^FailureBlock)(NSString *latitude, NSString *longitude, NSError *error);

static HXLocationManager *manager = nil;

@interface HXLocationManager () <BMKLocationServiceDelegate> {
    SuccessBlock _successBlock;
    FailureBlock _failureBlock;
    BMKLocationService *_locationService;
}

@end

@implementation HXLocationManager

#pragma mark - Class Methods
+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXLocationManager alloc] init];
    });
    return manager;
}

#pragma mark - Location Methods
/**
 *  开启定位
 */
- (void)startLocation {
    if (!_locationService) {
        //初始化BMKLocationService
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        //设置定位精确度，默认：kCLLocationAccuracyBest
        _locationService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        _locationService.distanceFilter = 10.0f;
    }
    //启动LocationService
    if ([CLLocationManager locationServicesEnabled]) {
        [_locationService startUserLocationService];
    }
}

#pragma mark - Setter And Getter Methods
// 重构经纬度getter方法，处理经纬度数据
- (NSString *)latitude {
    NSString *latitude = _userLocation ? [@(_userLocation.location.coordinate.latitude) stringValue] : nil;
    if (!latitude) {
        latitude = @"";
    }
    return latitude;
}

- (NSString *)longitude {
    NSString *longitude = _userLocation ? [@(_userLocation.location.coordinate.longitude) stringValue] : nil;
    if (!longitude) {
        longitude = @"";
    }
    return longitude;
}

#pragma mark - Public Methods
- (void)getLocationSuccess:(void (^)(BMKUserLocation *, NSString *, NSString *))success
                   failure:(void (^)(NSString *, NSString *, NSError *))failure
{
    _successBlock = success;
    _failureBlock = failure;
    [self startLocation];
}

#pragma mark - BMKLocationService Delegate Methods
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    NSLog(@"didUpdateUserLocation lat %f,long %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
    _userLocation = userLocation;
    if ((_userLocation.location.coordinate.latitude == userLocation.location.coordinate.latitude) &&
        (_userLocation.location.coordinate.longitude == userLocation.location.coordinate.longitude))
    {
        [_locationService stopUserLocationService];
        if (_successBlock) {
            _successBlock(userLocation, self.latitude, self.longitude);
        }
    }
}

// 定位失败，设置相关操作
- (void)didFailToLocateUserWithError:(NSError *)error {
    [_locationService stopUserLocationService];
    NSLog(@"Location error:%@", error);
    _userLocation = nil;
    _locationFailure = YES;
    
    if (_failureBlock) {
        _failureBlock(@"", @"", error);
    }
}

@end
