//
//  WTECollectionViewLayout.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/26.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>

// 仅支持横向滚动
@interface WTECollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) CGSize itemSize;
@property (assign, nonatomic) CGFloat spacing;

@end
