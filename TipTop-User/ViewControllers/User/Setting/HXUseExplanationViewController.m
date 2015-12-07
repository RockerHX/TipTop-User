//
//  HXUseExplanationViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXUseExplanationViewController.h"
#import "HXApi.h"

@interface HXUseExplanationViewController ()
@end

@implementation HXUseExplanationViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [HXApi webViewURLWithURL:@"/h5/page?key=agent_help"];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

@end
