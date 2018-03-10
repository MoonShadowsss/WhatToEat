//
//  PickViewModel.h
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKNetworking.h"
#import "MenuItemModel.h"

@interface MenusViewModel : NSObject<YLNetworkingListRACProtocol>
@property (assign, nonatomic) NSInteger menuCount;
@property (nonatomic, copy) NSArray<MenuItemModel *> *menuItemModels;
@end

