//
//  HXReservationAddRemarkViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/10/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXReservationAddRemarkViewController.h"
#import "HXAppApiRequest.h"
#import "MBProgressHUD.h"
#import "UIAlertView+BlocksKit.h"
#import "BRPlaceholderTextView.h"
#import "DateTools.h"


static NSString *OrderRemarkCreateApi = @"/order/remarkCreate";

static NSString *TextViewPrompt = @"请输入备注事件";

@interface HXReservationAddRemarkViewController ()
@end

@implementation HXReservationAddRemarkViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    
}

- (void)viewConfig {
    _dateLabel.text = [[NSDate date] formattedDateWithFormat:@"yyyy-MM-dd hh:mm"];
    _textView.placeholder = TextViewPrompt;
}

#pragma mark - Event Response
- (IBAction)saveButtonPressed {
    [self createRemark];
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMyReservation;
}

#pragma mark - Private Methods
- (void)createRemark {
    if (_textView.text.length) {
        [_textView resignFirstResponder];
        [self startCreateRemarkReuqestWithParameters:@{@"access_token": [HXUserSession share].user.accessToken,
                                                                 @"id": _orderID,
                                                        @"remark_time": _dateLabel.text,
                                                            @"content": (_textView.text ?: @"")}];
    } else {
        [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                       message:@"请输入备注内容"
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil
                                       handler:nil];
    }
}

- (void)startCreateRemarkReuqestWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:OrderRemarkCreateApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [UIAlertView bk_showAlertViewWithTitle:@"备注成功！"
                                           message:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil
                                           handler:
             ^(UIAlertView *alertView, NSInteger buttonIndex) {
                 [strongSelf.navigationController popViewControllerAnimated:YES];
             }];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row) {
        
    }
}

@end
