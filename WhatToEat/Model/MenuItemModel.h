//
//  MenuItemModel.h
//  WhatToEat
//
//  Created by 殷子欣 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface MenuItemModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *pictureURL;
@property (copy, nonatomic) NSString *menuId;

@end
