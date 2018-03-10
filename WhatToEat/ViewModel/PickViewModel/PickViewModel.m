//
//  PickViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "PickViewModel.h"

@implementation PickViewModel

- (id<YLNetworkingListRACOperationProtocol>)networkingRAC {
    return self.menusViewModel.networkingRAC;
}

- (NSMutableArray *)storesViewModels {
    if (_storesViewModels == nil) {
        _storesViewModels = [[ NSMutableArray alloc] init];
    }
    return _storesViewModels;
}

- (MenusViewModel *)menusViewModel {
    if (_menusViewModel == nil) {
        _menusViewModel = [[MenusViewModel alloc] init];
    }
    return _menusViewModel;
}
@end
