//
//  HXUser.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <MJExtension/MJExtension.h>

@interface HXUser : NSObject

@property (nonatomic, strong)  NSString *uid;
@property (nonatomic, strong)  NSString *avatar;
@property (nonatomic, strong)  NSString *mobile;
@property (nonatomic, strong)  NSString *realName;
@property (nonatomic, strong)  NSString *accessToken;
@property (nonatomic, assign) NSInteger  tokenExpired;

@end