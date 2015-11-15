//
//  HXEditIntroduceViewController.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/11.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXEditIntroduceViewController : UIViewController

@property (nonatomic, copy) NSString *introduce;

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)saveButtonPressed;

@end
