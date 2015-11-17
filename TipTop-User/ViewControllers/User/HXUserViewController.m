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


static NSString *UploadImageApi = @"/upload";
static NSString *UpdateUserHeaderApi = @"/profile/avatar";

@interface HXUserViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
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
- (IBAction)userHeaderPressed {
    UIImagePickerController *imagePickerViewController = [[UIImagePickerController alloc] init];
    imagePickerViewController.delegate = self;
    imagePickerViewController.allowsEditing = YES;
    [self presentViewController:imagePickerViewController animated:YES completion:nil];
}

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

- (void)startUploadImageReuqestWithImage:(UIImage *)image {
    [self startUploadImageReuqestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken}
                                          image: image];
}

- (void)startUploadImageReuqestWithParameters:(NSDictionary *)parameters image:(UIImage *)image {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    [[HXApiRequest manager] POST:[HXApi apiURLWithApi:UploadImageApi] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"temp.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            NSString *headerFile = responseObject[@"data"][@"img"];
            [strongSelf startUpdateUserHeaderRequestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken,
                                                                     @"avatar": headerFile}];
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

- (void)startUpdateUserHeaderRequestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:UpdateUserHeaderApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            NSString *imageURL = responseObject[@"data"][@"avatar"];
            [[HXUserSession share] updateUserAvatar:imageURL];
            [strongSelf updateUserInfo];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(userCenterShouldHiddenAndShowViewController:)]) {
        switch (indexPath.row) {
            case HXMenuRowMyReservation: {
                navigationController = [HXMyReservationListViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowOnlinePay: {
                navigationController = [HXOnlinePayListViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowWorkCircuit: {
                navigationController = [HXWorkCircuitListViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowMall: {
                navigationController = [HXMallViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowRecruitment: {
                navigationController = [HXRecruitmentViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowFeedBack: {
                navigationController = [HXFeedBackViewController navigationControllerInstance];
                break;
            }
            case HXMenuRowMessageCenter: {
                navigationController = [HXMessageCenterViewController navigationControllerInstance];
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
        [_delegate userCenterShouldHiddenAndShowViewController:navigationController];
    }
}

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self startUploadImageReuqestWithImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
