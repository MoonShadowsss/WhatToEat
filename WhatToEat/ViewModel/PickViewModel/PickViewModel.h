//
//  PickViewModel.h
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenusViewModel.h"
#import "StoresViewModel.h"

@interface PickViewModel : NSObject<YLNetworkingListRACProtocol>
@property (strong, nonatomic) NSMutableArray<StoresViewModel *> *storesViewModels;
@property (strong, nonatomic) MenusViewModel *menusViewModel;
@end
