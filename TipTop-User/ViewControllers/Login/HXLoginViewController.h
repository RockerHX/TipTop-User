//
//  HXLoginViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXUserSession.h"


@class HXLoginViewController;
@protocol HXLoginViewControllerDelegate <NSObject>

@required
- (void)loginViewControllerLoginSuccess:(HXLoginViewController *)loginViewController;

@end

@interface HXLoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet          id  <HXLoginViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *staffIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonPressed;
- (IBAction)forgotPasswordButtonPressed;

@end
