//
//  WTECollectionViewCell.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/26.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTEMenuItemModel.h"
#import "WTEDishModel.h"
#import "WTECardView.h"

@class WTECollectionViewCell;

@protocol WTECollectionViewCellDelegate <NSObject>
@optional
- (void)editButtonDidClickOnCollectionViewCell:(WTECollectionViewCell *)collectionViewCell;
@end

@interface WTECollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<WTECollectionViewCellDelegate> delegate;
@property (strong, nonatomic) WTEMenuItemModel *menuItemModel;
@property (strong, nonatomic) WTEDishModel *dishModel;

- (void)setup;

@end
