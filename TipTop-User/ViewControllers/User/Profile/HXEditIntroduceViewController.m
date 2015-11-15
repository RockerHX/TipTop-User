//
//  HXEditIntroduceViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXEditIntroduceViewController.h"
#import "HXAppApiRequest.h"
#import "HXUserSession.h"
#import "UIAlertView+BlocksKit.h"
#import "MBProgressHUD.h"


static NSString *UpdateIntroduceApi = @"/profile/about";

@interface HXEditIntroduceViewController ()
@end

@implementation HXEditIntroduceViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    
}

- (void)viewConfig {
    _textView.text = _introduce ?: _textView.text;
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameUser;
}

#pragma mark - Event Response
- (IBAction)saveButtonPressed {
    if (_textView.text.length) {
        [self startUpdateIntroduceReuqestWithParameters:@{@"access_token": [HXUserSession share].adviser.accessToken,
                                                                 @"about": _textView.text}];
    }
}

#pragma mark - Private Methods
- (void)startUpdateIntroduceReuqestWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:UpdateIntroduceApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [UIAlertView bk_showAlertViewWithTitle:@"保存成功"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil handler:
             ^(UIAlertView *alertView, NSInteger buttonIndex) {
                 [strongSelf.view endEditing:NO];
                 [strongSelf.navigationController popViewControllerAnimated:YES];
             }];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

@end
