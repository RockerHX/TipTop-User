//
//  HXThemeManager.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXThemeManager.h"

static NSString *SelectedThemeKey = @"SelectedTheme";

@implementation HXThemeManager

@synthesize themeStyle = _themeStyle;
@synthesize themeColor = _themeColor;

#pragma mark - Init Methods
+ (instancetype)share {
    static HXThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXThemeManager alloc] init];
    });
    return manager;
}

#pragma mark - Setter And Getter
- (HXThemeStyle)theme {
    HXThemeStyle theme = [[[NSUserDefaults standardUserDefaults] valueForKey:SelectedThemeKey] integerValue];
    return theme;
}

- (void)setTheme:(HXThemeStyle)theme {
    _themeStyle = theme;
    [self applyTheme];
}

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
}

- (UIColor *)themeColor {
    return [self themeColorWithStyle:_themeStyle];
}

#pragma mark - Public Methods
- (void)applyTheme {
    [[NSUserDefaults standardUserDefaults] setValue:@(_themeStyle) forKey:SelectedThemeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:self.themeColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}];
}

- (UIColor *)themeColorWithStyle:(HXThemeStyle)themeStyle {
    UIColor *color = nil;
    switch (themeStyle) {
        case HXThemeStyleOrange: {
            color = [UIColor colorWithRed:252.0f/255.0f green:139.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
            break;
        }
        case HXThemeStyleDark: {
            color = [UIColor colorWithRed:242.0f/255.0f green:101.0f/255.0f blue:34.0f/255.0f alpha:1.0f];
            break;
        }
        case HXThemeStyleGraphical: {
            color = [UIColor colorWithRed:10.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0f];
            break;
        }
            
        default: {
            color = [UIApplication sharedApplication].keyWindow.tintColor;
            break;
        }
    }
    return color;
}

@end
