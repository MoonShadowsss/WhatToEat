//
//  WTELocationManager.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTELocation.h"
static WTELocation *locationManager;
@implementation WTELocation

+ (instancetype)sharedLocation {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[WTELocation alloc] init];
    });
    return locationManager;
}


@end
