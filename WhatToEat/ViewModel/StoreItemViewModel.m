//
//  StoreItemViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "StoreItemViewModel.h"
#import "AddStoreAPIManager.h"

@interface StoreItemViewModel()<YLAPIManagerDataSource>
@property (strong, nonatomic) YLBaseAPIManager *addStoreAPIManager;
@end

@implementation StoreItemViewModel

- (id<YLNetworkingRACOperationProtocol>)networkingRAC {
    return self.addStoreAPIManager;
}

# pragma mark - Getter & Setter
- (NSDictionary *)paramsForAPI:(YLBaseAPIManager *)manager {
    NSDictionary *params = @{};
    if (manager == self.addStoreAPIManager) {
        params = @{
                   kRandomStoreAPIManagerParamsKeyStoreId:self.model.storeId?:@""
                   };
    }
    return params;
}

- (YLBaseAPIManager *)addStoreAPIManager {
    if (_addStoreAPIManager == nil) {
        _addStoreAPIManager = [[AddStoreAPIManager alloc] init];
        _addStoreAPIManager.dataSource = self;
    }
    return _addStoreAPIManager;
}

- (StoreItemModel *)model {
    if (_model == nil) {
        _model = [[StoreItemModel alloc] init];
    }
    return _model;
}
@end
