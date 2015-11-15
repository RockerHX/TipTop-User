//
//  HXProfileViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/20.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXProfileViewController.h"
#import "HXProfileViewModel.h"
#import "HXUserSession.h"
#import "MJRefresh.h"
#import "HXProfileHeaderCell.h"
#import "HXProfileSelectedCell.h"
#import "HXProfileEditCell.h"
#import "HXProfileNoContentCell.h"
#import "HXProfileIntroduceCell.h"
#import "HXCaseContentCell.h"
#import "HXCaseCardCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HXEditIntroduceViewController.h"
#import "HXAddCaseViewController.h"
#import "HXAppApiRequest.h"
#import "MBProgressHUD.h"


static NSString *DeleteCaseApi = @"/case/delete";

@interface HXProfileViewController () <HXProfileSelectedCellDelegate, HXProfileEditCellDelegate, HXProfileNoContentCellDelegate, HXCaseCardCellDelegate>
@end

@implementation HXProfileViewController {
    HXProfileViewModel *_viewModel;
    HXProfileSelectType _selectType;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.canPan = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.canPan = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _viewModel = [HXProfileViewModel instanceWithToken:[HXUserSession share].adviser.accessToken];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewConfig {
}

#pragma mark - Setter And Getter
- (NSString *)navigationControllerIdentifier {
    return @"HXProfileNavigationController";
}

- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameUser;
}

#pragma mark - Private Methods
- (void)loadData {
    __weak __typeof__(self)weakSelf = self;
    [_viewModel requestWithType:_selectType completed:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf endLoad];
    }];
}

- (void)endLoad {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)startDeleteCaseRequsetWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestGETMethodsWithAPI:[HXApi apiURLWithApi:DeleteCaseApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf selectedCellStateChange:HXProfileSelectTypeCase];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXProfileCellRow rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXProfileCellRowHeader: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileHeaderCell class]) forIndexPath:indexPath];
            [(HXProfileHeaderCell *)cell displayWithViewModel:_viewModel];
            break;
        }
        case HXProfileCellRowSelected: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileSelectedCell class]) forIndexPath:indexPath];
            break;
        }
        case HXProfileCellRowEdit: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileEditCell class]) forIndexPath:indexPath];
            [(HXProfileEditCell *)cell displayWithViewModel:_viewModel];
            break;
        }
        case HXProfileCellRowNoContent: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileNoContentCell class]) forIndexPath:indexPath];
            [(HXProfileNoContentCell *)cell displayWithSelectType:_selectType];
            break;
        }
        case HXProfileCellRowIntroduce: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileIntroduceCell class]) forIndexPath:indexPath];
            [(HXProfileIntroduceCell *)cell displayWithViewModel:_viewModel];
            break;
        }
        case HXProfileCellRowCaseContent: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXCaseContentCell class]) forIndexPath:indexPath];
            [(HXCaseContentCell *)cell displayWithViewModel:_viewModel];
            break;
        }
        case HXProfileCellRowCaseCard: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXCaseCardCell class]) forIndexPath:indexPath];
            [(HXCaseCardCell *)cell displayWithViewModel:_viewModel];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegete Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    __weak __typeof__(self)weakSelf = self;
    HXProfileCellRow rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXProfileCellRowHeader: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXProfileHeaderCell class]) cacheByIndexPath:indexPath configuration:^(HXProfileHeaderCell *cell) {
                __strong __typeof__(self)strongSelf = weakSelf;
                [cell displayWithViewModel:strongSelf->_viewModel];
            }];
            break;
        }
        case HXProfileCellRowSelected: {
            height = _viewModel.selectedHeight;
            break;
        }
        case HXProfileCellRowEdit: {
            height = _viewModel.editHeight;
            break;
        }
        case HXProfileCellRowNoContent: {
            height = _viewModel.nullContentHeight;
            break;
        }
        case HXProfileCellRowIntroduce: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXProfileIntroduceCell class]) cacheByIndexPath:indexPath configuration:^(HXProfileIntroduceCell *cell) {
                __strong __typeof__(self)strongSelf = weakSelf;
                [cell displayWithViewModel:strongSelf->_viewModel];
            }];
            break;
        }
        case HXProfileCellRowCaseContent: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXCaseContentCell class]) cacheByIndexPath:indexPath configuration:^(HXCaseContentCell *cell) {
                __strong __typeof__(self)strongSelf = weakSelf;
                [cell displayWithViewModel:strongSelf->_viewModel];
            }];
            break;
        }
        case HXProfileCellRowCaseCard: {
            height = _viewModel.cardHeight;
            break;
        }
    }
    return height;
}

#pragma mark - HXProfileSelectedCellDelegate Methods
- (void)selectedCellStateChange:(HXProfileSelectType)type {
    _selectType = type;
    __weak __typeof__(self)weakSelf = self;
    [_viewModel requestWithType:type completed:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
}

#pragma mark - HXProfileIntroduceEditCellDelegate Methods
- (void)cellShouldEdit:(HXProfileEditAction)action {
    switch (action) {
        case HXProfileEditActionAdd: {
            HXAddCaseViewController *addCaseViewController = [HXAddCaseViewController instance];
            [self.navigationController pushViewController:addCaseViewController animated:YES];
            break;
        }
        case HXProfileEditActionEdit: {
            [self noContentCellShouldAddSomething];
            break;
        }
        case HXProfileEditActionDelete: {
            NSDictionary *parameters = @{@"access_token": [HXUserSession share].adviser.accessToken,
                                                   @"id": _viewModel.selectedCase.ID};
            [self startDeleteCaseRequsetWithParameters:parameters];
            break;
        }
    }
}

#pragma mark - HXProfileNoContentCellDelegate Methods
- (void)noContentCellShouldAddSomething {
    switch (_selectType) {
        case HXProfileSelectTypeIntroduce: {
            HXEditIntroduceViewController *editIntroduceViewController = [HXEditIntroduceViewController instance];
            editIntroduceViewController.introduce = _viewModel.profile.introduce;
            [self.navigationController pushViewController:editIntroduceViewController animated:YES];
            break;
        }
        case HXProfileSelectTypeCase: {
            HXAddCaseViewController *addCaseViewController = [HXAddCaseViewController instance];
            addCaseViewController.selectedCase = _viewModel.selectedCase;
            [self.navigationController pushViewController:addCaseViewController animated:YES];
            break;
        }
    }
}

#pragma mark - HXCaseCardCellDelegate Methods
- (void)cardCellScrollAtIndex:(NSInteger)index {
    _viewModel.selectIndex = index;
    [self.tableView reloadData];
}

@end
