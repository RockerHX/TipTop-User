//
//  HXServiceTermsViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/17.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceTermsViewController.h"
#import "HXApi.h"

@interface HXServiceTermsViewController ()
@end

@implementation HXServiceTermsViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [HXApi webViewURLWithURL:@"/h5/page?key=client_term"];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLogin;
}

@end
