//
//  HXPickerView.m
//  MaintenanceCar
//
//  Created by ShiCang on 15/1/9.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import "HXPickerView.h"
#import "HXCategory.h"

@implementation HXPickerView {
    id _item;
    NSInteger _selectedIndex;
}

#pragma mark - Class Methods
+ (void)showWithItems:(NSArray *)items delegate:(id<HXPickerViewDelegate>)delegate {
    HXPickerView *pickerView = [[HXPickerView alloc] initWithItems:items delegate:delegate];
    [pickerView show];
}

#pragma mark - Init Methods
- (instancetype)initWithItems:(NSArray *)items delegate:(id<HXPickerViewDelegate>)delegate {
    self = [[[NSBundle mainBundle] loadNibNamed:@"HXPickerView" owner:self options:nil] firstObject];
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    _pickerItmes = items;
    _delegate = delegate;
    [self initConfigure];
    
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGestureRecognizer)]];
    self.alpha = 0.0f;
}

#pragma mark - Action Methods
- (IBAction)enterButtonPressed {
    if (!_item) {
        _item = [_pickerItmes[_selectedIndex].subItems firstObject];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:item:)]) {
        [_delegate pickerView:self item:_item];
    }
    [self hidde];
}

#pragma mark - Picker View Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger row = 0;
    switch (component) {
        case 0: {
            row = _pickerItmes.count;
            break;
        }
        case 1: {
            row = _pickerItmes[_selectedIndex].subItems.count;
            break;
        }
    }
    return row;
}

#pragma mark - Picker View Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = nil;
    switch (component) {
        case 0: {
            title = _pickerItmes[row].name;
            break;
        }
        case 1: {
            title = _pickerItmes[_selectedIndex].subItems[row].name;
            break;
        }
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0: {
            _selectedIndex = row;
            [pickerView reloadAllComponents];
            break;
        }
        case 1: {
            _item = _pickerItmes[_selectedIndex].subItems[row];
            break;
        }
    }
}

#pragma mark - Private Methods
- (void)addGestureRecognizer {
    [self removePickerView];
}

- (void)removePickerView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark - Public Methods
- (void)show {
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _bottomConstraint.constant = _bottomConstraint.constant / 8;
    [_containerView needsUpdateConstraints];
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.alpha = 0.2f;
        [weakSelf.containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        _bottomConstraint.constant = 0.0f;
        [_containerView needsUpdateConstraints];
        [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            weakSelf.alpha = 1.0f;
            [weakSelf.containerView layoutIfNeeded];
        } completion:nil];
    }];
}

- (void)hidde {
    [self removePickerView];
}

- (NSInteger)indexOfItem:(id)item {
    return [_pickerItmes indexOfObject:item];
}

- (BOOL)firstItem:(id)item {
    return [[_pickerItmes firstObject] isEqual:item];
}

- (BOOL)lastItem:(id)item {
    return [[_pickerItmes lastObject] isEqual:item];
}

@end
