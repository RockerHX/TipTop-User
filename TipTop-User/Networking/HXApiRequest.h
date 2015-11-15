//
//  SCApiRequest.h
//
//  Created by Andy Shaw on 14/12/25.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HXApi.h"


typedef NS_ENUM(NSInteger, HXApiRequestStatusCode) {
    HXApiRequestStatusCodeOK                    = 200,
    HXApiRequestStatusCodeCreated               = 201,
    HXApiRequestStatusCodeAccepted              = 202,
    HXApiRequestStatusCodeNoContent             = 204,
    
    HXApiRequestStatusCodeBadRequest            = 400,
    HXApiRequestStatusCodeUnauthorized          = 401,
    HXApiRequestStatusCodeForbidden             = 403,
    HXApiRequestStatusCodeNotFound              = 404,
    HXApiRequestStatusCodeRequestTimeOut        = 408,
    
    HXApiRequestStatusCodeInternalServerError   = 500
};


@interface HXApiRequest : AFHTTPRequestOperationManager

@property (nonatomic, copy, readonly) NSString *doMain;       // URL域
@property (nonatomic, copy, readonly) NSString *path;         // API路径
@property (nonatomic, copy, readonly) NSString *api;          // 请求的API

@property (nonatomic, copy, readonly) NSString *url;          // 完整的API链接地址(不带参数)
@property (nonatomic, strong, readonly)  NSURL *requstURL;    // 完整的API请求URL(不带参数)

/**
 *  初始化方法 - 通过url参数生成SCApiRequest实例
 *
 *  @param url 需要请求的链接
 *
 *  @return    SCApiRequest实例
 */
- (instancetype)initWithURL:(NSString *)url;

/**
 *  初始化方法 - 通过拼接参数doMain, path, api成请求URL来生成SCApiRequest实例
 *
 *  @param doMain URL域
 *  @param path   API路径
 *  @param api    请求的API
 *
 *  @return       SCApiRequest实例
 */
- (instancetype)initWithDoMain:(NSString *)doMain
                          path:(NSString *)path
                           api:(NSString *)api;

/**
 *  通用的GET请求方法
 *
 *  @param api        完整的API请求链接
 *  @param parameters 请求的参数集合
 *  @param uccess     请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (AFHTTPRequestOperation *)requestGETMethodsWithAPI:(NSString *)api
                                          parameters:(NSDictionary *)parameters
                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  通用的POST请求方法
 *
 *  @param api        完整的API请求链接
 *  @param parameters 请求的参数集合
 *  @param uccess     请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (AFHTTPRequestOperation *)requestPOSTMethodsWithAPI:(NSString *)api
                                           parameters:(NSDictionary *)parameters
                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
