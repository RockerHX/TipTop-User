//
//  HXSecurityCodeButton.h
//
//  Created by ShiCang on 14/12/31.
//  Copyright (c) 2014年 ShiCang. All rights reserved.
//

#import "HXIBButton.h"

typedef NS_ENUM(NSUInteger, HXSecurityType) {
    HXSecurityTypeMessage,
    HXSecurityTypeCall
};

@interface HXSecurityCodeButton : HXIBButton

@property (nonatomic, assign) HXSecurityType type;
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  点击事件回调方法 - 当SCVerificationCodeLabel被点击的时候，触发此回调
 *
 *  @param block 执行代码
 */
- (void)start:(void(^)(void))start complete:(void(^)(void))complete;

/**
 *  停止计时，用于网络信号不好等时候无法获取验证码的时候，重新获取验证码
 */
- (void)stop;

@end
