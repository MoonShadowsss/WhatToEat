//
//  WTEDishModel.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/11.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTEDishItemModel.h"

@interface WTEDishModel : NSObject

@property (assign, nonatomic) NSInteger dishCount;
@property (copy, nonatomic) NSString *menuId;
@property (copy, nonatomic) NSArray<WTEDishItemModel *> *dishModelItemArray;

- (instancetype)initWithData:(NSData *)data;
//+ (instancetype)updateWithData:(NSData *)data dishModel:(WTEDishModel *)dishModel;

@end
