//
//  HXApi.h
//
//  Created by Andy Shaw on 14/12/24.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Api Domain
FOUNDATION_EXPORT NSString *const DoMain;                       // 接口域名
FOUNDATION_EXPORT NSString *const ImageDoMain;                  // 图片资源域名


#pragma mark - Api Path
FOUNDATION_EXPORT NSString *const V1ApiPath;                    // V1接口路径
FOUNDATION_EXPORT NSString *const V2ApiPath;                    // V2接口路径
FOUNDATION_EXPORT NSString *const ImagePath;                    // 图片资源路径


@interface HXApi : NSObject

+ (NSString *)apiURLWithApi:(NSString *)api;
+ (NSString *)V1ApiURLWithApi:(NSString *)api;
+ (NSString *)V2ApiURLWithApi:(NSString *)api;
+ (NSString *)commonApiURLWithApi:(NSString *)api;
+ (NSString *)apiURLWithPath:(NSString *)path api:(NSString *)api;
+ (NSString *)imageURLWithImageName:(NSString *)imageName;

@end


@interface HXApiResponse : NSObject

@property (nonatomic, assign) NSInteger  statusCode;
@property (nonatomic, assign) NSInteger  errorCode;
@property (nonatomic, strong)  NSString *message;

+ (instancetype)responseWithStatusCode:(NSInteger)statusCode errorCode:(NSInteger)errorCode;
+ (instancetype)responseWithStatusCode:(NSInteger)statusCode errorCode:(NSInteger)errorCode message:(NSString *)message;

@end
