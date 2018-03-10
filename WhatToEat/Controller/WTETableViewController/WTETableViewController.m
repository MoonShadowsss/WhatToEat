//
//  WTETableViewController.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTETableViewController.h"
#import "ViewsConfig.h"

static NSString *const addViewControllersegueIdentifier = @"AddViewControllerSegue";
static NSString *const detailViewControllerSegueIdentifier = @"detailViewControllerSegue";

@interface WTETableViewController () <LKEmptyManagerDelegate,UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (nonatomic, strong) LKEmptyManager *emptyManager;

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
    
    [self setupRAC];
    [[self.viewModel.networkingRAC refreshCommand] execute:nil];
}

- (void)setupRAC {
    @weakify(self);
    [[[RACObserve(self.viewModel, storeItemViewModels) skip:1]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.tableView reloadData];
         if(self.viewModel.storeItemViewModels.count == 0) {
             [self.emptyManager reloadEmptyDataSet];
         }
         [self.tableView.mj_header endRefreshing];
         if (self.viewModel.hasNextPage) {
             [self.tableView.mj_footer endRefreshing];
         } else {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
         }
     }];
    
    
    [self.viewModel.networkingRAC.requestErrorSignal
     subscribeNext:^(YLResponseError *error) {
         @strongify(self);
         [self.emptyManager reloadEmptyDataSet];
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
     }];
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.storeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTETableViewCell *cell = [[WTETableViewCell alloc] init];
    cell.storeItemViewModel = self.viewModel.storeItemViewModels[indexPath.row];
    [cell setup];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:detailViewControllerSegueIdentifier sender:indexPath];
}

#pragma mark - Add Button Event
- (void)addButtonDidClick:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:addViewControllersegueIdentifier sender:self];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:addViewControllersegueIdentifier]) {
        WTEAddViewController *vc = segue.destinationViewController;
        vc.menuId = self.viewModel.menuId;
    } else if ([segue.identifier isEqualToString:detailViewControllerSegueIdentifier]) {
        WTEDetailViewController *vc = segue.destinationViewController;
        NSIndexPath *index = (NSIndexPath *)sender;
        vc.storeItemViewModel = self.viewModel.storeItemViewModels[index.row];
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
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingCommand:self.viewModel.networkingRAC.refreshCommand];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingCommand:self.viewModel.networkingRAC.requestNextPageCommand];
        [footer setTitle:@"没啦~ 被看光啦 (*/ω＼*)" forState:MJRefreshStateNoMoreData];
        footer.automaticallyHidden = YES;
        _tableView.mj_footer = footer;
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

- (TabelViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TabelViewModel alloc] init];
    }
    return _viewModel;
}

- (LKEmptyManager *)emptyManager {
    if (_emptyManager == nil) {
        _emptyManager = LKEmptyManagerWith(self.tableView,LKEmptyManagerStylePreview);
        _emptyManager.title = @"暂无附近餐馆信息";
        _emptyManager.delegate = self;
        _emptyManager.verticalOffset = 0;
        _emptyManager.backgroundColor = [UIColor whiteColor];
        _emptyManager.allowTouch = NO;
    }
    return _emptyManager;
}
@end
