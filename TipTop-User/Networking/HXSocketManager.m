//
//  HXSocketManager.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/23.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXSocketManager.h"

static HXSocketManager *manager = nil;

static const NSTimeInterval Interval = 30.0f;

typedef void(^OpenedBlock)(HXSocketManager *manager);
typedef void(^ReceiveBlock)(HXSocketManager *manager, id data);
typedef void(^ClosedBlock)(HXSocketManager *manager, NSInteger code);
typedef void(^FailedBlock)(HXSocketManager *manager, NSError *error);


@implementation HXSocketManager {
    NSInteger _retryCount;
    NSTimer *_timer;
    
    OpenedBlock _openedBlock;
    ReceiveBlock _receiveBlock;
    ClosedBlock _closedBlock;
    FailedBlock _failedBlock;
}

#pragma mark Class Methods
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXSocketManager alloc] init];
    });
    return manager;
}

#pragma mark - Public Methods
- (void)openWithURL:(NSURL *)url
             opened:(void(^)(HXSocketManager *manager))opened
        receiveData:(void(^)(HXSocketManager *manager, id data))receiveData
             closed:(void(^)(HXSocketManager *manager, NSInteger code))closed
             failed:(void(^)(HXSocketManager *manager, NSError *error))failed
{
    _url = url;
    _openedBlock = opened;
    _receiveBlock = receiveData;
    _closedBlock = closed;
    _failedBlock = failed;
    
    _socket = [[SRWebSocket alloc] initWithURL:url];
    _socket.delegate = self;
    [_socket open];
    
    [self startTimer];
}

- (void)startTimer {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:Interval target:self selector:@selector(sendPing) userInfo:nil repeats:YES];
}

- (void)invalidateTimer {
    [_timer invalidate];
}

- (void)reConnect {
    [self openWithURL:_url opened:_openedBlock receiveData:_receiveBlock closed:_closedBlock failed:_failedBlock];
}

- (void)sendData:(id)data {
    if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
        [_socket send:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
    }
}

#pragma mark - Private Methods
- (void)sendPing {
    if (_socket.readyState == SR_OPEN) {
        [_socket sendPing:nil];
    }
}

- (void)reTry {
    if (_retryCount <= _reConnectCount) {
        [self reConnect];
    } else {
        [self invalidateTimer];
    }
    _retryCount++;
}

#pragma mark - SRWebSocketDelegate Methods
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"%s", __FUNCTION__);
    if (_receiveBlock) {
        _receiveBlock(self, message);
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"%s", __FUNCTION__);
    _retryCount = 0;
    if (_openedBlock) {
        _openedBlock(self);
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
    if (_failedBlock) {
        _failedBlock(self, error);
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {    
    [self invalidateTimer];
    if (_closedBlock) {
        _closedBlock(self, code);
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    NSLog(@"%s", __FUNCTION__);
}

@end
