//
//  HXApi.m
//  MaintenanceCar
//
//  Created by Andy Shaw on 15/8/11.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import "HXApi.h"


#pragma mark - Api Domain
//NSString *const DoMain      = @"http://";
NSString *const DoMain      = @"http://115.29.45.120:8080";
NSString *const ImageDoMain = @"http://";

#pragma mark - Api Path
NSString *const CommonApiPath   = @"/yl_dgg/commonApi";
NSString *const V1ApiPath       = @"/yl_dgg/clientApi";
NSString *const V2ApiPath       = @"";
NSString *const ImagePath       = @"";
NSString *const WebViewPath     = @"/yl_dgg";


@implementation HXApi

+ (NSString *)apiURLWithApi:(NSString *)api {
    return [self V1ApiURLWithApi:api];
}

+ (NSString *)V1ApiURLWithApi:(NSString *)api {
    return [self apiURLWithPath:V1ApiPath api:api];
}

+ (NSString *)V2ApiURLWithApi:(NSString *)api {
    return [self apiURLWithPath:V2ApiPath api:api];
}

+ (NSString *)commonApiURLWithApi:(NSString *)api {
    return [self apiURLWithPath:CommonApiPath api:api];
}

+ (NSString *)apiURLWithPath:(NSString *)path api:(NSString *)api {
    return [[DoMain stringByAppendingString:path] stringByAppendingString:api];
}

+ (NSString *)imageURLWithImageName:(NSString *)imageName {
    return [[ImageDoMain stringByAppendingString:ImagePath] stringByAppendingString:imageName];
}

+ (NSString *)webViewURLWithURL:(NSString *)URL {
    return [[DoMain stringByAppendingString:WebViewPath] stringByAppendingString:URL];
}

@end


@implementation HXApiResponse

+ (instancetype)responseWithStatusCode:(NSInteger)statusCode errorCode:(NSInteger)errorCode {
    return [self responseWithStatusCode:statusCode errorCode:errorCode message:nil];
}

+ (instancetype)responseWithStatusCode:(NSInteger)statusCode errorCode:(NSInteger)errorCode message:(NSString *)message {
    HXApiResponse *response = [[HXApiResponse alloc] init];
    response.statusCode = statusCode;
    response.errorCode = errorCode;
    response.message = message;
    return response;
}

@end
