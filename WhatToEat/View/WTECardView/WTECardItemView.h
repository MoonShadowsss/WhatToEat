//
//  WTECardItemView.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreItemViewModel.h"

@class WTECardItemView;

@interface WTECardItemView : UIView

@property (copy, nonatomic) NSString *dishId;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *placeLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) BOOL isLike;
@property (strong, nonatomic) StoreItemViewModel *viewModel;

- (void)setup;

@end
