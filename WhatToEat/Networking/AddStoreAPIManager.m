//
//  AddStoreAPIManager.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "AddStoreAPIManager.h"

NSString * const kRandomStoreAPIManagerParamsKeyStoreId = @"kRandomStoreAPIManagerParamsKeyStoreId";
@implementation AddStoreAPIManager
- (BOOL)isAuth {
    return false;
}

- (NSString *)path {
    return @"addStore";
}

- (NSString *)apiVersion {
    return @"1.0";
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"store_id"] = params[kRandomStoreAPIManagerParamsKeyStoreId];
    return resultParams;
}

- (NSString *)keyOfResult {
    return @"store_list";
}
@end
