//
//  DetailViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel
- (instancetype)initWithModel:(StoreDetailModel *)model {
    self = [super init];
    if (self) {
        _storeItemViewModel = [_storeItemViewModel initWithModel:model.storeItemModel];
        self.dishModels = [model.dishModels copy];
    }
    return self;
}

@end
