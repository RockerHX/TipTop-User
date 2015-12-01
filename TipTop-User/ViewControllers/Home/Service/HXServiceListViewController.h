//
//  HXServiceListViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/28.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXCategory.h"

@interface HXServiceListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *countPromptLabel;

@property (nonatomic, assign) HXCategoryListType listType;

- (IBAction)mapBackButtonPressed;

- (void)initConfig;
- (void)viewConfig;

@end
