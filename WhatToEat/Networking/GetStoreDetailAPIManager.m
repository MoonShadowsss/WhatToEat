//
//  GetStoreDetailAPIManager.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "GetStoreDetailAPIManager.h"

NSString * const kGetStoreDetailAPIManagerParamsKeyStoreId = @"kGetStoreDetailAPIManagerParamsKeyStoreId";
@implementation GetStoreDetailAPIManager
- (BOOL)isAuth {
    return false;
}

- (NSString *)path {
    return @"getStoreDetail/";
}

- (NSString *)apiVersion {
    return @"1.0";
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"store_id"] = params[kGetStoreDetailAPIManagerParamsKeyStoreId];
    resultParams[@"longitude"] = [WTELocation sharedLocation].longitude;
    resultParams[@"latitude"] = [WTELocation sharedLocation].latitude;
    return resultParams;
}

- (NSString *)keyOfResult {
    return @"data";
}

@end
