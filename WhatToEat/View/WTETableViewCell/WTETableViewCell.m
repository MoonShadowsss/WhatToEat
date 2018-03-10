//
//  WTETableViewCell.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTETableViewCell.h"
#import <Masonry/Masonry.h>
@interface WTETableViewCell()

@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (assign, nonatomic) BOOL isLike;
@property (strong, nonatomic) UIView *shadowView;
@property (strong, nonatomic) UIButton *likeButton;

@end

@implementation WTETableViewCell

#pragma mark - Life Cycle
- (void)setup {
    [self addSubview:self.shadowView];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_height).multipliedBy(0.68);
        make.height.equalTo(self.shadowView.mas_width);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.frame.size.width * 0.036);
    }];
    [self addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_height).multipliedBy(0.68);
        make.height.equalTo(self.pictureImageView.mas_width);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(self.frame.size.width * 0.036);
    }];
    [self addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:self.frame.size.height * 0.4];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.frame.size.height * 0.3);
        make.left.equalTo(self.mas_left).offset(self.frame.size.width * 0.25);
    }];
    [self addSubview:self.locationLabel];
    self.locationLabel.font = [UIFont fontWithName:@"Helvetica" size:self.frame.size.height * 0.3];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-self.frame.size.height * 0.3);
        make.left.equalTo(self.mas_left).offset(self.frame.size.width * 0.25);
    }];
    [self addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(self.mas_height).multipliedBy(0.267);
        make.left.equalTo(self.mas_left).offset(self.frame.size.width * 0.95);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma mark - Button Event
- (void)likeButtonDidClick:(UIButton *)sender {
    NSLog(@"Click");
#warning POST method
}

#pragma mark - Getter & Setter
- (void)setStoreItemModel:(StoreItemModel *)storeItemModel {
    _storeItemModel = storeItemModel;
    self.locationLabel.text = storeItemModel.location;
    self.nameLabel.text = storeItemModel.name;
    self.isLike = storeItemModel.isLike;
    NSData *pictureData = [NSData dataWithContentsOfURL:storeItemModel.pictureURL];
    if (pictureData == nil) {
        self.pictureImageView.image = [UIImage imageNamed:@"food2"];
    } else {
        self.pictureImageView.image = [UIImage imageWithData:pictureData];
    }
}

- (UIView *)shadowView {
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.shadowColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1].CGColor;
        _shadowView.layer.shadowOpacity = 0.64;
        _shadowView.layer.shadowOffset = CGSizeZero;
        _shadowView.backgroundColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 255.0f blue:244.0f / 255.0f alpha:1];
    }
    return _shadowView;
}

- (UIImageView *)pictureImageView {
    if (_pictureImageView == nil) {
        _pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _pictureImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1];
        _nameLabel.text = @"nameLabel";
    }
    return _nameLabel;
}

- (UILabel *)locationLabel {
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        _locationLabel.textColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:0.72];
        _locationLabel.text = @"locationLabel";
    }
    return _locationLabel;
}

- (UIButton *)likeButton {
    if (_likeButton == nil) {
        _likeButton = [[UIButton alloc] init];
        _likeButton.imageView.contentMode = UIViewContentModeScaleToFill;
        [_likeButton addTarget:self action:@selector(likeButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}

- (void)setIsLike:(BOOL)like {
    _isLike = like;
    if (like == YES) {
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
    }
}

@end
