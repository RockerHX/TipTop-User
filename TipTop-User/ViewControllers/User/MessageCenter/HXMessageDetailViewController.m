//
//  HXMessageDetailViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/18.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMessageDetailViewController.h"
#import "HXApi.h"

@implementation HXMessageDetailViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [DoMain stringByAppendingFormat:@"/h5/notification?id=%@", _cid];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMessageCenter;
}

@end
