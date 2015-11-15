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

@synthesize theme = _theme;
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

#pragma mark - Public Methods
- (void)applyTheme {
    [[NSUserDefaults standardUserDefaults] setValue:@(_theme) forKey:SelectedThemeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:self.themeColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:21.0f]}];
}

#pragma mark - Setter And Getter
- (HXTheme)theme {
    HXTheme theme = [[[NSUserDefaults standardUserDefaults] valueForKey:SelectedThemeKey] integerValue];
    return theme;
}

- (void)setTheme:(HXTheme)theme {
    _theme = theme;
    [self applyTheme];
}

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
}

- (UIColor *)themeColor {
    UIColor *color = nil;
    switch (_theme) {
        case HXThemeOrange: {
            color = [UIColor colorWithRed:252.0f/255.0f green:139.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
            break;
        }
        case HXThemeDark: {
            color = [UIColor colorWithRed:242.0f/255.0f green:101.0f/255.0f blue:34.0f/255.0f alpha:1.0f];
            break;
        }
        case HXThemeGraphical: {
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
