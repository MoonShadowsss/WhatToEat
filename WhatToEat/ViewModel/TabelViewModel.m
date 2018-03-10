//
//  TabelViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "TabelViewModel.h"
#import "GetStoreAPIManager.h"

@interface TabelViewModel()<YLAPIManagerDataSource>
@property (strong, nonatomic) YLPageAPIManager *getStoreAPIManager;
@end

@implementation TabelViewModel
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
        NSMutableArray *storeViewModels = [x boolValue] ? [[NSMutableArray alloc] init] : [NSMutableArray arrayWithArray:self.storeItemViewModels];
        NSArray *newStoreModels = [self.getStoreAPIManager fetchDataFromModel:StoreItemModel.class];
        RACSequence *storeViewModelSeq = [newStoreModels.rac_sequence map:^id(StoreItemModel *model) {
            return [[StoreItemViewModel alloc] initWithModel:model];
        }];
        [storeViewModels addObjectsFromArray:storeViewModelSeq.array];
        self.storeItemViewModels = [storeViewModels arrayByAddingObjectsFromArray: storeViewModels];
        self.storeCount = self.storeItemViewModels.count;
    }];
}

- (id<YLNetworkingListRACOperationProtocol>)networkingRAC {
    return self.getStoreAPIManager;
}

- (BOOL)hasNextPage {
    return self.getStoreAPIManager.hasNextPage;
}

- (NSDictionary *)paramsForAPI:(YLBaseAPIManager *)manager {
    NSDictionary *params = @{};
    if (manager == self.getStoreAPIManager) {
        params = @{
                   kGetStoreAPIManagerParamsKeyMenuId:self.menuId?:@""
                   };
    }
    return params;
}

- (YLPageAPIManager *)getStoreAPIManager{
    if (_getStoreAPIManager == nil) {
        _getStoreAPIManager = [[GetStoreAPIManager alloc] init];
        _getStoreAPIManager.dataSource = self;
    }
    return _getStoreAPIManager;
}
@end
