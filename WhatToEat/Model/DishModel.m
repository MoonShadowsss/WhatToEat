//
//  DishModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "DishModel.h"

@implementation DishModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"dish_name",
             @"location":@"dish_cost",
             @"pictureURL":@"dish_picture",
             @"information":@"dish_info",
             };
}

+ (NSValueTransformer *)pictureURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:value];
    }];
}
@end
