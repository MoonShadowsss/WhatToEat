//
//  WTEDetailTableViewCell.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DishModel.h"

@interface WTEDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) DishModel *dishModel;

- (void)setup;

@end
