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
#import "HXComment.h"

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
@property (nonatomic, assign, readonly)   CGFloat  advisoryMoreHeight;
@property (nonatomic, assign, readonly)   CGFloat  advisoryAdviserHeight;
@property (nonatomic, assign, readonly)   CGFloat  commentPromptHeight;
@property (nonatomic, assign, readonly) NSInteger  regularRow;
@property (nonatomic, assign, readonly) NSInteger  exceptCommentRow;
@property (nonatomic, assign, readonly) NSInteger  rows;
@property (nonatomic, strong, readonly)   NSArray *rowTypes;

@property (nonatomic, strong, readonly)            HXNormalAdviser *adviser;
@property (nonatomic, strong, readonly)          NSArray<HXCase *> *cases;
@property (nonatomic, strong, readonly) NSArray<HXNormalAdviser *> *advisoryAdvisers;
@property (nonatomic, strong, readonly)       NSArray<HXComment *> *comments;

@property (nonatomic, assign)           NSInteger  selectIndex;
@property (nonatomic, strong, readonly)    HXCase *selectedCase;

+ (instancetype)instanceWithListType:(HXCategoryListType)listType;
- (instancetype)initWithListType:(HXCategoryListType)listType;

- (void)requestWithID:(NSString *)ID cid:(NSString *)cid completed:(void(^)(void))completed;
- (void)fetchCommentWithID:(NSString *)ID completed:(void(^)(void))completed;

@end
