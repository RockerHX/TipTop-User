//
//  HXAddBiddingViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXAddBiddingViewController : UITableViewController

@property (weak, nonatomic) IBOutlet     UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *salesManLabel;
@property (weak, nonatomic) IBOutlet UITextField *deliverDateTextField;
@property (weak, nonatomic) IBOutlet  UITextView *briefIntroductionTextView;
@property (weak, nonatomic) IBOutlet UITextField *costsTextField;
@property (weak, nonatomic) IBOutlet UITextField *contractAmountTextField;

- (IBAction)enterButtonPressed;

@end
