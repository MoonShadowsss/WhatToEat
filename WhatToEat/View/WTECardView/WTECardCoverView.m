//
//  WTECardCoverView.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/27.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTECardCoverView.h"

@interface WTECardCoverView()

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
    self.imageView.frame = self.bounds;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = self.frame.size.height / 30;
}


#pragma mark - Getter & Setter
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}


@end
