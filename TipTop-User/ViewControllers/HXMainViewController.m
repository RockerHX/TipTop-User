//
//  HXMainViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/10.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMainViewController.h"
#import "HXStoryBoardManager.h"
#import "HXHomeViewController.h"
#import "HXUserViewController.h"
#import "HXLoginViewController.h"
#import "HXGuideView.h"

@interface HXMainViewController () <HXLoginViewControllerDelegate, HXUserViewControllerDelegate>
@end

@implementation HXMainViewController

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    __weak __typeof__(self)weakSelf = self;
    [HXGuideView showGuide:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        if ([HXUserSession share].state == HXUserSessionStateLogout) {
            [strongSelf showLoginViewController];
        } else {
            [strongSelf showHomePageViewController];
        }
    }];
}

#pragma mark - Config Methods
- (void)initConfig {
    [self setupAppStructure];
}

- (void)setupAppStructure {
    self.contentViewController = [HXHomeViewController navigationControllerInstance];
    HXUserViewController *userViewController = [HXStoryBoardManager viewControllerWithClass:[HXUserViewController class]
                                                                             storyBoardName:HXStoryBoardNameUser];
    userViewController.delegate = self;
    self.menuViewController = userViewController;
}

- (void)viewConfig {
}

#pragma mark - Private Methods
- (void)showLoginViewController {
    HXLoginViewController *loginViewController = [HXLoginViewController instance];
    loginViewController.delegate = self;
    [self addChildViewController:loginViewController];
    [self.view addSubview:loginViewController.view];
}

- (void)showHomePageViewController {
//    HXHomeViewController *homePageViewController = (HXHomeViewController *)self.contentViewController;
//    [homePageViewController openSocket];
}

#pragma mark - HXLoginViewControllerDelegate Methods
- (void)loginViewControllerLoginSuccess:(HXLoginViewController *)loginViewController {
    UIView *view = [self.contentViewController.view snapshotViewAfterScreenUpdates:YES];
    __weak __typeof__(self)weakSelf = self;
    [UIView transitionFromView:loginViewController.view toView:view duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:
     ^(BOOL finished) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [loginViewController.view removeFromSuperview];
        [loginViewController removeFromParentViewController];
        [view removeFromSuperview];
         
         [strongSelf showHomePageViewController];
    }];
}

#pragma mark - HXUserViewControllerDelegate Methods
- (void)userCenterShouldHiddenAndShowViewController:(UIViewController *)viewController {
    self.contentViewController = viewController;
    [self hideMenuViewController];
}

@end
