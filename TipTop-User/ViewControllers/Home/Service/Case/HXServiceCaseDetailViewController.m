//
//  HXServiceCaseDetailViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceCaseDetailViewController.h"
#import "HXApi.h"

@interface HXServiceCaseDetailViewController ()
@end

@implementation HXServiceCaseDetailViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [HXApi webViewURLWithURL:[NSString stringWithFormat:@"/h5/client/houseDesign/view?id=%@", _hid]];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameList;
}

@end
