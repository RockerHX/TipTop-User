//
//  HXGuideView.h
//
//  Created by Andy Shaw on 14/12/24.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXGuideView : UIView

- (IBAction)startButtonPressed;

+ (instancetype)showGuide:(void(^)(void))finished;
- (void)showGuide:(void(^)(void))finished;

- (void)hidden;

@end
