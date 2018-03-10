


//
//  StoreDetailModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "StoreDetailModel.h"

@interface StoreDetailModel()
@end

@implementation StoreDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"store_name",
             @"location":@"store_location",
             @"pictureURL":@"store_image",
             @"information":@"store_info",
             @"storeId":@"store_id",
             @"buyURL":@"url",
             @"isLike":@"is_like",
             @"dishModels":@"dish_list",
             };
}

+ (NSValueTransformer *)pictureURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:value];
    }];
}

+ (NSValueTransformer *)buyURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:value];
    }];
}

@end
