//
//  HXStoryBoardManager.h
//  MaintenanceCar
//
//  Created by ShiCang on 15/7/13.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXStoryBoardName) {
    HXStoryBoardNameLogin,
    HXStoryBoardNameHome,
    HXStoryBoardNameUser,
    
    HXStoryBoardNameSetting,
    HXStoryBoardNameMyReservation,
    HXStoryBoardNameOnlinePay,
    HXStoryBoardNameWorkCircuit,
    HXStoryBoardNameMall,
    HXStoryBoardNameRecruitment,
    HXStoryBoardNameMyComment,
    HXStoryBoardNameMessageCenter
};

@interface HXStoryBoardManager : NSObject

+ (id)navigaitonControllerWithIdentifier:(NSString *)identifier storyBoardName:(HXStoryBoardName)name;
+ (id)viewControllerWithClass:(Class)class storyBoardName:(HXStoryBoardName)name;

@end
