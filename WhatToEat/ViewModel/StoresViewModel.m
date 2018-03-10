//
//  StoresViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "StoresViewModel.h"
#import "GetStoreAPIManager.h"

@interface StoresViewModel()
@property (nonatomic, strong) GetStoreAPIManager *getStoreAPIManager;
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
    [self.getStoreAPIManager.executionSignal subscribeNext:^(id x) {
        @strongify(self);
        NSArray *storeItemModels = [self.getStoreAPIManager fetchDataFromModel:StoreItemModel.class];
        self.storeItemModels = [storeItemModels copy];
        self.storeCount = self.storeItemModels.count;
    }];
}

- (id<YLNetworkingRACOperationProtocol>)networkingRAC {
    return self.getStoreAPIManager;
}

# pragma mark - Getter & Setter

- (GetStoreAPIManager *)getStoreAPIManager {
    if (_getStoreAPIManager == nil) {
        _getStoreAPIManager = [[GetStoreAPIManager alloc] init];
    }
    return _getStoreAPIManager;
}

@end
