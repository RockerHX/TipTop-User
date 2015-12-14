//
//  HXPanGestureNavgaitionController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXPanGestureNavgaitionController.h"
#import <REFrostedViewController/REFrostedViewController.h>

@interface HXPanGestureNavgaitionController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@end

@implementation HXPanGestureNavgaitionController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    self.delegate = self;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}

#pragma mark - Gesture recognizer
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    [self.frostedViewController panGestureRecognized:sender];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([[otherGestureRecognizer.view class] isSubclassOfClass:[UITableView class]] ||
        [[otherGestureRecognizer.view class] isSubclassOfClass:[UICollectionView class]]) {
        return NO;
    }
    if ([[otherGestureRecognizer.view class] isSubclassOfClass:[UITableViewCell class]] ||
       [NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"UITableViewCellScrollView"] ||
       [NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"UITableViewWrapperView"]) {
        
        return YES;
    }
    return YES;
}

#pragma mark - Navigation Controller Delegate Methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.count > 2) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, 36.0f, 36.0f);
        button.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -16.0f, 0.0f, 0.0f);
        [button setImage:[UIImage imageNamed:@"C-BackIcon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

#pragma mark - Private Methods
- (void)showMenuButtonPressed {
    [self.frostedViewController presentMenuViewController];
}

@end
