//
//  WTECardView.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTECardItemView.h"
#import "WTECardCoverView.h"

@class WTECardView;

@protocol WTECardViewDataSource <NSObject>
@required
- (NSInteger)numberOfCardItemViewInCardView:(WTECardView *)cardView;
- (UIImage *)coverImageForCardView:(WTECardView *)cardView;
- (UIImage *)cardView:(WTECardView *)cardView imageAtIndex:(NSInteger)index;
- (NSString *)cardView:(WTECardView *)cardView nameAtIndex:(NSInteger)index;
- (NSString *)cardView:(WTECardView *)cardView locationAtIndex:(NSInteger)index;
- (NSString *)cardView:(WTECardView *)cardView dishIdAtIndex:(NSInteger)index;
- (BOOL)cardView:(WTECardView *)cardView likeAtIndex:(NSInteger)index;

@optional
- (void)cardViewNeedsMoreData:(WTECardView *)cardView;

@end

@interface WTECardView : UIView
@property (weak, nonatomic) id<WTECardViewDataSource> dataSource;

- (void)reloadData;

@end
