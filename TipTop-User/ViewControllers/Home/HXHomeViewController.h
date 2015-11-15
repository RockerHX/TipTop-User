//
//  HXHomeViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXPanGestureViewController.h"

@interface HXHomeViewController : HXPanGestureViewController

@property (weak, nonatomic) IBOutlet UIImageView *adviserHeader;
@property (weak, nonatomic) IBOutlet UIImageView *locationIcon;
@property (weak, nonatomic) IBOutlet     UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cylindrical;
@property (weak, nonatomic) IBOutlet UIImageView *innerCircle;
@property (weak, nonatomic) IBOutlet     UILabel *orderTitleLabel;
@property (weak, nonatomic) IBOutlet     UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet     UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet    UIButton *grabButton;

- (IBAction)grabButtonPressed;

- (void)openSocket;

@end
