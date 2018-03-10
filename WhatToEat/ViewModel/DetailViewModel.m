//
//  DetailViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "DetailViewModel.h"
#import "GetStoreDetailAPIManager.h"
#import "StoreDetailModel.h"

@interface DetailViewModel()<YLAPIManagerDataSource>
@property (nonatomic, strong) YLBaseAPIManager *getStoreDetailAPIManager;
@end

@implementation DetailViewModel
- (instancetype) init {
    self = [super init];
    if (self) {
        [self setupRAC];
    }
    return self;
}

- (void)setupRAC {
    @weakify(self);
    
    [self.getStoreDetailAPIManager.executionSignal subscribeNext:^(id x) {
        @strongify(self);
        StoreDetailModel *storeDetailModel = [self.getStoreDetailAPIManager fetchDataFromModel:StoreDetailModel.class];
        _storeItemViewModel = [_storeItemViewModel initWithModel:storeDetailModel.storeItemModel];
        _dishModels = [storeDetailModel.dishModels copy];
    }];
}
- (id<YLNetworkingRACOperationProtocol>)networkingRAC {
    return self.getStoreDetailAPIManager;
}

- (NSDictionary *)paramsForAPI:(YLBaseAPIManager *)manager {
    NSDictionary *params = @{};
    if (manager == self.getStoreDetailAPIManager) {
        params = @{
                   kGetStoreDetailAPIManagerParamsKeyStoreId:self.storeItemViewModel.model.storeId?:@""
                   };
    }
    return params;
}

- (YLBaseAPIManager *)getStoreDetailAPIManager {
    if (_getStoreDetailAPIManager == nil) {
        _getStoreDetailAPIManager = [[GetStoreDetailAPIManager alloc] init];
        _getStoreDetailAPIManager.dataSource = self;
    }
    return _getStoreDetailAPIManager;
}
@end
