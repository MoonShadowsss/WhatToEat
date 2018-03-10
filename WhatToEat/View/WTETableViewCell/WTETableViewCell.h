//
//  WTETableViewCell.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTEDishItemModel.h"

@interface WTETableViewCell : UITableViewCell

@property (strong, nonatomic) WTEDishItemModel *dishItemModel;

- (void)setup;

@end
