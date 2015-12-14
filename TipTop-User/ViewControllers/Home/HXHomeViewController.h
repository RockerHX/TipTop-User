//
//  HXHomeViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@class HXHomePageCategoryView;
@class HXHomePageSubCategoryView;

@interface HXHomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet                  UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet                BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet    HXHomePageCategoryView *categoryView;
@property (weak, nonatomic) IBOutlet HXHomePageSubCategoryView *subCategoryView;

- (IBAction)callButtonPressed;
- (IBAction)avatarButtonPressed;
- (IBAction)categoryButtonPressed;

- (void)openSocket;
- (void)display;

@end
