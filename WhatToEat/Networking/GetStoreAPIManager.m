//
//  GetStoreAPIManager.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "GetStoreAPIManager.h"

NSString * const kGetStoreAPIManagerParamsKeyMenuId = @"kGetStoreAPIManagerParamsKeyMenuId";
@implementation GetStoreAPIManager
- (BOOL)isAuth {
    return false;
}

- (NSString *)path {
    return @"getStore";
}

- (NSString *)apiVersion {
    return @"1.0";
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"menu_id"] = params[kGetStoreAPIManagerParamsKeyMenuId];
    resultParams[@"since_id"] = [self sinceId];
    resultParams[@"page_size"] = @(self.pageSize);
    resultParams[@"longitude"] = [WTELocation sharedLocation].longitude;
    resultParams[@"latitude"] = [WTELocation sharedLocation].latitude;
    return resultParams;
}

- (NSString *)keyOfResult {
    return @"store_list";
}

- (NSString *)keyOfResultItemId {
    return @"store_id";
}
@end
