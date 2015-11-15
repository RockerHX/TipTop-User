//
//  HXStarView.h
//  MaintenanceCar
//
//  Created by ShiCang on 15/1/26.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXStarView : UIView

@property (nonatomic, assign)               BOOL  enabled;
@property (nonatomic, assign)          NSInteger  value;
@property (nonatomic, strong, readonly) NSString *startValue;

@end
