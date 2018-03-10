//
//  WTEDetailTableViewCell.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTEDetailTableViewCell.h"
@interface WTEDetailTableViewCell()

@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *informationLabel;

@end

@implementation WTEDetailTableViewCell

- (void)setup {
    
}

#pragma mark - Getter & Setter
- (UIImageView *)pictureImageView {
    if (_pictureImageView == nil) {
        _pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.contentMode = UIViewContentModeScaleToFill;
        _pictureImageView.layer.shadowColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1].CGColor;
        _pictureImageView.layer.shadowOpacity = 0.64;
        _pictureImageView.layer.shadowOffset = CGSizeZero;
    }
    return _pictureImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"￥";
    }
    return _priceLabel;
}

- (UILabel *)informationLabel {
    if (_informationLabel == nil) {
        _informationLabel = [[UILabel alloc] init];
        _informationLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _informationLabel;
}

@end
