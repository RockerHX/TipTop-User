//
//  HXSecurityCodeButton.m
//
//  Created by ShiCang on 14/12/31.
//  Copyright (c) 2014年 ShiCang. All rights reserved.
//

#import "HXSecurityCodeButton.h"


typedef void(^BLOCK)(void);

static NSTimeInterval TimeOutFlag = 1;
static NSTimeInterval TimeDuration = 60;

static NSString *TextPrompt = @"获取验证码";

@implementation HXSecurityCodeButton {
    NSTimeInterval _timeOut;
    NSTimer *_countDownTimer;
    
    BLOCK _startBlock;
    BLOCK _completeBlock;
    HXSecurityType _type;
}

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _type = HXSecurityTypeMessage;
    _duration = TimeDuration;
}

#pragma mark - Parent Methods
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    [self startCountDown];
}

#pragma mark - Private Methods
- (void)startCountDown {
    if (self.enabled) {
        _timeOut = _duration;
        [self setTitle:[NSString stringWithFormat:@"%@s", @(_timeOut)] forState:UIControlStateNormal];
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        self.enabled = NO;
        
        if (_startBlock) {
            _startBlock();
        }
    }
}

/**
 *  倒计时刷新方法
 */
- (void)timeFireMethod {
    _timeOut--;
    [self setTitle:[NSString stringWithFormat:@"%@s", @(_timeOut)] forState:UIControlStateNormal];
    
    if(_timeOut < TimeOutFlag){
        [self stop];
        _type = HXSecurityTypeCall;
    }
}

#pragma mark - Public Methods
- (void)start:(void(^)(void))start complete:(void(^)(void))complete {
    _startBlock = start;
    _completeBlock = complete;
}

- (void)stop {
    self.enabled = YES;
    [_countDownTimer invalidate];
    
    [self setTitle:TextPrompt forState:UIControlStateNormal];
    
    if (_completeBlock) {
        _completeBlock();
    }
}

#pragma mark - Delloc Methods
- (void)dealloc {
    // 如果View被移除，定时器需要废除掉
    [_countDownTimer invalidate];
}

@end
