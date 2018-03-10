//
//  StoresViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "StoresViewModel.h"
#import "RandomStoreAPIManager.h"

@interface StoresViewModel()<YLAPIManagerDataSource>
@property (nonatomic, strong) RandomStoreAPIManager *randomStoreAPIManager;
@end

@implementation StoresViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupRAC];
    }
    return self;
}

- (void)setupRAC {
    @weakify(self);
    [self.randomStoreAPIManager.executionSignal subscribeNext:^(id x) {
        @strongify(self);
        NSArray *storeItemModels = [self.randomStoreAPIManager fetchDataFromModel:StoreItemModel.class];
        self.storeItemModels = [storeItemModels copy];
        self.storeCount = self.storeItemModels.count;
    }];
}

- (id<YLNetworkingListRACOperationProtocol>)networkingRAC {
    return self.randomStoreAPIManager;
}

# pragma mark - Getter & Setter
- (NSDictionary *)paramsForAPI:(YLBaseAPIManager *)manager {
    NSDictionary *params = @{};
    if (manager == self.randomStoreAPIManager) {
        params = @{
                   kRandomStoreAPIManagerParamsKeyMenuId:self.menuId?:@""
                   };
    }
    return params;
}

- (RandomStoreAPIManager *)randomStoreAPIManager {
    if (_randomStoreAPIManager == nil) {
        _randomStoreAPIManager = [[RandomStoreAPIManager alloc] init];
        _randomStoreAPIManager.dataSource = self;
    }
    return _randomStoreAPIManager;
}

@end
