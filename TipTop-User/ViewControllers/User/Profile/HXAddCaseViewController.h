//
//  HXAddCaseViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@class HXCase;
@class HXTextView;

@interface HXAddCaseViewController : UITableViewController

@property (weak, nonatomic) IBOutlet  HXTextView *contentIntroduceTextView;
@property (weak, nonatomic) IBOutlet UITextField *caseNameTextField;
@property (weak, nonatomic) IBOutlet    UIButton *caseImageButton;
@property (weak, nonatomic) IBOutlet  HXTextView *caseIntroduceTextView;

@property (nonnull, nonatomic, strong) HXCase *selectedCase;

- (IBAction)saveButtonPressed;
- (IBAction)caseImageButtonPressed;

@end
