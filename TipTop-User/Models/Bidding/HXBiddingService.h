//
//  HXBiddingService.h
//  TipTop-User
//
//  Created by ShiCang on 15/11/2.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "MJExtension.h"

@interface HXBiddingSubService : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *parentID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortName;

@end

@interface HXBiddingService : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *iconActive;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong)  NSArray *subServices;

@end
