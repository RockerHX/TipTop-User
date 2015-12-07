//
//  HXHouseDetailViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXHouseDetailViewController.h"
#import "HXApi.h"

@interface HXHouseDetailViewController ()
@end

@implementation HXHouseDetailViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [HXApi webViewURLWithURL:[NSString stringWithFormat:@"/h5/client/houseSale/view?id=%@", _hid]];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameList;
}

@end
