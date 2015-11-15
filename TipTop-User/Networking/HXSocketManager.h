//
//  HXSocketManager.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/23.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <SocketRocket/SRWebSocket.h>

@interface HXSocketManager : NSObject <SRWebSocketDelegate>

@property (nonatomic, strong, readonly) SRWebSocket *socket;
@property (nonatomic, strong, readonly)       NSURL *url;

@property (nonatomic, assign)             NSInteger  reConnectCount;

+ (instancetype)manager;

- (void)openWithURL:(NSURL *)url
             opened:(void(^)(HXSocketManager *manager))opened
        receiveData:(void(^)(HXSocketManager *manager, id data))receiveData
             closed:(void(^)(HXSocketManager *manager, NSInteger code))closed
             failed:(void(^)(HXSocketManager *manager, NSError *error))failed;

- (void)reConnect;
- (void)sendData:(id)data;

@end
