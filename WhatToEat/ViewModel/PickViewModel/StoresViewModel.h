//
//  StoresViewModel.h
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKNetworking.h"
#import "StoreItemViewModel.h"

@interface StoresViewModel : NSObject <YLNetworkingListRACProtocol>
@property (assign, nonatomic) NSInteger storeCount;
@property (nonatomic, copy) NSArray<StoreItemViewModel *> *storeItemViewModels;
@property (nonatomic, copy) NSString *menuId;
@end
