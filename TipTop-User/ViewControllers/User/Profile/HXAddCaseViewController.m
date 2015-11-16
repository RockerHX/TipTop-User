//
//  HXAddCaseViewController.m
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAddCaseViewController.h"
#import "HXTextView.h"
#import "HXUserSession.h"
#import "MBProgressHUD.h"
#import "HXAppApiRequest.h"
#import "UIAlertView+BlocksKit.h"
#import "HXCase.h"
#import "UIButton+WebCache.h"


static NSString *UploadImageApi = @"/upload";
static NSString *CreateCaseApi = @"/case/create";
static NSString *UpdateCaseApi = @"/case/update";

@interface HXAddCaseViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation HXAddCaseViewController {
    NSString *_imageFile;
}

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
    if (_selectedCase) {
        [self refresh];
    }
}

#pragma mark - Setter And Getter
- (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameUser;
}

#pragma mark - Event Response
- (IBAction)saveButtonPressed {
    if (_selectedCase) {
        if (_contentIntroduceTextView.text.length &&
            _caseNameTextField.text.length &&
            _caseIntroduceTextView.text.length) {
            NSMutableDictionary *parameters = @{@"access_token": [HXUserSession share].user.accessToken,
                                                          @"id": _selectedCase.ID,
                                                 @"description": _contentIntroduceTextView.text,
                                                       @"title": _caseNameTextField.text,
                                                     @"content": _caseIntroduceTextView.text}.mutableCopy;
            if (_imageFile.length) {
                [parameters setObject:_imageFile forKey:@"image"];
            }
            [self startCreateCaseReuqestWithApi:UpdateCaseApi parameters:[parameters copy]];
        }
    } else {
        if (_contentIntroduceTextView.text.length &&
            _caseNameTextField.text.length &&
            _imageFile.length &&
            _caseIntroduceTextView.text.length) {
            [self startCreateCaseReuqestWithApi:CreateCaseApi
                                     parameters:@{@"access_token": [HXUserSession share].user.accessToken,
                                                   @"description": _contentIntroduceTextView.text,
                                                         @"title": _caseNameTextField.text,
                                                         @"image": _imageFile,
                                                       @"content": _caseIntroduceTextView.text}];
        }
    }
}

- (IBAction)caseImageButtonPressed {
    UIImagePickerController *imagePickerViewController = [[UIImagePickerController alloc] init];
    imagePickerViewController.delegate = self;
    imagePickerViewController.allowsEditing = YES;
    [self presentViewController:imagePickerViewController animated:YES completion:nil];
}

#pragma mark - Private Methods
- (void)refresh {
    _contentIntroduceTextView.text = _selectedCase.contentIntroduce;
    _caseNameTextField.text = _selectedCase.title;
    [_caseImageButton sd_setImageWithURL:[NSURL URLWithString:_selectedCase.image] forState:UIControlStateNormal];
    _caseIntroduceTextView.text = _selectedCase.caseIntroduce;
}

- (void)startUploadImageReuqest {
    [self startUploadImageReuqestWithParameters:@{@"access_token":[HXUserSession share].user.accessToken}
                                                            image:[_caseImageButton imageForState:UIControlStateNormal]];
}

- (void)startUploadImageReuqestWithParameters:(NSDictionary *)parameters image:(UIImage *)image {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    [[HXApiRequest manager] POST:[HXApi apiURLWithApi:UploadImageApi] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"temp.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            strongSelf->_imageFile = responseObject[@"data"][@"img"];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

- (void)startCreateCaseReuqestWithApi:(NSString *)api parameters:(NSDictionary *)parameters {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof__(self)weakSelf = self;
    [HXAppApiRequest requestPOSTMethodsWithAPI:[HXApi apiURLWithApi:api] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSInteger errorCode = [responseObject[@"error_code"] integerValue];
        if (HXAppApiRequestErrorCodeNoError == errorCode) {
            [strongSelf.view endEditing:NO];
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
    }];
}

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [_caseImageButton setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self startUploadImageReuqest];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
