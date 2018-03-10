


//
//  StoreDetailModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "StoreDetailModel.h"

@interface StoreDetailModel()
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *location;
@property (strong, nonatomic) NSURL *pictureURL;
@property (copy, nonatomic) NSString *information;
@property (strong, nonatomic) NSURL *buyURL;
@property (assign, nonatomic) BOOL isLike;
@end

@implementation StoreDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"store_name",
             @"location":@"store_location",
             @"pictureURL":@"store_image",
             @"information":@"store_info",
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

- (StoreItemModel *)storeItemModel {
    if (_storeItemModel == nil) {
        _storeItemModel = [[StoreItemModel alloc] init];
    }
    _storeItemModel.name = self.name;
    _storeItemModel.location = self.location;
    _storeItemModel.information = self.information;
    _storeItemModel.pictureURL = self.pictureURL;
    _storeItemModel.buyURL = self.buyURL;
    _storeItemModel.isLike = self.isLike;
    return _storeItemModel;

}
@end
