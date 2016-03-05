//
//  HXOnlinePayDetailViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/28.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@class HXOnlinePayDetailViewController;

@protocol HXOnlinePayDetailViewControllerDelegate <NSObject>

@required
- (void)detailViewController:(HXOnlinePayDetailViewController *)controller paySuccessWithID:(NSString *)orderID;

@end

@interface HXOnlinePayDetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXOnlinePayDetailViewControllerDelegate>delegate;

@property (nonatomic, copy) NSString *orderID;

- (IBAction)phoneButonPressed;
- (IBAction)remarkButonPressed;
- (IBAction)payButonPressed;

@end
