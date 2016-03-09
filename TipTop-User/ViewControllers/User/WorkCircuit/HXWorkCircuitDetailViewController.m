//
//  HXWorkCircuitDetailViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXWorkCircuitDetailViewController.h"
#import "HXApi.h"
#import "WebViewJavascriptBridge.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIAlertView+BlocksKit.h"
#import "HXUserSession.h"

@interface HXWorkCircuitDetailViewController () <UIWebViewDelegate>
@end

@implementation HXWorkCircuitDetailViewController {
    WebViewJavascriptBridge *_bridge;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [self initConfigure];
    
    [super viewDidLoad];
}

#pragma mark - Private Methods
- (void)initConfigure {
    self.loadURL = [HXApi webViewURLWithURL:[NSString stringWithFormat:@"/h5/client/order/view?access_token=%@&id=%@", [HXUserSession share].user.accessToken, _ID]];
}

- (void)loadWebView {
    [super loadWebView];
    
    __weak __typeof__(self)weakSelf = self;
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf handleJSData:data];
    }];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameWorkCircuit;
}

#pragma mark - Web View Delegate Methods
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideHUD];
}

#pragma mark - Private Methods
- (void)handleJSData:(id)data {
    NSLog(@"%@", data);
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *events = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    [self handleEvents:events];
}

- (void)handleEvents:(NSDictionary *)events {
    NSString *event = events[@"event"];
    NSString *message = events[@"params"][@"msg"];
    if ([event isEqualToString:@"confirm"]) {
        [UIAlertView bk_showAlertViewWithTitle:message
                                       message:nil
                             cancelButtonTitle:@"完结"
                             otherButtonTitles:@[@"取消"]
                                       handler:
         ^(UIAlertView *alertView, NSInteger buttonIndex) {
             if (buttonIndex == alertView.cancelButtonIndex) {
                 [_bridge callHandler:@"confirmEnter"];
             } else {
                 [_bridge callHandler:@"confirmCancel"];
             }
         }];
    } else if ([event isEqualToString:@"alert"]) {
        [self showAlertWithMessage:message];
    }
}

@end
