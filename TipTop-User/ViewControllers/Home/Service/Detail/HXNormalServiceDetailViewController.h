//
//  HXNormalServiceDetailViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/12/3.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXCategory.h"

@interface HXNormalServiceDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet    UIButton *reserveButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet      UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *mobileLabel;

@property (nonatomic, assign) HXCategoryListType  listType;
@property (nonatomic, copy)             NSString *aid;
@property (nonatomic, copy)             NSString *cid;
@property (nonatomic, assign)               BOOL  canReserve;

- (IBAction)reserveButtonPressed;
- (IBAction)callButtonPressed;

@end
