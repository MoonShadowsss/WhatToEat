//
//  DetailViewModel.h
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKNetworking.h"
#import "StoreDetailModel.h"
#import "StoreItemViewModel.h"

@interface DetailViewModel : NSObject<YLNetworkingRACProtocol>
@property (strong, nonatomic) StoreItemViewModel *storeItemViewModel;
@property (copy, nonatomic) NSArray<DishModel *> *dishModels;

@end
