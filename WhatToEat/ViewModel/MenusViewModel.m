//
//  PickViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "MenusViewModel.h"
#import "GetMenuAPIManager.h"

@interface MenusViewModel()
@property (nonatomic, strong) GetMenuAPIManager *getMenuAPIManager;
@end

@implementation MenusViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupRAC];
    }
    return self;
}

- (void)setupRAC {
    @weakify(self);
    [self.getMenuAPIManager.executionSignal subscribeNext:^(id x) {
        @strongify(self);
        NSArray *menuItemModels = [self.getMenuAPIManager fetchDataFromModel:MenuItemModel.class];
        self.menuItemModels = [menuItemModels copy];
        self.menuCount = self.menuItemModels.count;
    }];
}

- (id<YLNetworkingRACOperationProtocol>)networkingRAC {
    return self.getMenuAPIManager;
}

# pragma mark - Getter & Setter

- (GetMenuAPIManager *)getMenuAPIManager {
    if (_getMenuAPIManager == nil) {
        _getMenuAPIManager = [[GetMenuAPIManager alloc] init];
    }
    return _getMenuAPIManager;
}

@end

