//
//  AddStoreAPIManager.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "AddStoreAPIManager.h"

NSString * const kAddStoreAPIManagerParamsKeyStoreId = @"kAddStoreAPIManagerParamsKeyStoreId";
@implementation AddStoreAPIManager
- (BOOL)isAuth {
    return false;
}

- (NSString *)path {
    return @"addStore/";
}

- (NSString *)apiVersion {
    return @"1.0";
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"longitude"] = [WTELocation sharedLocation].longitude;
    resultParams[@"latitude"] = [WTELocation sharedLocation].latitude;
    resultParams[@"store_id"] = params[kAddStoreAPIManagerParamsKeyStoreId];
    return resultParams;
}

- (NSString *)keyOfResult {
    return @"data";
}


@end
