//
//  WTEDetailTableViewCell.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTEDetailTableViewCell.h"
#import <Masonry.h>
@interface WTEDetailTableViewCell()

@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *informationLabel;

@end

@implementation WTEDetailTableViewCell

- (void)setup {
    self.backgroundColor = [UIColor colorWithRed:35.0f / 255.0f green:173.0f / 255.0f blue:229.0f / 255.0f alpha:1];
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
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
    }];
    [self addSubview:self.priceLabel];
    self.priceLabel.font = [UIFont fontWithName:@"Helvetica" size:self.frame.size.height * 0.4];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.frame.size.height * 0.3);
        make.left.equalTo(self.nameLabel.mas_right);
        make.right.equalTo(self.mas_right);
    }];
    [self addSubview:self.informationLabel];
    self.informationLabel.font = [UIFont fontWithName:@"Helvetica" size:self.frame.size.height * 0.3];
    [self.informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-self.frame.size.height * 0.3);
        make.left.equalTo(self.mas_left).offset(self.frame.size.width * 0.25);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
}

#pragma mark - Getter & Setter
- (void)setDishModel:(DishModel *)dishModel {
    _dishModel = dishModel;
    self.nameLabel.text = dishModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", dishModel.cost];
    self.informationLabel.text = dishModel.information;
    NSData *pictureData = [NSData dataWithContentsOfURL:dishModel.pictureURL];
    if (pictureData == nil) {
        self.pictureImageView.image = [UIImage imageNamed:@"food3"];
    } else {
        self.pictureImageView.image = [UIImage imageWithData:pictureData];
    }
}


- (UIImageView *)pictureImageView {
    if (_pictureImageView == nil) {
        _pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.contentMode = UIViewContentModeScaleToFill;
        _pictureImageView.layer.shadowColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1].CGColor;
        _pictureImageView.layer.shadowOpacity = 0.64;
        _pictureImageView.layer.shadowOffset = CGSizeZero;
        _pictureImageView.backgroundColor = [UIColor whiteColor];
    }
    return _pictureImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"￥";
        _priceLabel.textColor = [UIColor whiteColor];
    }
    return _priceLabel;
}

- (UILabel *)informationLabel {
    if (_informationLabel == nil) {
        _informationLabel = [[UILabel alloc] init];
        _informationLabel.textAlignment = NSTextAlignmentLeft;
        _informationLabel.textColor = [UIColor whiteColor];
    }
    return _informationLabel;
}

@end
