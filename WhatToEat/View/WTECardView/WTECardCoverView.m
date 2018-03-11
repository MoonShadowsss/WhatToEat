//
//  WTECardCoverView.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/27.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTECardCoverView.h"
#import <Masonry/Masonry.h>
#import "ColorMacros.h"

@interface WTECardCoverView()
@property (strong, nonatomic) UILabel *nameLabel;

@end

@implementation WTECardCoverView

#pragma mark - Life Cycle
- (void)setup {
    self.layer.shadowColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1].CGColor;
    self.layer.shadowOpacity = 0.64;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 8;
    self.layer.cornerRadius = self.frame.size.height / 30;
    self.backgroundColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 255.0f blue:244.0f / 255.0f alpha:1];
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_width);
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:view];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = self.frame.size.height / 30;
    view.backgroundColor = LKColorLightGray;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = self.frame.size.height / 30;
    [self addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:self.bounds .size.height / 15];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.bounds.size.height * 0.48);
        make.width.equalTo(self.mas_width).offset(-20);
        make.centerX.equalTo(self.mas_centerX);
    }];
}


#pragma mark - Getter & Setter
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor colorWithRed:0 green:17.0f / 255.0f blue:26.0f / 255.0f alpha:1];
        _nameLabel.text = @"我是一个朴素的封面";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}

@end
