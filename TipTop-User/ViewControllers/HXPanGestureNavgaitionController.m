//
//  HXPanGestureNavgaitionController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXPanGestureNavgaitionController.h"
#import <REFrostedViewController/REFrostedViewController.h>

@interface HXPanGestureNavgaitionController () <UIGestureRecognizerDelegate>
@end

@implementation HXPanGestureNavgaitionController {
    BOOL _canPan;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _canPan = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}

#pragma mark - Gesture recognizer
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    if (self.canPan) {
        [self.frostedViewController panGestureRecognized:sender];
    }
}

#pragma mark - Setter And Getter
- (BOOL)canPan {
    return _canPan;
}

- (void)setCanPan:(BOOL)canPan {
    _canPan = canPan;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([[otherGestureRecognizer.view class] isSubclassOfClass:[UITableView class]] ||
        [[otherGestureRecognizer.view class] isSubclassOfClass:[UICollectionView class]]) {
        return NO;
    }
    if( [[otherGestureRecognizer.view class] isSubclassOfClass:[UITableViewCell class]] ||
       [NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"UITableViewCellScrollView"] ||
       [NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"UITableViewWrapperView"]) {
        
        return YES;
    }
    return YES;
}

@end
