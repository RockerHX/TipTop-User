//
//  HXLoginRequset.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/7.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import "HXAppApiRequest.h"
#import "HXAdviser.h"

@interface HXAdviser (HXLoginRequset)

+ (AFHTTPRequestOperation *)loginWithParameters:(NSDictionary *)parameters
                                        success:(void(^)(HXApiResponse *response, HXAdviser *adviser))success
                                        failure:(void(^)(HXApiResponse *response))failure;

@end
