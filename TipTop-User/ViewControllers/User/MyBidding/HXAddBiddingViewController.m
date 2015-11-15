//
//  HXAddBiddingViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/1.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAddBiddingViewController.h"
#import "HXBiddingServiceViewController.h"
#import "HXBiddingService.h"
#import "HXAppApiRequest.h"
#import "MBProgressHUD.h"
#import "HXUserSession.h"


static NSString *CreateBiddingApi   = @"/biding/create";

@interface HXAddBiddingViewController () <HXBiddingServiceViewControllerDelegate>
@end

@implementation HXAddBiddingViewController {
    HXBiddingSubService *_subService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Response Event
- (IBAction)enterButtonPressed {
    if (_serviceNameLabel.text.length &&
        _deliverDateTextField.text.length &&
        _briefIntroductionTextView.text.length &&
        _costsTextField.text.length &&
        _contractAmountTextField.text.length) {
        [self startCreateBiddingReuqestWithParameters:@{@"access_token": [HXUserSession share].adviser.accessToken,
                                                               @"f_cid": _subService.parentID,
                                                                 @"cid": _subService.ID,
                                                                 @"eta": _deliverDateTextField.text,
                                                              @"detail": _briefIntroductionTextView.text,
                                                          @"cost_money": _costsTextField.text,
                                                      @"contract_money": _contractAmountTextField.text}];
    }
}

#pragma mark - Private Methods
- (void)startCreateBiddingReuqestWithParameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:CreateBiddingApi] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}


#pragma Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:NSStringFromClass([HXBiddingServiceViewController class])]) {
        HXBiddingServiceViewController *biddingServiceViewController = segue.destinationViewController;
        biddingServiceViewController.delegate = self;
    }
}

#pragma mark - Table View Delegete Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - HXBiddingServiceViewControllerDelegate Methods
- (void)serviceDidSelectedServiceID:(NSString *)serviceID subService:(HXBiddingSubService *)subService {
    _subService = subService;
    _subService.parentID = serviceID;
    _serviceNameLabel.text = subService.name;
}

@end
