//
//  GetStoreAPIManager.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "RandomStoreAPIManager.h"

NSString * const kRandomStoreAPIManagerParamsKeyMenuId = @"kRandomStoreAPIManagerParamsKeyMenuId";
@implementation RandomStoreAPIManager
- (BOOL)isAuth {
    return false;
}

- (NSString *)path {
    return @"randomStore/";
}

- (NSString *)apiVersion {
    return @"1.0";
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"longitude"] = [WTELocation sharedLocation].longitude;
    resultParams[@"latitude"] = [WTELocation sharedLocation].latitude;
    resultParams[@"menu_id"] = params[kRandomStoreAPIManagerParamsKeyMenuId];
    resultParams[@"page_size"] = @5;
    resultParams[@"user_name"] = @"test";
    resultParams[@"user_pwd"] = @"test";
    return resultParams;
}

- (NSString *)keyOfResult {
    return @"store_list";
}
@end
