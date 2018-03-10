//
//  WTELocationManager.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WTELocation : NSObject

@property (copy, nonatomic) NSString *longitude;
@property (copy, nonatomic) NSString *latitude;

+ (instancetype)sharedLocation;

@end
