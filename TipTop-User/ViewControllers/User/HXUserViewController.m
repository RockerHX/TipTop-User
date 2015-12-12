//
//  HXUserViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUserViewController.h"
#import "HXProfileViewController.h"
#import "HXSettingViewController.h"
#import "HXMyReservationListViewController.h"
#import "HXOnlinePayListViewController.h"
#import "HXWorkCircuitListViewController.h"
#import "HXMallViewController.h"
#import "HXRecruitmentViewController.h"
#import "HXFeedBackViewController.h"
#import "HXMessageCenterViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UIAlertView+BlocksKit.h"

typedef NS_ENUM(NSUInteger, HXMenuRow) {
    HXMenuRowMyReservation = 0,
    HXMenuRowOnlinePay     = 1,
    HXMenuRowWorkCircuit   = 2,
    HXMenuRowMall          = 4,
    HXMenuRowRecruitment   = 5,
    HXMenuRowFeedBack      = 7,
    HXMenuRowMessageCenter = 8,
    HXMenuRowServicePhone  = 9
};

@interface HXUserViewController ()
@end

@implementation HXUserViewController

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
}

- (void)viewConfig {
}

#pragma mark - Event Response
- (IBAction)settingButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        UINavigationController *settingNavigationController = [HXSettingViewController navigationControllerInstance];
        [_delegate userCenterShouldHiddenAndShowViewController:settingNavigationController];
    }
}

- (IBAction)editButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        UINavigationController *profileViewController = [HXProfileViewController navigationControllerInstance];
        [_delegate userCenterShouldHiddenAndShowViewController:profileViewController];
    }
}

#pragma mark - Private Methods
- (void)updateUserInfo {
    HXUser *user = [HXUserSession share].user;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
    _nameLabel.text = user.realName;
    _mobileLabel.text = user.mobile;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        switch (indexPath.row) {
            case HXMenuRowMyReservation: {
                viewController = [HXMyReservationListViewController instance];
                break;
            }
            case HXMenuRowOnlinePay: {
                viewController = [HXOnlinePayListViewController instance];
                break;
            }
            case HXMenuRowWorkCircuit: {
                viewController = [HXWorkCircuitListViewController instance];
                break;
            }
            case HXMenuRowMall: {
                viewController = [HXMallViewController instance];
                break;
            }
            case HXMenuRowRecruitment: {
                viewController = [HXRecruitmentViewController instance];
                break;
            }
            case HXMenuRowFeedBack: {
                viewController = [HXFeedBackViewController instance];
                break;
            }
            case HXMenuRowMessageCenter: {
                viewController = [HXMessageCenterViewController instance];
                break;
            }
            case HXMenuRowServicePhone: {
                [UIAlertView bk_showAlertViewWithTitle:@"拨打服务电话？"
                                               message:@"400-962540"
                                     cancelButtonTitle:@"拨打"
                                     otherButtonTitles:@[@"取消"]
                                               handler:
                 ^(UIAlertView *alertView, NSInteger buttonIndex) {
                     if (buttonIndex == alertView.cancelButtonIndex) {
                         ;
                     }
                 }];
                return;
                break;
            }
        }
        [_delegate userCenterShouldHiddenAndShowViewController:viewController];
    }
}

@end
