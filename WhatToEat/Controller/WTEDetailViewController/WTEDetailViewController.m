//
//  WTEDetailViewController.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/3/10.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTEDetailViewController.h"
#import <Masonry.h>

@interface WTEDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UILabel *informationLabel;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIBarButtonItem *jumpButton;
@property (strong, nonatomic) UIView *shelterView;

@end

@implementation WTEDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:35.0f / 255.0f green:173.0f / 255.0f blue:229.0f / 255.0f alpha:1];
    self.navigationItem.rightBarButtonItem = self.jumpButton;
    
    [self.view addSubview:self.backgroundImageView];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.backgroundImageView.mas_width);
    }];
    [self.backgroundImageView addSubview:self.shelterView];
    [self.shelterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundImageView.mas_bottom);
        make.left.equalTo(self.backgroundImageView.mas_left);
        make.right.equalTo(self.backgroundImageView.mas_right);
        make.height.equalTo(self.backgroundImageView.mas_height).multipliedBy(0.72);
    }];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.scrollView addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.view.mas_width).multipliedBy(0.2);
        make.width.equalTo(self.pictureImageView.mas_height);
        make.top.equalTo(self.scrollView.mas_top);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.scrollView addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.width.equalTo(self.pictureImageView.mas_width).multipliedBy(0.25);
        make.height.equalTo(self.likeButton.mas_width);
        make.top.equalTo(self.pictureImageView.mas_bottom).offset(10);
    }];
    [self.scrollView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likeButton.mas_bottom).offset(10);
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.right.equalTo(self.scrollView.mas_right).offset(-20);

    }];
    
    [self.scrollView addSubview:self.locationLabel];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.right.equalTo(self.scrollView.mas_right).offset(-20);
    }];
    [self.scrollView addSubview:self.informationLabel];
    [self.informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.right.equalTo(self.scrollView.mas_right).offset(-20);
    }];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = self.view.frame.size.height * 0.125;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.informationLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.scrollView.contentSize = CGSizeMake(0, self.scrollView.frame.size.height + self.tableView.frame.origin.y);
    [self setupRAC];
    [[self.viewModel.networkingRAC requestCommand] execute:nil];
    [self setup];
}

- (void)setupRAC {
    @weakify(self);
    [[RACObserve(self.viewModel, storeItemViewModel) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        self.nameLabel.text = self.viewModel.storeItemViewModel.model.name;
        self.locationLabel.text = self.viewModel.storeItemViewModel.model.location;
        self.informationLabel.text = self.viewModel.storeItemViewModel.model.information;
        NSData *pictureData = [NSData dataWithContentsOfURL:self.viewModel.storeItemViewModel.model.pictureURL];
        if (pictureData == nil) {
            self.pictureImageView.image = [UIImage imageNamed:@"food2"];
        } else {
            self.pictureImageView.image = [UIImage imageWithData:pictureData];
        }
        [self.backgroundImageView setImageToBlur:self.pictureImageView.image completionBlock:nil];
    }];
    [[RACObserve(self.viewModel, dishModels) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)jumpButtonDidClick:(UIBarButtonItem *)sender {
}

- (void)setup {
    self.nameLabel.text = self.viewModel.storeItemViewModel.model.name;
    self.locationLabel.text = self.viewModel.storeItemViewModel.model.location;
    self.informationLabel.text = self.viewModel.storeItemViewModel.model.information;
    NSData *pictureData = [NSData dataWithContentsOfURL:self.viewModel.storeItemViewModel.model.pictureURL];
    if (pictureData == nil) {
        self.pictureImageView.image = [UIImage imageNamed:@"food2"];
    } else {
        self.pictureImageView.image = [UIImage imageWithData:pictureData];
    }
    if (self.viewModel.storeItemViewModel.model.isLike) {
        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
    }
    [self.backgroundImageView setImageToBlur:self.pictureImageView.image completionBlock:nil];
    
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dishModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTEDetailTableViewCell *cell = [[WTEDetailTableViewCell alloc] init];
    cell.dishModel = self.viewModel.dishModels[indexPath.row];
    [cell setup];
    return cell;
}

#pragma mark - Getter & Setter
- (UIView *)shelterView {
    if (_shelterView == nil) {
        _shelterView = [[UIView alloc] init];
        _shelterView.backgroundColor = [UIColor colorWithRed:35.0f / 255.0f green:173.0f / 255.0f blue:229.0f / 255.0f alpha:1];
    }
    return _shelterView;
}
- (UIImageView *)backgroundImageView {
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImageView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIImageView *)pictureImageView {
    if (_pictureImageView == nil) {
        _pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.contentMode = UIViewContentModeScaleToFill;
        _pictureImageView.layer.masksToBounds = YES;
        _pictureImageView.layer.cornerRadius = 5;
    }
    return _pictureImageView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:35.0f / 255.0f green:173.0f / 255.0f blue:229.0f / 255.0f alpha:1];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)locationLabel {
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.textColor = [UIColor whiteColor];
    }
    return _locationLabel;
}

- (UILabel *)informationLabel {
    if (_informationLabel == nil) {
        _informationLabel = [[UILabel alloc] init];
        _informationLabel.textAlignment = NSTextAlignmentCenter;
        _informationLabel.textColor = [UIColor whiteColor];
    }
    return _informationLabel;
}

- (UIButton *)likeButton {
    if (_likeButton == nil) {
        _likeButton = [[UIButton alloc] init];
        _likeButton.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _likeButton;
}

- (UIBarButtonItem *)jumpButton {
    if (_jumpButton == nil) {
        _jumpButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"purchase"] style:UIBarButtonItemStylePlain target:self action:@selector(jumpButtonDidClick:)];
    }
    return _jumpButton;
}

- (DetailViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[DetailViewModel alloc] init];
        _viewModel.storeItemViewModel = [[StoreItemViewModel alloc] init];

    }
    return  _viewModel;
}

@end
