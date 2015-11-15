//
//  SCAppApiRequest.h
//
//  Created by Andy Shaw on 15/8/11.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import "HXApiRequest.h"


FOUNDATION_EXPORT NSString *const NetWorkingError;              // 网络出错提示
FOUNDATION_EXPORT NSString *const DataError;                    // 数据出错提示
FOUNDATION_EXPORT NSString *const JsonParseError;               // 数据解析出错提示


typedef NS_ENUM(NSInteger, HXAppApiRequestErrorCode) {
    HXAppApiRequestErrorCodeNoError                   = 0,
    // Json Parse
    HXAppApiRequestErrorCodeJsonParseError            = 3840,
    // Login
    HXAppApiRequestErrorCodePhoneError                = 4001,
    HXAppApiRequestErrorCodeVerificationCodeSendError = 4002,
    HXAppApiRequestErrorCodeVerificationCodeError     = 4003,
    HXAppApiRequestErrorCodeThirdAuthorizeError       = 4004,
    HXAppApiRequestErrorCodeRefreshTokenError         = 4005,
    
    HXAppApiRequestErrorCodeOrderNotExist             = 5001
};


@interface HXAppApiRequest : HXApiRequest

@end
