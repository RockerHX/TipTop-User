//
//  HXChangePassWordViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/14.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXChangePassWordViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassWordTextFiled;

- (IBAction)enterButtonPressed;

@end
