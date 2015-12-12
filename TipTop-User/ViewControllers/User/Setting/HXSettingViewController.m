//
//  HXSettingViewController.m

//  TipTop-User
//
//  Created by ShiCang on 15/10/13.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXSettingViewController.h"
#import "HXWebViewController.h"
#import "HXApi.h"
#import "HXUseExplanationViewController.h"
#import "HXFeedBackViewController.h"
#import "HXAboutViewController.h"
#import "HXUserSession.h"

@interface HXSettingViewController ()
@end

@implementation HXSettingViewController

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 36.0f, 36.0f);
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -16.0f, 0.0f, 0.0f);
    [button setImage:[UIImage imageNamed:@"C-BackIcon"] forState:UIControlStateNormal];
    [button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

#pragma mark - Table View Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [HXUserSession share].state ? 4 : 3;
}

#pragma mark - Table View Data Source Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((1 == indexPath.section) && (1 == indexPath.row)) {
        HXUseExplanationViewController *useExplanationViewController = [HXUseExplanationViewController instance];
        [self.navigationController pushViewController:useExplanationViewController animated:YES];
    } else if ((1 == indexPath.section) && (2 == indexPath.row)) {
        HXFeedBackViewController *feedBackViewController = [HXFeedBackViewController instance];
        [self.navigationController pushViewController:feedBackViewController animated:YES];
    } else if ((2 == indexPath.section) && (1 == indexPath.row)) {
        HXAboutViewController *useExplanationViewController = [HXAboutViewController instance];
        [self.navigationController pushViewController:useExplanationViewController animated:YES];
    } else if ((3 == indexPath.section) && (0 == indexPath.row)) {
        [[HXUserSession share] logout];
        [tableView reloadData];
    }
}

@end
