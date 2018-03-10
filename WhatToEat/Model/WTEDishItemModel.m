//
//  WTEDishModelItem.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/6.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTEDishItemModel.h"

@implementation WTEDishItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    if (self = [super init]) {
        self.name = dictionary[@"dish_name"];
        self.location = dictionary[@"dish_location"];
        self.dishId = dictionary[@"dish_id"];
        self.picture = [NSURL URLWithString:dictionary[@"dish_picture"]];
        self.isLike = [dictionary[@"is_like"] isEqual:@"true"] ? YES : NO;
    }
    return self;
}

@end
