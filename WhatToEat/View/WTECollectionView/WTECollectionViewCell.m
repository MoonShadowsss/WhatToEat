//
//  WTECollectionViewCell.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/26.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTECollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface WTECollectionViewCell() <WTECardViewDataSource>

@property (strong, nonatomic) UILabel *menuNameLabel;
@property (strong, nonatomic) WTECardView *cardView;
@property (strong, nonatomic) UIButton *editButton;

@end

@implementation WTECollectionViewCell

#pragma mark - Life Cycle
- (void)setup {
    if (_viewModel != nil) {
        [self addSubview:self.cardView];
        self.cardView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.767);
        [self.cardView reloadData];
    }
    [self addSubview:self.menuNameLabel];
    self.menuNameLabel.frame = CGRectMake(0, self.frame.size.height * 0.81, self.frame.size.width, self.frame.size.height * 0.036);
    self.menuNameLabel.font = [UIFont fontWithName:@"Helvetica" size:self.frame.size.height * 0.036];
    [self addSubview:self.editButton];
    self.editButton.frame = CGRectMake(self.frame.size.width / 2 - self.frame.size.height * 0.1 / 2, self.frame.size.height * 0.9, self.frame.size.height * 0.1, self.frame.size.height * 0.1);
}

#pragma mark - Button Event
- (void)editButtonDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(editButtonDidClickOnCollectionViewCell:)]) {
        [self.delegate editButtonDidClickOnCollectionViewCell:self];
    }
}

#pragma mark - Delegate & DataSource
- (UIImage *)cardView:(WTECardView *)cardView imageAtIndex:(NSInteger)index {
    NSData *pictureData = [NSData dataWithContentsOfURL:self.viewModel.storeItemViewModels[index].model.pictureURL];
    if (pictureData != nil) {
        UIImage *picture = [UIImage imageWithData:pictureData];
        return picture;
    } else {
        return [UIImage imageNamed:@"food1"];
    }
}

- (BOOL)cardView:(WTECardView *)cardView likeAtIndex:(NSInteger)index {
    return self.viewModel.storeItemViewModels[index].model.isLike;
}

- (NSString *)cardView:(WTECardView *)cardView nameAtIndex:(NSInteger)index {
    return self.viewModel.storeItemViewModels[index].model.name;
}

- (NSString *)cardView:(WTECardView *)cardView locationAtIndex:(NSInteger)index {
    return self.viewModel.storeItemViewModels[index].model.location;
}

- (NSInteger)numberOfCardItemViewInCardView:(WTECardView *)cardView {
    return self.viewModel.storeCount;
}

- (NSString *)cardView:(WTECardView *)cardView dishIdAtIndex:(NSInteger)index {
    return self.viewModel.storeItemViewModels[index].model.storeId;
}

- (StoreItemViewModel *)cardView:(WTECardView *)cardView viewModelAtIndex:(NSInteger)index {
    return self.viewModel.storeItemViewModels[index];
}

- (void)likeButtonDidClick:(WTECardItemView *)cardItemView {
    NSLog(@"Click");
}

- (UIImage *)coverImageForCardView:(WTECardView *)cardView {
    NSData *pictureData = [NSData dataWithContentsOfURL:self.menuItemModel.pictureURL];
    if (pictureData != nil) {
        UIImage *picture = [UIImage imageWithData:pictureData];
        return picture;
    } else {
        return [UIImage imageNamed:@"food2"];
    }
}

- (void)cardViewNeedsMoreData:(WTECardView *)cardView {
#warning update
}

#pragma mark - Getter & Setter
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.menuNameLabel.font = [UIFont fontWithName:@"Helvetica" size:frame.size.height * 0.028];
}

- (void)setMenuItemModel:(MenuItemModel *)menuItemModel {
    _menuItemModel = menuItemModel;
    self.menuNameLabel.text = menuItemModel.name;
}

- (WTECardView *)cardView {
    if (_cardView == nil) {
        _cardView = [[WTECardView alloc] init];
        _cardView.dataSource = self;
    }
    return _cardView;
}

- (UILabel *)menuNameLabel {
    if (_menuNameLabel == nil) {
        _menuNameLabel = [[UILabel alloc] init];
        _menuNameLabel.text = @"titleLabel";
        _menuNameLabel.textAlignment = NSTextAlignmentCenter;
        _menuNameLabel.textColor = [UIColor whiteColor];
    }
    return _menuNameLabel;
}

- (UIButton *)editButton {
    if (_editButton == nil) {
        _editButton = [[UIButton alloc] init];
        [_editButton addTarget:self action:@selector(editButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [_editButton setImage:[UIImage imageNamed:@"cell"] forState:UIControlStateNormal];
        _editButton.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _editButton;
}

@end

