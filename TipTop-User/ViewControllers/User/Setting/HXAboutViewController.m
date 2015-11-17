//
//  HXAboutViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAboutViewController.h"
#import "HXApi.h"

@interface HXAboutViewController ()
@end

@implementation HXAboutViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [DoMain stringByAppendingFormat:@"/h5/page?key=agent_about"];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

@end
