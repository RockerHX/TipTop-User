//
//  HXHomePageCategoryItemView.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/26.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXHomePageCategoryItemView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;

+ (instancetype)instance;

@end
