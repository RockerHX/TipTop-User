//
//  HXRecruitmentViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXRecruitmentViewController.h"
#import "HXApi.h"

@implementation HXRecruitmentViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [HXApi webViewURLWithURL:@"/h5/page?key=join_us"];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameRecruitment;
}

@end
