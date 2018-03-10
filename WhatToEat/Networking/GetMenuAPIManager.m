//
//  GetMenuAPIManager.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "GetMenuAPIManager.h"

@implementation GetMenuAPIManager

- (BOOL)isAuth {
    return false;
}

- (NSString *)path {
    return @"getMenu/";
}

- (NSString *)apiVersion {
    return @"1.0";
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"longitude"] = [WTELocation sharedLocation].longitude;
    resultParams[@"latitude"] = [WTELocation sharedLocation].latitude;
    return resultParams;
}

- (NSString *)keyOfResult {
    return @"menu_list";
}


@end
