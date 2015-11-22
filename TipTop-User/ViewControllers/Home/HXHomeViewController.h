//
//  HXHomeViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface HXHomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

- (IBAction)callButtonPressed;
- (IBAction)avatarButtonPressed;
- (IBAction)categoryButtonPressed;

- (void)openSocket;

@end
