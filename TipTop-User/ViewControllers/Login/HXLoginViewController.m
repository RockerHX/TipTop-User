//
//  HXLoginViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXLoginViewController.h"
#import "HXLoginRequset.h"
#import "MBProgressHUD.h"

@implementation HXLoginViewController

#pragma mark - View Controller Lift Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _staffIDTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (void)viewConfig {
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLogin;
}

#pragma mark - Event Response
- (IBAction)loginButtonPressed {
    [self startLogin];
}

- (IBAction)forgotPasswordButtonPressed {
    [self userForgotPassword];
}

#pragma mark - Private Methods
- (void)startLogin {
    if (!_staffIDTextField.text.length) {
        
    } else if (!_passwordTextField.text.length) {
        
    } else {
        [self startLoginRequest];
    }
}

- (void)userForgotPassword {
    
}

#pragma mark - Request Methods
- (void)startLoginRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    NSDictionary *parameters = @{@"mobile": _staffIDTextField.text,
                               @"password": _passwordTextField.text};
    [HXUser loginWithParameters:parameters success:^(HXApiResponse *response, HXUser *user) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        if (response.errorCode == HXAppApiRequestErrorCodeNoError) {
            [[HXUserSession share] updateUser:user];
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(loginViewControllerLoginSuccess:)]) {
                [strongSelf.delegate loginViewControllerLoginSuccess:strongSelf];
            }
        }
    } failure:^(HXApiResponse *response) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

@end
