//
//  WTEPickViewController.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//


#import "WTEPickViewController.h"

static NSString *const tableViewControllerSegueIdentifier = @"tableViewControllerSegue";
static NSString *const detailViewControllerSegueIdentifier = @"detailViewControllerSegue";
static NSString *const cellIdentifier = @"cellId";
@interface WTEPickViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WTECollectionViewCellDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;


@end

@implementation WTEPickViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:35.0f / 255.0f green:173.0f / 255.0f blue:229.0f / 255.0f alpha:1];
    NSDictionary *colorAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = colorAttributes;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.title = @"吃什么";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setupRAC];
    [[self.menusViewModel.networkingRAC refreshCommand] execute:nil];
    WTECollectionViewLayout *layout = [[WTECollectionViewLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width * 0.69, self.view.frame.size.height * 0.75);
    layout.spacing = self.view.frame.size.width * 0.095;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.94) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[WTECollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.collectionView];
    
    self.pageControl.frame = CGRectMake(0, self.view.frame.size.height * 0.94, self.view.frame.size.width, self.view.frame.size.height * 0.06);
    [self.view addSubview:self.pageControl];
}

- (void)setupRAC {
    @weakify(self);
    [[RACObserve(self.menusViewModel, menuItemModels) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        _storesViewModels = [NSMutableArray array];
        for (MenuItemModel *item in self.menusViewModel.menuItemModels) {
            StoresViewModel *storesViewModel = [[StoresViewModel alloc] init];
            storesViewModel.menuId = item.menuId;
            [[storesViewModel.networkingRAC refreshCommand] execute:nil];
            [[RACObserve(storesViewModel, storeItemViewModels) skip:1] subscribeNext:^(id x) {
                [self.storesViewModels addObject:storesViewModel];
                if ([item.menuId isEqualToString:self.menusViewModel.menuItemModels[self.menusViewModel.menuCount - 1].menuId]) {
                    if ([NSThread isMainThread]) {
                        [self.collectionView reloadData];
                        self.pageControl.numberOfPages = [self.collectionView numberOfItemsInSection:0];
                    } else {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.collectionView reloadData];
                            self.pageControl.numberOfPages = [self.collectionView numberOfItemsInSection:0];
                        });
                    }
                }
            }];
        }
    }];
}
#pragma mark - Internet
/*
 - (void)fetchData {
 // 请求menu数据
 NSString *menuURLDirection = @"https://link.xjtu.edu.cn/api/whattoeat/menu";
 NSURL *menuURL = [NSURL URLWithString:menuURLDirection];
 NSMutableURLRequest *menuRequest = [NSMutableURLRequest requestWithURL:menuURL];
 menuRequest.HTTPMethod = @"POST";
 menuRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:menuParam options:NSJSONWritingPrettyPrinted error:nil];
 NSURLSession *session = [NSURLSession sharedSession];
 NSURLSessionTask *menuTask = [session dataTaskWithRequest:menuRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 self.menuModel = [[WTEMenuModel alloc] initWithData:data];
 _dishModelArray = [NSMutableArray array];
 [self fetchDishData];
 }];
 [menuTask resume];
 }
 
- (void)fetchDishData {
    // 请求dish数据
    NSURL *dishURL = [NSURL URLWithString:@"https://link.xjtu.edu.cn/api/whattoeat/dish"];
    for (MenuItemModel *item in self.viewModel.menuItemModels) {
        NSString *menuId = item.menuId;
        NSMutableURLRequest *dishRequest = [NSMutableURLRequest requestWithURL:dishURL];
        dishRequest.HTTPMethod = @"POST";
        NSDictionary *dishParam = @{@"user_id": @"1", @"user_token": @"2", @"menu_id": menuId};
        dishRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:dishParam options:NSJSONWritingPrettyPrinted error:nil];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionTask *dishTask = [session dataTaskWithRequest:dishRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            WTEDishModel *dishModel = [[WTEDishModel alloc] initWithData:data];
            dishModel.menuId = menuId;
            [self.dishModelArray addObject:dishModel];
            if ([menuId isEqualToString:self.viewModel.menuItemModels[self.viewModel.menuCount - 1].menuId]) {
                if ([NSThread isMainThread]) {
                    [self.collectionView reloadData];
                    self.pageControl.numberOfPages = [self.collectionView numberOfItemsInSection:0];
                } else {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self.collectionView reloadData];
                        self.pageControl.numberOfPages = [self.collectionView numberOfItemsInSection:0];
                    });
                }
            }
        }];
        [dishTask resume];
    }
}
*/
#pragma mark - CollectionView DataSource & Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menusViewModel.menuCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WTECollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.menuItemModel = self.menusViewModel.menuItemModels[indexPath.row];
    cell.viewModel = self.storesViewModels[indexPath.row];
    [cell setup];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = roundf((self.collectionView.contentOffset.x + self.collectionView.contentInset.left - 0.5 * 30) / (300 + 30));
    self.pageControl.currentPage = index;
}

- (void)editButtonDidClickOnCollectionViewCell:(WTECollectionViewCell *)collectionViewCell {
    [self performSegueWithIdentifier:tableViewControllerSegueIdentifier sender:collectionViewCell];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:tableViewControllerSegueIdentifier]) {
        WTETableViewController *vc = segue.destinationViewController;
        vc.menuTitle = self.menusViewModel.menuItemModels[self.pageControl.currentPage].name;
        vc.viewModel = self.storesViewModels[self.pageControl.currentPage];
    }
}

#pragma mark - Getter & Setter
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = [self.collectionView numberOfItemsInSection:0];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (MenusViewModel *)menusViewModel {
    if (_menusViewModel == nil) {
        _menusViewModel = [[MenusViewModel alloc] init];
    }
    return _menusViewModel;
}

@end

