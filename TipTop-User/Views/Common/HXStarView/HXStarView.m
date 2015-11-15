//
//  HXStarView.m
//  MaintenanceCar
//
//  Created by ShiCang on 15/1/26.
//  Copyright (c) 2015年 MaintenanceCar. All rights reserved.
//

#import "HXStarView.h"

@interface HXStarView ()

@property (weak, nonatomic) IBOutlet UIButton *starFirst;
@property (weak, nonatomic) IBOutlet UIButton *starSecond;
@property (weak, nonatomic) IBOutlet UIButton *starThird;
@property (weak, nonatomic) IBOutlet UIButton *starFourth;
@property (weak, nonatomic) IBOutlet UIButton *starFifth;

- (IBAction)starButtonPressed:(UIButton *)starButton;

@end

@implementation HXStarView

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    _enabled    = NO;
    _startValue = @"0";
}

#pragma mark - Setter And Getter Methods
// 根据星级数来显示对应星级图片
- (void)setValue:(NSInteger)value {
    _value = value;
    _startValue = @(value).stringValue;
    
    switch (value) {
        case 1: {
            [self lightStar:_starFirst];
            [self unLightStar:_starSecond];
            [self unLightStar:_starThird];
            [self unLightStar:_starFourth];
            [self unLightStar:_starFifth];
            break;
        }
        case 2: {
            [self lightStar:_starFirst];
            [self lightStar:_starSecond];
            [self unLightStar:_starThird];
            [self unLightStar:_starFourth];
            [self unLightStar:_starFifth];
            break;
        }
        case 3: {
            [self lightStar:_starFirst];
            [self lightStar:_starSecond];
            [self lightStar:_starThird];
            [self unLightStar:_starFourth];
            [self unLightStar:_starFifth];
            break;
        }
        case 4: {
            [self lightStar:_starFirst];
            [self lightStar:_starSecond];
            [self lightStar:_starThird];
            [self lightStar:_starFourth];
            [self unLightStar:_starFifth];
            break;
        }
        case 5: {
            [self lightStar:_starFirst];
            [self lightStar:_starSecond];
            [self lightStar:_starThird];
            [self lightStar:_starFourth];
            [self lightStar:_starFifth];
            break;
        }
            
        default: {
            [self unLightStar:_starFirst];
            [self unLightStar:_starSecond];
            [self unLightStar:_starThird];
            [self unLightStar:_starFourth];
            [self unLightStar:_starFifth];
            break;
        }
    }
}

#pragma mark - Action Methods
- (IBAction)starButtonPressed:(UIButton *)starButton {
    if (_enabled) {
        self.value = starButton.tag;
    }
}

#pragma mark - Private Methods
- (void)lightStar:(UIButton *)star {
    [star setImage:[UIImage imageNamed:@"C-StarIcon"] forState:UIControlStateNormal];
}

- (void)unLightStar:(UIButton *)star {
    [star setImage:[UIImage imageNamed:@"C-UnStarIcon"] forState:UIControlStateNormal];
}

@end
