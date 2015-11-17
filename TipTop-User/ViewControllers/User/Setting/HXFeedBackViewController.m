//
//  HXFeedBackViewController.m

//  TipTop-User
//
//  Created by ShiCang on 15/11/17.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXFeedBackViewController.h"
#import "HXApi.h"

@interface HXFeedBackViewController ()
@end

@implementation HXFeedBackViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    self.loadURL = [DoMain stringByAppendingFormat:@"/h5/feedback?app=client"];
    
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXFeedBackNavigationController";
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

@end
