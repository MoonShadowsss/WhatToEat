//
//  WTECardItemView.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTECardItemView.h"
#import <Masonry/Masonry.h>

@interface WTECardItemView()

@property (strong, nonatomic) UIView *cardView;
@property (strong, nonatomic) UIButton *likeButton;

@end

@implementation WTECardItemView

#pragma mark - Life Cycle
- (void)setup {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.layer.shadowColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1].CGColor;
    self.layer.shadowOpacity = 0.64;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 8;
    self.layer.cornerRadius = self.frame.size.height / 30;
    self.backgroundColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 255.0f blue:244.0f / 255.0f alpha:1];
    
    self.cardView.frame = self.bounds;
    self.cardView.clipsToBounds = YES;
    self.cardView.layer.cornerRadius = self.frame.size.height / 30;
    [self addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.cardView addSubview:self.likeButton];
    [self.cardView addSubview:self.imageView];
    [self.cardView addSubview:self.nameLabel];
    [self.cardView addSubview:self.placeLabel];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cardView.mas_bottom).offset(-self.cardView.frame.size.height * 0.058);
        make.height.width.equalTo(self.cardView.mas_height).multipliedBy(0.06);
        make.centerX.equalTo(self.cardView.mas_centerX);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardView.mas_top);
        make.left.equalTo(self.cardView.mas_left);
        make.right.equalTo(self.cardView.mas_right);
        make.height.equalTo(self.cardView.mas_height).multipliedBy(0.556);
    }];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:self.cardView.frame.size.height / 15];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardView.mas_top).offset(self.cardView.frame.size.height * 0.645);
        make.width.equalTo(self.cardView.mas_width).offset(-20);
        make.centerX.equalTo(self.cardView.mas_centerX);
    }];
    self.placeLabel.font = [UIFont fontWithName:@"Helvetica" size:self.cardView.frame.size.height / 23];
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardView.mas_top).offset(self.cardView.frame.size.height * 0.784);
        make.width.equalTo(self.cardView.mas_width).offset(-20);
        make.centerX.equalTo(self.cardView.mas_centerX);
    }];
}

#pragma mark - Button Event
- (void)likeButtonDidClick:(UIButton *)sender {

#warning POST未写
    self.isLike = !self.isLike;
}

#pragma mark - Getter & Setter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.layer.cornerRadius = frame.size.height / 30;
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:frame.size.height / 15];
    self.placeLabel.font = [UIFont fontWithName:@"Helvetica" size:frame.size.height / 20];
    if ([[self.cardView subviews] containsObject:self.nameLabel]) {
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cardView.mas_top).offset(frame.size.height * 0.645);
        }];
    }
    if ([[self.cardView subviews] containsObject:self.placeLabel]) {
        [self.placeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cardView.mas_top).offset(frame.size.height * 0.784);
        }];
    }
    if ([[self.cardView subviews] containsObject:self.likeButton]) {
        [self.likeButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cardView.mas_bottom).offset(-frame.size.height * 0.058);
        }];
    }
}

- (UIView *)cardView {
    if (_cardView == nil) {
        _cardView = [[UIView alloc] init];
        _cardView.backgroundColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 255.0f blue:244.0f / 255.0f alpha:1];
        
    }
    return _cardView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1];
        _nameLabel.text = @"nameLabel";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}

- (UILabel *)placeLabel {
    if (_placeLabel == nil) {
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.textAlignment = NSTextAlignmentCenter;
        _placeLabel.textColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1];
        _placeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _placeLabel.text = @"placeLabel";
    }
    return _placeLabel;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UIButton *)likeButton {
    if (_likeButton == nil) {
        _likeButton = [[UIButton alloc] init];
        [_likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
        _likeButton.imageView.contentMode = UIViewContentModeScaleToFill;
        [_likeButton addTarget:self action:@selector(likeButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}

- (void)setIsLike:(BOOL)like {
    if (like) {
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
    }
    _isLike = like;
}

@end
