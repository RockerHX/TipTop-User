//
//  HXMyAddressViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/19.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import <BaiduMapAPI_Map/BMKMapView.h>

@interface HXMyAddressViewController : UIViewController

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet    UILabel *addressLabel;

- (IBAction)menuButtonPressed;
- (IBAction)enterButtonPressed;

@end
