//
//  HXProfileViewModel.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXProfile.h"
#import "HXCase.h"

typedef NS_ENUM(NSUInteger, HXProfileCellRow) {
    HXProfileCellRowHeader,
    HXProfileCellRowSelected,
    HXProfileCellRowEdit,
    HXProfileCellRowNoContent,
    HXProfileCellRowIntroduce,
    HXProfileCellRowCaseContent,
    HXProfileCellRowCaseCard
};

typedef NS_ENUM(NSUInteger, HXProfileSelectType) {
    HXProfileSelectTypeIntroduce,
    HXProfileSelectTypeCase
};


@interface HXProfileViewModel : NSObject

@property (nonatomic, assign, readonly)   CGFloat  selectedHeight;
@property (nonatomic, assign, readonly)   CGFloat  editHeight;
@property (nonatomic, assign, readonly)   CGFloat  nullContentHeight;
@property (nonatomic, assign, readonly)   CGFloat  cardHeight;
@property (nonatomic, assign, readonly) NSInteger  rows;

@property (nonatomic, assign, readonly)                BOOL  hasIntroduce;
@property (nonatomic, assign, readonly) HXProfileSelectType  selectType;
@property (nonatomic, assign)                     NSInteger  selectIndex;

@property (nonatomic, strong, readonly)   NSArray *rowTypes;
@property (nonatomic, strong, readonly)   NSArray *cases;

@property (nonatomic, strong, readonly) HXProfile *profile;
@property (nonatomic, strong, readonly)    HXCase *selectedCase;

+ (instancetype)instanceWithToken:(NSString *)token;
- (instancetype)initWithToken:(NSString *)token;

- (void)requestWithType:(HXProfileSelectType)type completed:(void(^)(void))completed;

@end
