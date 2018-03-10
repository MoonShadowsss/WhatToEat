//
//  WTEDishModel.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/11.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTEDishModel.h"

@implementation WTEDishModel

- (instancetype)initWithData:(NSData *)data {
    if (self = [super init]) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *dishArray = jsonDictionary[@"data"];
        self.dishCount = dishArray.count;
        NSMutableArray<WTEDishItemModel *> *temDishModelItemArray = [NSMutableArray array];
        for (NSDictionary *dict in dishArray) {
            WTEDishItemModel *tem = [[WTEDishItemModel alloc] initWithDictionary:dict];
            [temDishModelItemArray addObject:tem];
        }
        self.dishModelItemArray = [temDishModelItemArray copy];
    }
    return self;
}

//+ (instancetype)updateWithData:(NSData *)data dishModel:(WTEDishModel *)dishModel {
//    WTEDishModel *updateDishModel = [[WTEDishModel alloc] initWithData:data];
//    updateDishModel.dishCount = updateDishModel.dishCount + dishModel.dishCount;
//    updateDishModel.nameArray = [dishModel.nameArray arrayByAddingObjectsFromArray:updateDishModel.nameArray];
//    updateDishModel.locationArray = [dishModel.locationArray arrayByAddingObjectsFromArray:updateDishModel.locationArray];
//    updateDishModel.idArray = [dishModel.idArray arrayByAddingObjectsFromArray:updateDishModel.idArray];
//    updateDishModel.pictureArray = [dishModel.pictureArray arrayByAddingObjectsFromArray:dishModel.pictureArray];
//    updateDishModel.likeArray = [dishModel.likeArray arrayByAddingObjectsFromArray:updateDishModel.likeArray];
//    return updateDishModel;
//}
- (void)setMenuId:(NSString *)menuId {
    _menuId = menuId;
    for (WTEDishItemModel *item in self.dishModelItemArray) {
        item.menuId = _menuId;
    }
}

@end
