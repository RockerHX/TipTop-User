//
//  HXWebViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXWebViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation HXWebViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebView];
}

#pragma mark - Private Methods
- (void)initConfig {
}

- (void)loadWebView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_loadURL]]];
}

- (void)hideHUD {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - Web View Delegate Methods
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideHUD];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加载出错"
                                                    message:@"您是否要重新加载"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:@"取消", nil];
    [alert show];
}

#pragma mark - Alert View Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self loadWebView];
    }
}

@end
