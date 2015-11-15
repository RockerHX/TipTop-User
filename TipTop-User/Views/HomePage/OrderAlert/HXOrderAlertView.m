//
//  HXOrderAlertView.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXOrderAlertView.h"
#import "HXOrderAlertCell.h"
#import "AppDelegate.h"

typedef void(^BLOCK)(HXNewOrder *order);

@implementation HXOrderAlertView {
    HXNewOrder *_newOrder;
    BLOCK _block;
}

#pragma mark - Class Methods
+ (instancetype)showWithNewOrder:(HXNewOrder *)newOrder hanlde:(void(^)(HXNewOrder *newOrder))handle {
    HXOrderAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"HXOrderAlertView" owner:self options:nil] firstObject];
    [alertView showWithNewOrder:newOrder hanlde:handle];
    return alertView;
}

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    NSString *className = NSStringFromClass([HXOrderAlertCell class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:className];
}

- (void)viewConfig {
    _containerView.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
}

#pragma mark - Event Response
- (IBAction)hanleButtonPressed {
    __weak __typeof__(self)weakSelf = self;
    [self hidden:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        if (strongSelf->_block) {
            strongSelf->_block(_newOrder);
        }
    }];
}

#pragma mark - Public Methods
- (void)showWithNewOrder:(HXNewOrder *)newOrder hanlde:(void(^)(HXNewOrder *newOrder))hanlde {
    _newOrder = newOrder;
    _block = hanlde;
    
    [self show];
}

- (void)hidden {
    [self hidden:nil];
}

#pragma mark - Private Methods
- (void)show {
    [_tableView reloadData];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = delegate.window;
    self.frame = mainWindow.frame;
    [mainWindow addSubview:self];
    
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.4f delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.containerView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)hidden:(void(^)(void))completed {
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.containerView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        strongSelf.containerView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            __strong __typeof__(self)strongSelf = weakSelf;
            strongSelf.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if (completed) {
                completed();
            }
            __strong __typeof__(self)strongSelf = weakSelf;
            [strongSelf removeFromSuperview];
        }];
    }];
}

#pragma marlk - Tabele View Data Source Methods
static NSInteger RowNumber = 6;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return RowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = NSStringFromClass([HXOrderAlertCell class]);
    HXOrderAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:cellName owner:nil options:nil];
        cell = [nibs lastObject];
    };
    [cell displayWithNewOrder:_newOrder row:indexPath.row];
    return cell;
}

@end
