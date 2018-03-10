//
//  WTEMenuModelItem.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/6.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTEMenuItemModel.h"

@implementation WTEMenuItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.menuId = dictionary[@"menu_id"];
        self.name = dictionary[@"menu_name"];
        self.location = dictionary[@"menu_location"];
        self.picture = [NSURL URLWithString:dictionary[@"menu_picture"]];
    }
    return self;
}

@end
