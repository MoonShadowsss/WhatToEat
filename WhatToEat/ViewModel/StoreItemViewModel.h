//
//  StoreItemViewModel.h
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKNetworking.h"
#import "StoreItemModel.h"

@interface StoreItemViewModel : NSObject<YLNetworkingRACProtocol>
@property (nonatomic, strong) StoreItemModel *model;
@end