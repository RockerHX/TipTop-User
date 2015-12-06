//
//  HXTransfersViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXTransfersViewController.h"

@interface HXTransfersViewController ()

@end

@implementation HXTransfersViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
}

- (void)viewConfig {
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameOnlinePay;
}

@end
