//
//  HXUserSession.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUser.h"
#import "HXProfile.h"

typedef NS_ENUM(BOOL, HXUserSessionState) {
    HXUserSessionStateLogout,
    HXUserSessionStateLogin
};

@interface HXUserSession : NSObject


@property (nonnull, nonatomic, strong, readonly) NSString *avatar;
@property (nonnull, nonatomic, strong, readonly) NSString *nickName;
@property (nonnull, nonatomic, strong, readonly) NSString *mobile;

@property (nonnull, nonatomic, strong, readonly)    HXUser *user;
@property (nonnull, nonatomic, strong, readonly) HXProfile *profile;
@property (nonatomic, assign, readonly) HXUserSessionState  state;

+ (nullable instancetype)share;

- (void)updateUser:(nullable HXUser *)user;
- (void)updateProfile:(nullable HXProfile *)profile;
- (void)updateUserAvatar:(nullable NSString *)avatarURL;
- (void)logout;

@end
