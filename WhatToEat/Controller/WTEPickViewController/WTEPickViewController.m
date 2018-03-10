//
//  WTEPickViewController.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//


#import "WTEPickViewController.h"
#import "PickViewModel.h"
#import <CoreLocation/CoreLocation.h>

static NSString *const tableViewControllerSegueIdentifier = @"tableViewControllerSegue";
static NSString *const detailViewControllerSegueIdentifier = @"detailViewControllerSegue";
static NSString *const cellIdentifier = @"cellId";
@interface WTEPickViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WTECollectionViewCellDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) PickViewModel *viewModel;
@property (strong, nonatomic) CLLocationManager *locationManager;

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
    [self updateLocation];
    
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

- (void)updateLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    WTELocation *location = [WTELocation sharedLocation];
    location.longitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    location.latitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    [[self.viewModel.networkingRAC refreshCommand] execute:nil];
    [self.locationManager stopUpdatingLocation];
}

- (void)setupRAC {
    @weakify(self);
    [[RACObserve(self.viewModel.menusViewModel, menuItemModels) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        for (MenuItemModel *item in self.viewModel.menusViewModel.menuItemModels) {
            StoresViewModel *storesViewModel = [[StoresViewModel alloc] init];
            storesViewModel.menuId = item.menuId;
            [[storesViewModel.networkingRAC refreshCommand] execute:nil];
            [[RACSignal merge:@[[RACObserve(storesViewModel, storeItemViewModels) skip:1],
                                [storesViewModel.networkingRAC requestErrorSignal]]] subscribeNext:^(id x) {
                [self.viewModel.storesViewModels addObject:storesViewModel];
                if ([item.menuId isEqualToString:self.viewModel.menusViewModel.menuItemModels[self.viewModel.menusViewModel.menuCount - 1].menuId]) {
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

#pragma mark - CollectionView DataSource & Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.menusViewModel.menuCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WTECollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.menuItemModel = self.viewModel.menusViewModel.menuItemModels[indexPath.row];
    if (indexPath.row < self.viewModel.storesViewModels.count) {
        cell.viewModel = self.viewModel.storesViewModels[indexPath.row];
    } else {
        cell.viewModel = nil;
    }
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
        vc.menuTitle = self.viewModel.menusViewModel.menuItemModels[self.pageControl.currentPage].name;
        vc.viewModel.menuId = self.viewModel.storesViewModels[self.pageControl.numberOfPages - self.pageControl.currentPage - 1].menuId;
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

- (PickViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[PickViewModel alloc] init];
    }
    return _viewModel;
}

@end
