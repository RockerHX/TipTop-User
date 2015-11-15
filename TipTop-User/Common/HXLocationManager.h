//
//  HXLocationManager.h
//
//  Copyright (c) 2014年 ShiCang. All rights reserved.
//

#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface HXLocationManager : NSObject

@property (nonatomic, strong, readonly) NSString *city;         // 当前所在城市
@property (nonatomic, strong, readonly) NSString *latitude;     // 当前位置 - 纬度
@property (nonatomic, strong, readonly) NSString *longitude;    // 当前位置 - 经度

@property (nonatomic, strong, readonly) BMKUserLocation *userLocation; // 当前地理位置信息(百度坐标)

@property (nonatomic, assign, readonly) BOOL locationFailure;

+ (instancetype)share;

/**
 *  获取位置数据
 *
 *  @param success 获取成功的回调
 *  @param failure 获取失败的回调
 */
- (void)getLocationSuccess:(void(^)(BMKUserLocation *userLocation, NSString *latitude, NSString *longitude))success
                   failure:(void(^)(NSString *latitude, NSString *longitude, NSError *error))failure;

@end
