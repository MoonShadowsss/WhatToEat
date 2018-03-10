//
//  DetailViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "DetailViewModel.h"
#import "GetStoreDetailAPIManager.h"

@interface DetailViewModel()<YLAPIManagerDataSource>
@property (nonatomic, strong) YLBaseAPIManager *getStoreDetailAPIManager;
@end

@implementation DetailViewModel
- (instancetype)initWithModel:(StoreDetailModel *)model {
    self = [super init];
    if (self) {
        _storeItemViewModel = [_storeItemViewModel initWithModel:model.storeItemModel];
        self.dishModels = [model.dishModels copy];
    }
    return self;
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
        _getStoreDetailAPIManager = [[YLBaseAPIManager alloc] init];
        _getStoreDetailAPIManager.dataSource = self;
    }
    return _getStoreDetailAPIManager;
}
@end
