//
//  WTEDetailViewController.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTEDetailTableViewCell.h"
#import "StoreItemViewModel.h"
#import "UIImageView+LBBlurredImage.h"

@interface WTEDetailViewController : UIViewController

@property (strong, nonatomic) StoreItemViewModel *storeItemViewModel;

@end
