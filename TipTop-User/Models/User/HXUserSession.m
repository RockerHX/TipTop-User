//
//  HXUserSession.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUserSession.h"


static NSString *FilePath = @"/user.data";

static HXUserSession *session = nil;

@implementation HXUserSession

#pragma mark - Class Methods
+ (nullable instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[HXUserSession alloc] init];
    });
    return session;
}

#pragma mark - Init Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self unArchive];
    }
    return self;
}

#pragma mark - Setter And Getter
- (HXUserSessionState)state {
    if (_user.uid && _user.accessToken) {
        NSDate *expired = [NSDate dateWithTimeIntervalSince1970:_user.tokenExpired];
        NSDate *now = [NSDate date];
        NSTimeInterval interval = [now timeIntervalSinceDate:expired];
        if (interval > 0) {
            return HXUserSessionStateLogout;
        } else {
            return HXUserSessionStateLogin;
        }
    } else {
        return HXUserSessionStateLogout;
    }
}

#pragma mark - Public Methods
- (void)updateUser:(nullable HXUser *)user {
    _user = user;
    [self archive];
}

- (void)updateUserAvatar:(nullable NSString *)avatarURL {
    _user.avatar = avatarURL;
    [self archive];
}

- (void)logout {
    [self updateUser:[HXUser new]];
}

#pragma mark - Private Methods
- (void)archive {
    NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:FilePath];
    [NSKeyedArchiver archiveRootObject:_user toFile:file];
}

- (void)unArchive {
    NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:FilePath];
    _user = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
}

@end
