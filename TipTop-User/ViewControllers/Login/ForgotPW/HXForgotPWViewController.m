//
//  HXForgotPWViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXForgotPWViewController.h"
#import "HXSecurityCodeButton.h"
#import "HXAppApiRequest.h"
#import "UIAlertView+BlocksKit.h"
#import "MBProgressHUD.h"


static NSString *CaptchaApi = @"/session/captcha";
static NSString *ForgotPassWordApi = @"/session/forgotPwd";

@interface HXForgotPWViewController ()
@end

@implementation HXForgotPWViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    __weak __typeof__(self)weakSelf = self;
    [_captchaButton start:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf startMessageCodeRequestWithParameters:@{@"mobile": _mobileTextField.text}];
    } complete:nil];
}

- (void)viewConfig {
    
}

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)enterButtonPressed {
    if (_mobileTextField.text.length != 11) {
        [self showAlertWithMessage:@"请输入正确手机号！"];
    } else if (_captchaTextField.text.length != 4) {
        [self showAlertWithMessage:@"请输入正确验证码！"];
    } else if (!_passWordTextField.text.length) {
        [self showAlertWithMessage:@"请输入新密码！"];
    } else if (![_passWordTextField.text isEqualToString:_confirmTextField.text]) {
        [self showAlertWithMessage:@"亲，您输入的两次密码不相同噢！"];
    } else {
        [self startForgotPassWordRequestWithParameters:@{@"mobile": _mobileTextField.text,
                                                         @"captcha": _captchaTextField.text,
                                                         @"password": _passWordTextField.text}];
    }
}

#pragma mark - Private Methods
- (void)startMessageCodeRequestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:CaptchaApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [self showAlertWithMessage:@"发送成功！"];
        } else {
            [self showAlertWithMessage:responseObject[@"tip"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}
- (void)startForgotPassWordRequestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:ForgotPassWordApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [self showAlertWithMessage:@"重置成功！"];
        } else {
            [self showAlertWithMessage:responseObject[@"tip"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}

@end
