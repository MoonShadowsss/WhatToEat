//
//  WTETableViewCell.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreItemModel.h"

@interface WTETableViewCell : UITableViewCell

@property (strong, nonatomic) StoreItemModel *storeItemModel;

- (void)setup;

@end
