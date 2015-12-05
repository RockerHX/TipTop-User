//
//  HXWorkCircuitDetailViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/21.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXWorkCircuitDetailViewController.h"
#import "HXApi.h"
#import "HXUserSession.h"

@interface HXWorkCircuitDetailViewController ()
@end

@implementation HXWorkCircuitDetailViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [DoMain stringByAppendingFormat:@"/h5/client/order/view?access_token=%@&id=%@", [HXUserSession share].user.accessToken, _ID];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameWorkCircuit;
}

@end
