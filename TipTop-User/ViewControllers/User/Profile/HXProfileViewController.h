//
//  HXProfileViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/20.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXProfileViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet     UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet     UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *industryTextField;
@property (weak, nonatomic) IBOutlet UITextField *moblieTextField;
@property (weak, nonatomic) IBOutlet UITextField *weiChatTextField;

- (IBAction)saveButtonPressed;

@end
