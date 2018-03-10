//
//  StoreItemModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "StoreItemModel.h"

@implementation StoreItemModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"store_name",
             @"location":@"store_location",
             @"pictureURL":@"store_picture",
             @"storeId":@"store_id",
             @"isLike":@"is_like",
             };
}

+ (NSValueTransformer *)pictureURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:value];
    }];
}

@end
