//
//  HXThemeManager.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXTheme) {
    HXThemeDefault,
    HXThemeOrange,
    HXThemeDark,
    HXThemeGraphical
};

@interface HXThemeManager : NSObject

@property (nonatomic, assign) HXTheme  theme;
@property (nonatomic, strong) UIColor *themeColor;

+ (instancetype)share;

- (void)applyTheme;

@end
