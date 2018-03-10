//
//  DeleteStoreAPIManager.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "DeleteStoreAPIManager.h"

NSString * const kDeleteStoreAPIManagerParamsKeyStoreId = @"kDeleteStoreAPIManagerParamsKeyStoreId";
@implementation DeleteStoreAPIManager
- (BOOL)isAuth {
    return false;
}

- (NSString *)path {
    return @"deleteStore";
}

- (NSString *)apiVersion {
    return @"1.0";
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"store_id"] = params[kDeleteStoreAPIManagerParamsKeyStoreId];
    return resultParams;
}

- (NSString *)keyOfResult {
    return @"data";
}
@end
