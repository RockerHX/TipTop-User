//
//  HXMyCommentViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXMyCommentViewController.h"
#import "HXCommentCell.h"
#import "UITableView+FDTemplateLayoutCell.h"


static NSString *CommentListApi = @"/review";

@implementation HXMyCommentViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Config Methods
- (void)initConfig {
    [super initConfig];
}

- (void)viewConfig {
    [super viewConfig];
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXMyCommentNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyComment;
}

#pragma mark - Public Methods
- (void)loadNewData {
    [self startCommentListReuqestWithParameters:@{@"access_token": [HXUserSession share].adviser.accessToken}];
}

#pragma mark - Private Methods
- (void)startCommentListReuqestWithParameters:(NSDictionary *)parameters {
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:CommentListApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf handleOrdersData:responseObject[@"data"][@"list"]];
            [strongSelf.tableView reloadData];
            [strongSelf endLoad];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)handleOrdersData:(NSArray *)ordersData {
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:ordersData.count];
    for (NSDictionary *data in ordersData) {
        HXComment *comment = [HXComment mj_objectWithKeyValues:data];
        if (data) {
            [comments addObject:comment];
        }
    }
    self.dataList = comments;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXCommentCell class]) forIndexPath:indexPath];
    [cell displayWithComment:self.dataList[indexPath.row]];
    return cell;
}

#pragma mark - Table View Data Source Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXCommentCell class]) cacheByIndexPath:indexPath configuration:^(HXCommentCell *cell) {
        [cell displayWithComment:self.dataList[indexPath.row]];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
