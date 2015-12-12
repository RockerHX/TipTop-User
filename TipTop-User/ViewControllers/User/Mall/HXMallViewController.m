//
//  HXMallViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMallViewController.h"
#import "HXApi.h"

@implementation HXMallViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [HXApi webViewURLWithURL:@"/h5/page?key=join_us"];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMall;
}

@end
