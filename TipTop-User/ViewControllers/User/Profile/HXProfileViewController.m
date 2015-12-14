//
//  HXProfileViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/20.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileViewController.h"
#import "HXUserSession.h"
#import "HXAppApiRequest.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIAlertView+BlocksKit.h"


static NSString *ProfileApi       = @"/profile";
static NSString *UploadProfileApi = @"/profile/update";
static NSString *UploadImageApi   = @"/upload";

@interface HXProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation HXProfileViewController {
    NSString *_avatarPath;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    self.tableView.hidden = YES;
    [self startProfileRequest];
}

- (void)viewConfig {
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXProfileNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameUser;
}

#pragma mark - Event Response
- (IBAction)saveButtonPressed {
    NSMutableDictionary *parameters = @{@"access_token": [HXUserSession share].user.accessToken}.mutableCopy;
    if (_avatarPath.length) {
        [parameters setValue:_avatarPath forKey:@"avatar"];
    }
    if (_companyTextField.text.length) {
        [parameters setValue:_companyTextField.text forKey:@"company"];
    }
    if (_industryTextField.text.length) {
        [parameters setValue:_industryTextField.text forKey:@"industry"];
    }
    if (_moblieTextField.text.length) {
        [parameters setValue:_moblieTextField.text forKey:@"mobile"];
    }
    if (_weiChatTextField.text.length) {
        [parameters setValue:_weiChatTextField.text forKey:@"wechat"];
    }
    [self startUploadProfileRequestWithParameters:parameters];
}

#pragma mark - Private Methods
- (void)startProfileRequest {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    __weak __typeof__(self)weakSelf = self;
    NSDictionary *parameters = @{@"access_token": [HXUserSession share].user.accessToken};
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:ProfileApi] parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [[HXUserSession share] updateProfile:[HXProfile mj_objectWithKeyValues:responseObject[@"data"]]];
            [strongSelf updateUserInfo];
        }
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}

- (void)startUploadImageReuqestWithImage:(UIImage *)image {
    [self startUploadImageReuqestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken}
                                          image:image];
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
            strongSelf->_avatarPath = responseObject[@"data"][@"img"];
            strongSelf.avatarImageView.image = image;
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

- (void)startUploadProfileRequestWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:UploadProfileApi] parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [[HXUserSession share] updateUserAvatar:responseObject[@"data"][@"avatar"]];
            [UIAlertView bk_showAlertViewWithTitle:@"保存成功！"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil
                                           handler:nil];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

- (void)updateUserInfo {
    self.tableView.hidden = NO;
    
    HXProfile *profile = [HXUserSession share].profile;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:profile.avatar]];
    _numberLabel.text = profile.number;
    _integralLabel.text = @(profile.credit).stringValue;
    _companyTextField.text = profile.company;
    _industryTextField.text = profile.industry;
    _moblieTextField.text = profile.mobile;
    _weiChatTextField.text = profile.wechat;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!indexPath.row) {
        UIImagePickerController *imagePickerViewController = [[UIImagePickerController alloc] init];
        imagePickerViewController.delegate = self;
        imagePickerViewController.allowsEditing = YES;
        [self presentViewController:imagePickerViewController animated:YES completion:nil];
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
