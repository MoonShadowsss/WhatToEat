//
//  WTEAddViewController.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/28.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTEAddViewController.h"
#import <Masonry/Masonry.h>

@interface WTEAddViewController ()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *locationTextField;
@property (strong, nonatomic) UIBarButtonItem *doneButton;

@end

@implementation WTEAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:35.0f / 255.0f green:173.0f / 255.0f blue:229.0f / 255.0f alpha:1];
    self.navigationItem.rightBarButtonItem = self.doneButton;
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.width * 0.05);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    [self.view addSubview:self.locationLabel];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.width * 0.05);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(self.view.frame.size.height * 0.1);
    }];
    [self.view addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-self.view.frame.size.width * 0.05);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.7);
    }];
    [self.view addSubview:self.locationTextField];
    [self.locationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.locationLabel.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-self.view.frame.size.width * 0.05);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.7);
    }];
}
#pragma mark - Button Event
- (void)doneButtonDidClick:(UIBarButtonItem *)sender {
    if (self.nameTextField.text.length > 0 && self.locationTextField.text.length > 0) {
        NSString *urlDirection = @"https://link.xjtu.edu.cn/api/whattoeat/menu";
        NSURL *url = [NSURL URLWithString:urlDirection];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        NSDictionary *param = @{@"menu_id": self.menuId, @"dish_name": self.nameTextField.text, @"dish_location": self.locationTextField.text};
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionTask *task = [session dataTaskWithRequest:request];
        [task resume];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Getter & Setter
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"菜名";
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)locationLabel {
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.text = @"地点";
        _locationLabel.textColor = [UIColor whiteColor];
    }
    return _locationLabel;
}

- (UIBarButtonItem *)doneButton {
    if (_doneButton == nil) {
        _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidClick:)];
    }
    return _doneButton;
}

- (UITextField *)nameTextField {
    if (_nameTextField == nil) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.backgroundColor = [UIColor whiteColor];
    }
    return _nameTextField;
}

- (UITextField *)locationTextField {
    if (_locationTextField == nil) {
        _locationTextField = [[UITextField alloc] init];
        _locationTextField.backgroundColor = [UIColor whiteColor];
    }
    return _locationTextField;
}

@end
