//
//  HXUserSession.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUser.h"

typedef NS_ENUM(BOOL, HXUserSessionState) {
    HXUserSessionStateLogout = NO,
    HXUserSessionStateLogin = YES
};

@interface HXUserSession : NSObject

@property (nonnull, nonatomic, strong, readonly)    HXUser *user;
@property (nonatomic, assign, readonly) HXUserSessionState  state;

+ (nullable instancetype)share;

- (void)updateUser:(nullable HXUser *)user;
- (void)updateUserAvatar:(nullable NSString *)avatarURL;
- (void)logout;

@end
