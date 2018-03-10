//
//  WTEMenuModel.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/11.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTEMenuItemModel.h"

@interface WTEMenuModel : NSObject

@property (assign, nonatomic) NSInteger menuCount;
@property (copy, nonatomic) NSArray<WTEMenuItemModel *> *menuModelItemArray;

- (instancetype)initWithData:(NSData *)data;

@end
