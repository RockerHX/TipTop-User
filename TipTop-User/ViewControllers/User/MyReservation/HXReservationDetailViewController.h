//
//  HXReservationDetailViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXReservationDetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIView *remarkTapedView;

@property (nonatomic, copy) NSString *orderID;

- (IBAction)remarkButtonPressed;
- (IBAction)phoneButonPressed;
- (IBAction)sendButonPressed;

@end
