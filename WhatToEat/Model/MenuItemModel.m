//
//  MenuItemModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "MenuItemModel.h"

@implementation MenuItemModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"menu_name",
             @"pictureURL":@"menu_image",
             @"menuId":@"menu_id",
             };
}

+ (NSValueTransformer *)pictureURLJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:value];
    }];
}

@end
