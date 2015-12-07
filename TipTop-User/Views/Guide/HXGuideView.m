//
//  HXGuideView.m
//
//  Created by Andy Shaw on 14/12/24.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import "HXGuideView.h"
#import "AppDelegate.h"

static NSString *kGuideViewShowKey = @"kGuideViewShowKey";

typedef void(^BLOCK)(void);

@implementation HXGuideView {
    BLOCK _finishedBlock;
}

#pragma mark - Class Methods
+ (instancetype)showGuide:(void(^)(void))finished {
    HXGuideView *guideView = [[[NSBundle mainBundle] loadNibNamed:@"HXGuideView" owner:self options:nil] firstObject];
    [guideView showGuide:finished];
    return guideView;
}

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
}

- (void)viewConfig {
}

#pragma mark - Event Response
- (IBAction)startButtonPressed {
    if (_finishedBlock) {
        _finishedBlock();
    }
    [self hidden];
    [self guideViewShowed];
}

#pragma mark - Public Methods
- (void)showGuide:(void(^)(void))finished {
    _finishedBlock = finished;
    [self show];
}

- (void)hidden {
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.8f animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.alpha = 0.0f;
    } completion:^(BOOL finished) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
    }];
}

#pragma mark - Private Methods
- (BOOL)needShow {
    NSNumber *showed = [[NSUserDefaults standardUserDefaults] valueForKey:kGuideViewShowKey];
    return !showed.boolValue;
}

- (void)guideViewShowed {
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kGuideViewShowKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)show {
    if ([self needShow]) {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        UIWindow *mainWindow = delegate.window;
        self.frame = mainWindow.frame;
        [mainWindow addSubview:self];
    } else {
        [self startButtonPressed];
    }
}

@end
