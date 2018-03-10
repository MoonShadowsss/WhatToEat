//
//  WTEDishModelItem.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/6.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTEDishItemModel : NSObject

@property (copy, nonatomic) NSString *menuId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *dishId;
@property (strong, nonatomic) NSURL *picture;
@property (assign, nonatomic) BOOL isLike;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
