//
//  WTEMenuModel.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/11.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTEMenuModel.h"

@implementation WTEMenuModel

- (instancetype)initWithData:(NSData *)data {
    if (self = [super init]) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *menuArray = jsonDictionary[@"data"][@"menu_list"];
        self.menuCount = menuArray.count;
        NSMutableArray<WTEMenuItemModel *> *temMenuModelItemArray = [NSMutableArray array];
        for (NSDictionary *dict in menuArray) {
            WTEMenuItemModel *tem = [[WTEMenuItemModel alloc] initWithDictionary:dict];
            [temMenuModelItemArray addObject:tem];
        }
        self.menuModelItemArray = [temMenuModelItemArray copy];
    }
    return self;
}

@end
