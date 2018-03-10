//
//  StoreItemViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "StoreItemViewModel.h"
#import "AddStoreAPIManager.h"
#import "DeleteStoreAPIManager.h"

NSString * const kNetworkingRACTypeAddStore = @"kNetworkingRACTypeAddStore";
NSString * const kNetworkingRACTypeDeleteStore = @"kNetworkingRACTypeDeleteStore";
@interface StoreItemViewModel()<YLAPIManagerDataSource>
@property (nonatomic, strong) YLNetworkingRACTable *networkingRACs;
@property (strong, nonatomic) YLBaseAPIManager *addStoreAPIManager;
@property (strong, nonatomic) YLBaseAPIManager *deleteStoreAPIManager;
@end

@implementation StoreItemViewModel

- (instancetype)initWithModel:(StoreItemModel *)model {
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (YLNetworkingRACTable *)networkingRACs {
    if (_networkingRACs == nil) {
        _networkingRACs = [YLNetworkingRACTable strongToWeakObjectsMapTable];
        _networkingRACs[kNetworkingRACTypeAddStore] = self.addStoreAPIManager;
        _networkingRACs[kNetworkingRACTypeDeleteStore] = self.deleteStoreAPIManager;
    }
    return _networkingRACs;
}

# pragma mark - Getter & Setter
- (NSDictionary *)paramsForAPI:(YLBaseAPIManager *)manager {
    NSDictionary *params = @{};
    if (manager == self.addStoreAPIManager) {
        params = @{
                   kAddStoreAPIManagerParamsKeyStoreId:self.model.storeId?:@""
                   };
    } else if (manager == self.deleteStoreAPIManager) {
        params = @{
                   kDeleteStoreAPIManagerParamsKeyStoreId:self.model.storeId?:@""
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

- (YLBaseAPIManager *)deleteStoreAPIManager {
    if (_deleteStoreAPIManager == nil) {
        _deleteStoreAPIManager = [[DeleteStoreAPIManager alloc] init];
        _deleteStoreAPIManager.dataSource = self;
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
