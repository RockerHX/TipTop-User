//
//  SCAppApiRequest.m
//
//  Created by Andy Shaw on 15/8/11.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import "HXAppApiRequest.h"


#pragma mark - Prompt
NSString *const NetWorkingError = @"网络出错了，请稍后再试>_<!";
NSString *const DataError       = @"数据出错了，正在紧张处理中，请稍后>_<!";
NSString *const JsonParseError  = @"数据出错，请联系顶呱呱！";


static NSString *const CustomRequestHeaderKey   = @"";                // 请求头加密Key
static NSString *const CustomRequestHeaderValue = @"";     // 请求头加密Value

static NSString *const TokenRequestHeaderKey    = @"token";                    // 请求头token的Key
static NSString *const UIDRequestHeaderKey      = @"uid";                      // 请求头uid的Key


@implementation HXAppApiRequest

#pragma mark - Private Methods
/**
 *  通过导入工程的cer秘钥文件设置安全策略
 *
 *  @return AFSecurityPolicy实例
 */
- (void)customSecurityPolicy {
    @try {
        /**** SSL Pinning ****/
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];                    // 获取cer秘钥文件路径
        NSData *certData = [NSData dataWithContentsOfFile:cerPath];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = NO;                                                           // 不允许使用无效证书
        securityPolicy.pinnedCertificates = @[certData];
        /**** SSL Pinning ****/
        self.securityPolicy = securityPolicy;
//        self.requestSerializer.cachePolicy = NSURLRequestReloadRevalidatingCacheData;
    }
    @catch (NSException *exception) {
        NSLog(@"%s:%@", __FUNCTION__, exception.reason);
    }
    @finally {
    }
}

- (void)customResponseSerializer {
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
}

/**
 *  为请求添加自定义的KEY
 */
- (void)addHeader {
    [self.requestSerializer setValue:CustomRequestHeaderValue forHTTPHeaderField:CustomRequestHeaderKey];
}

@end
