//
//  HXMyServiceViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyServiceViewController.h"
#import "HXApi.h"
#import "HXUserSession.h"

@implementation HXMyServiceViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [DoMain stringByAppendingFormat:@"/h5/agent/service?access_token=%@", [HXUserSession share].user.accessToken];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyServiceNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyService;
}

@end
