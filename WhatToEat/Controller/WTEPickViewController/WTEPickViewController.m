//
//  WTEPickViewController.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//


#import "WTEPickViewController.h"
#import "PickViewModel.h"

static NSString *const tableViewControllerSegueIdentifier = @"tableViewControllerSegue";
static NSString *const detailViewControllerSegueIdentifier = @"detailViewControllerSegue";
static NSString *const cellIdentifier = @"cellId";
@interface WTEPickViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WTECollectionViewCellDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) WTEMenuModel *menuModel;
@property (strong, nonatomic) NSMutableArray<WTEDishModel *> *dishModelArray;
@property (strong, nonatomic) PickViewModel *viewMode;

@end

@implementation WTEPickViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userModel = [WTEUserModel sharedUser];
    
    self.view.backgroundColor = [UIColor colorWithRed:35.0f / 255.0f green:173.0f / 255.0f blue:229.0f / 255.0f alpha:1];
    NSDictionary *colorAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = colorAttributes;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.title = @"吃什么";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self fetchData];
    
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
    [[RACObserve(self.viewMode, menuItemModels) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        self.headerView.balanceLabel.text = value;
        [self.activityIndicatorView stopAnimating];
    }];
}
#pragma mark - Internet
- (void)fetchData {
    // 请求menu数据
    NSString *menuURLDirection = @"https://link.xjtu.edu.cn/api/whattoeat/menu";
    NSURL *menuURL = [NSURL URLWithString:menuURLDirection];
    NSMutableURLRequest *menuRequest = [NSMutableURLRequest requestWithURL:menuURL];
    menuRequest.HTTPMethod = @"POST";
//    menuRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:menuParam options:NSJSONWritingPrettyPrinted error:nil];
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
    for (WTEMenuItemModel *item in self.menuModel.menuModelItemArray) {
        NSString *menuId = item.menuId;
        NSMutableURLRequest *dishRequest = [NSMutableURLRequest requestWithURL:dishURL];
        dishRequest.HTTPMethod = @"POST";
        NSDictionary *dishParam = @{@"menu_id": menuId};
//        dishRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:dishParam options:NSJSONWritingPrettyPrinted error:nil];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionTask *dishTask = [session dataTaskWithRequest:dishRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            WTEDishModel *dishModel = [[WTEDishModel alloc] initWithData:data];
            dishModel.menuId = menuId;
            [self.dishModelArray addObject:dishModel];
            if ([menuId isEqualToString:self.menuModel.menuModelItemArray[self.menuModel.menuCount - 1].menuId]) {
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

#pragma mark - CollectionView DataSource & Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuModel.menuCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WTECollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.menuItemModel = self.menuModel.menuModelItemArray[indexPath.row];
    cell.dishModel = self.dishModelArray[indexPath.row];
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
        vc.menuTitle = self.menuModel.menuModelItemArray[self.pageControl.currentPage].name;
        vc.userModel = self.userModel;
        vc.dishModel = self.dishModelArray[self.pageControl.currentPage];
    } else if ([segue.identifier isEqualToString:detailViewControllerSegueIdentifier]) {
        
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

- (PickViewModel *)viewMode {
    if (_viewMode == nil) {
        _viewMode = [[PickViewModel alloc] init];
    }
    return _viewMode;
}

@end
