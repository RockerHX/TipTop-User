//
//  HXBiddingServiceViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBiddingSubService;

@protocol HXBiddingServiceViewControllerDelegate <NSObject>

@required
- (void)serviceDidSelectedServiceID:(NSString *)serviceID subService:(HXBiddingSubService *)subService;

@end

@interface HXBiddingServiceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet          id  <HXBiddingServiceViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;
@property (weak, nonatomic) IBOutlet UITableView *subServiceTableView;

@end
