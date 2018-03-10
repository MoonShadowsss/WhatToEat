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
        StoreItemModel *storeItemModel = [[StoreItemModel alloc] init];
        storeItemModel.name = @"\u62fc\u8c46\u591c\u5bb5(\u79d1\u6280\u8def\u5e97)";
        storeItemModel.location = @"\u4e0a\u6d77\u5e02\u5f90\u6c47\u533a\u8679\u6885\u8def1801\u53f7A\u533a\u51ef\u79d1\u56fd\u9645\u5927\u53a6\u540d\u4e49\u697c\u5ba4\u53f71801-1808\u5ba4\u30011901-1908\u5ba4\u548c2001-2008\u5ba4";
        storeItemModel.storeId = storeDetailModel.storeId;
        storeItemModel.pictureURL = [NSURL URLWithString:@"https://fuss10.elemecdn.com/1/32/c75a72f674052473fb35b5c8ab1d7jpeg.jpeg"];
        storeItemModel.information = storeItemModel.location;
        storeItemModel.buyURL = storeDetailModel.buyURL;
        storeItemModel.isLike = storeDetailModel.isLike;
        _storeItemViewModel = [_storeItemViewModel initWithModel:storeItemModel];
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
