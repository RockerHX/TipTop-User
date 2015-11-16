//
//  HXRegisterViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXRegisterViewController.h"
#import "HXSecurityCodeButton.h"
#import "HXAppApiRequest.h"
#import "UIAlertView+BlocksKit.h"
#import "MBProgressHUD.h"


static NSString *CaptchaApi = @"/session/regCaptcha";
static NSString *RegisterApi = @"/session/reg";

@interface HXRegisterViewController ()
@end

@implementation HXRegisterViewController

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

- (IBAction)checkBoxButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)enterButtonPressed {
    if (_mobileTextField.text.length &&
        _captchaTextField.text.length &&
        _passWordTextField.text.length &&
        _confirmTextField.text.length &&
        _checkBoxButton.selected) {
        if ([_confirmTextField.text isEqualToString:_passWordTextField.text]) {
            [self startRegisterRequestWithParameters:@{@"mobile": _mobileTextField.text,
                                                      @"captcha": _captchaTextField.text,
                                                     @"password": _passWordTextField.text}];
        }
    }
}

#pragma mark - Private Methods
- (void)startMessageCodeRequestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:CaptchaApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [UIAlertView bk_showAlertViewWithTitle:@"发送成功！"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil
                                           handler:nil];
        }
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}
- (void)startRegisterRequestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:RegisterApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [UIAlertView bk_showAlertViewWithTitle:@"注册成功！"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil
                                           handler:
             ^(UIAlertView *alertView, NSInteger buttonIndex) {
                 [strongSelf dismissViewControllerAnimated:YES completion:nil];
             }];
        }
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}

@end
