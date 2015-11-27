//
//  HXNormalServiceListViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/28.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXNormalServiceListViewController.h"

@interface HXNormalServiceListViewController ()

@end

@implementation HXNormalServiceListViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameHome;
}

#pragma mark - Event Response
- (IBAction)leftButtonPressed {
    
}

- (IBAction)rightButtonPressed {
    
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray<HXCategory *> *categories = [HXCategoryManager share].categories;
//    if ([tableView isEqual:_serviceTableView]) {
//        HXServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXServiceCell class]) forIndexPath:indexPath];
//        [cell displayWithService:categories[indexPath.row]];
//        return cell;
//    } else if ([tableView isEqual:_subServiceTableView]) {
//        HXSubServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXSubServiceCell class]) forIndexPath:indexPath];
//        [cell displayWithSubService:(categories[_serviceSelectedIndex]).subItems[indexPath.row]];
//        return cell;
//    }
    return nil;
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
