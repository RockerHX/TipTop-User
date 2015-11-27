//
//  HXServiceListViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/28.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXServiceListViewController.h"

@interface HXServiceListViewController ()
@end

@implementation HXServiceListViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    switch (_listType) {
        case HXCategoryListTypeNormal: {
            self.title = @"找顾问";
            break;
        }
        case HXCategoryListTypeDesigner: {
            self.title = @"找设计师";
            break;
        }
        case HXCategoryListTypeCase: {
            self.title = @"案例";
            _promptLabel.text = @"当前装潢案例共有";
            _countPromptLabel.text = @"例";
            break;
        }
        case HXCategoryListTypeHouseSale: {
            self.title = @"找房源";
            break;
        }
    }
    
}

- (void)viewConfig {
    
}

#pragma mark - Event Response
- (IBAction)mapBackButtonPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
