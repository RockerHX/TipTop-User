//
//  HXUserViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXUserViewControllerDelegate <NSObject>

@optional
- (void)userCenterShouldHiddenAndShowViewController:(UIViewController *)viewController;

@end

@interface HXUserViewController : UITableViewController

@property (nonatomic, weak) id <HXUserViewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet     UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *mobileLabel;

- (IBAction)userHeaderPressed;
- (IBAction)settingButtonPressed;
- (IBAction)editButtonPressed;

@end
