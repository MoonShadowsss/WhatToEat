//
//  WTETableViewController.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTETableViewController.h"

static NSString *const segueIdentifier = @"AddViewControllerSegue";
@interface WTETableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIBarButtonItem *addButton;

@end

@implementation WTETableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.addButton;
    self.view.backgroundColor = [UIColor colorWithRed:35.0f / 255.0f green:173.0f / 255.0f blue:229.0f / 255.0f alpha:1];
    self.navigationItem.title = self.menuTitle;
    [self.view addSubview:self.backView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(self.backView.frame.size.height / 60, self.backView.frame.size.height / 60)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.backView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backView.layer.mask = maskLayer;
    [self.backView addSubview:self.tableView];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, self.tableView.frame.size.width * 0.036, 0, self.tableView.frame.size.width * 0.036);
    self.tableView.rowHeight = self.tableView.frame.size.height * 0.125;
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dishModel.dishCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTETableViewCell *cell = [[WTETableViewCell alloc] init];
    cell.dishItemModel = self.dishModel.dishModelItemArray[indexPath.row];
    [cell setup];
    return cell;
}

#pragma mark - Add Button Event
- (void)addButtonDidClick:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:segueIdentifier]) {
        WTEAddViewController *vc = segue.destinationViewController;
        vc.menuId = self.dishModel.menuId;
        vc.userModel = self.userModel;
    }
}

#pragma mark - Getter & Setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 244.0f blue:244.0f / 255.0f alpha:1];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.frame = self.backView.bounds;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor blackColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithRed:239.0f / 255.0f green:239.0f / 244.0f blue:244.0f / 255.0f alpha:1];
        _backView.frame = CGRectMake(self.view.frame.size.width * 0.0544, self.view.frame.size.height * 0.0978, self.view.frame.size.width * 0.8912, self.view.frame.size.height * 0.9022);
    }
    return _backView;
}

- (UIBarButtonItem *)addButton {
    if (_addButton == nil) {
        _addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(addButtonDidClick:)];
    }
    return _addButton;
}

@end
