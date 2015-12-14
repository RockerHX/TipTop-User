//
//  HXPickerView.h
//  MaintenanceCar
//
//  Created by ShiCang on 15/1/9.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXCategory;
@protocol HXPickerViewDelegate;

@interface HXPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet       UIPickerView *picker;            // 时间选择器
@property (weak, nonatomic) IBOutlet             UIView *containerView;     // 容器View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;  // 时间选择器到View下边距约束条件

@property (nonatomic, weak)                          id  <HXPickerViewDelegate>delegate;
@property (nonatomic, strong, readonly)         NSArray<HXCategory *> *pickerItmes;       // 选择器数据Cache

- (IBAction)enterButtonPressed;

+ (void)showWithItems:(NSArray *)items delegate:(id<HXPickerViewDelegate>)delegate;
- (instancetype)initWithItems:(NSArray *)items delegate:(id<HXPickerViewDelegate>)delegate;

/**
 *  显示选择器 - 带动画
 */
- (void)show;
- (void)hidde;

- (NSInteger)indexOfItem:(id)item;
- (BOOL)firstItem:(id)item;
- (BOOL)lastItem:(id)item;

@end

@protocol HXPickerViewDelegate <NSObject>

@optional
- (void)pickerView:(HXPickerView *)pickerView item:(id)item;

@end
