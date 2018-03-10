//
//  GetStoreAPIManager.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "GetStoreAPIManager.h"

@implementation GetStoreAPIManager
- (BOOL)isAuth {
    return false;
}

- (NSString *)path {
    return @"randomStore";
}

- (NSString *)apiVersion {
    return @"1.0";
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    return resultParams;
}

- (NSString *)keyOfResult {
    return @"store_lis";
}
@end
