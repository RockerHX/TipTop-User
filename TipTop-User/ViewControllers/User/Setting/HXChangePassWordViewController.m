//
//  HXChangePassWordViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/14.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXChangePassWordViewController.h"
#import "MBProgressHUD.h"
#import "HXAppApiRequest.h"
#import "UIAlertView+BlocksKit.h"
#import "HXUserSession.h"


static NSString *OrderListApi = @"/profile/password";

@interface HXChangePassWordViewController ()
@end

@implementation HXChangePassWordViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Event Response
- (IBAction)enterButtonPressed {
    NSString *oldPassWord = _oldPassWordTextFiled.text;
    NSString *passWord = _passWordTextFiled.text;
    NSString *confirmPassWord = _confirmPassWordTextFiled.text;
    
    if (oldPassWord.length && passWord.length && confirmPassWord.length) {
        if ([passWord isEqualToString:confirmPassWord]) {
            [self startChangePassWordRequest:@{@"access_token": [HXUserSession share].user.accessToken,
                                               @"old_password": oldPassWord,
                                                   @"password": confirmPassWord}];
        }
    }
}

#pragma mark - Private Methods
- (void)startChangePassWordRequest:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:OrderListApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        NSString *message = responseObject[@"tip"];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            message = @"密码修改成功";
        }
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                       message:message
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil
                                       handler:nil];
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.navigationController.view animated:YES];
    }];
}

@end
