//
//  PickViewModel.m
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "PickViewModel.h"
#import "GetMenuAPIManager.h"

NSString * const kNetworkingRACTypeGetMenu = @"kNetworkingRACTypeGetMenu";
@interface PickViewModel()
@property (nonatomic, strong) GetMenuAPIManager *getMenuAPIManager;
@property (nonatomic, strong) YLNetworkingRACTable *networkingRACs;
@end

@implementation PickViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupRAC];
    }
    return self;
}

- (void)setupRAC {
    
}
- (YLNetworkingRACTable *)networkingRACs {
    if (_networkingRACs == nil) {
        _networkingRACs = [YLNetworkingRACTable strongToWeakObjectsMapTable];
        _networkingRACs[kNetworkingRACTypeGetMenu] = self.getMenuAPIManager;
    }
    return _networkingRACs;
}

# pragma mark - Getter & Setter

- (GetMenuAPIManager *)getMenuAPIManager {
    if (_getMenuAPIManager == nil) {
        _getMenuAPIManager = [[GetMenuAPIManager alloc] init];
    }
    return _getMenuAPIManager;
}

@end
