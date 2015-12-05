//
//  HXHomePageAdviserDetialViewModel.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/25.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXNormalAdviser.h"
#import "HXCase.h"
#import "HXCategory.h"

typedef NS_ENUM(NSUInteger, HXHomePageAdviserDetialCellRow) {
    HXHomePageAdviserDetialCellRowNormalAdviser,
    HXHomePageAdviserDetialCellRowDesigner,
    HXHomePageAdviserDetialCellRowServiceContent,
    HXHomePageAdviserDetialCellRowPersonalIntroduce,
    HXHomePageAdviserDetialCellRowCaseIntroduce,
    HXHomePageAdviserDetialCellRowCase,
    HXHomePageAdviserDetialCellRowCaseContent,
    HXHomePageAdviserDetialCellRowAdvisoryMore,
    HXHomePageAdviserDetialCellRowAdvisoryAdviser,
    HXHomePageAdviserDetialCellRowCommentPrompt,
    HXHomePageAdviserDetialCellRowComment
};

@interface HXHomePageAdviserDetialViewModel : NSObject

@property (nonatomic, assign, readonly)   CGFloat  designerHeight;
@property (nonatomic, assign, readonly)   CGFloat  caseCardHeight;
@property (nonatomic, assign, readonly)   CGFloat  selectedHeight;
@property (nonatomic, assign, readonly)   CGFloat  editHeight;
@property (nonatomic, assign, readonly)   CGFloat  nullContentHeight;
@property (nonatomic, assign, readonly) NSInteger  rows;
@property (nonatomic, strong, readonly)   NSArray *rowTypes;

@property (nonatomic, strong, readonly)            HXNormalAdviser *adviser;
@property (nonatomic, strong, readonly)          NSArray<HXCase *> *cases;
@property (nonatomic, strong, readonly) NSArray<HXNormalAdviser *> *advisoryAdvisers;
@property (nonatomic, strong, readonly) NSArray *comment;

@property (nonatomic, assign)           NSInteger  selectIndex;
@property (nonatomic, strong, readonly)    HXCase *selectedCase;

+ (instancetype)instanceWithListType:(HXCategoryListType)listType;
- (instancetype)initWithListType:(HXCategoryListType)listType;

- (void)requestWithID:(NSString *)ID cid:(NSString *)cid completed:(void(^)(void))completed;

@end
