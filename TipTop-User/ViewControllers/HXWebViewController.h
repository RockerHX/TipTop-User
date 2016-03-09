//
//  HXWebViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXWebViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSString *loadURL;

- (void)loadWebView;
- (void)hideHUD;

@end
