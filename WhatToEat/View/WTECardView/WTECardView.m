//
//  WTECardView.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTECardView.h"

@interface WTECardView()

@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) WTECardCoverView *cardCoverView;
@property (strong, nonatomic) NSMutableArray<WTECardItemView *> *cardItemViews;
@property (assign, nonatomic) NSInteger visibleCardItemViewCount;
@property (assign, nonatomic) CGPoint firstCardItemViewCenter;
@property (assign, nonatomic) CGRect firstCardItemViewFrame;
@property (assign, nonatomic) CGRect secondCardItemViewFrame;
@property (assign, nonatomic) CGRect thirdCardItemViewFrame;

@end

@implementation WTECardView

- (void)reloadData {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger totalNumberOfItemView = [self numberOfCardItemView];
    self.cardItemViews = [[NSMutableArray alloc] initWithObjects:[[WTECardItemView alloc] init], [[WTECardItemView alloc] init], [[WTECardItemView alloc] init], nil];
    self.visibleCardItemViewCount = 0;
    self.firstCardItemViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 180 / 191);
    self.firstCardItemViewCenter = CGPointMake(self.frame.size.width / 2, self.frame.size.height * 90 / 191);
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
    [self addGestureRecognizer:pan];
    if (totalNumberOfItemView > 0) {
        self.currentIndex = 0;
        [self setupCardItemViewAtArrayIndex:0 index:0];
        self.cardItemViews[0].frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 180 / 191);
        [self addSubview:self.cardItemViews[0]];
        [self.cardItemViews[0] setup];
        self.firstCardItemViewCenter = self.cardItemViews[0].center;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
        [self addGestureRecognizer:tap];
        self.visibleCardItemViewCount = 1;
    }
    if (totalNumberOfItemView > 1) {
        [self setupCardItemViewAtArrayIndex:1 index:1];
        self.cardItemViews[1].frame = CGRectMake(self.frame.size.width / 2 - (self.frame.size.width * 22 / 27) / 2, self.frame.size.height - self.frame.size.width * 22 / 27 / (self.frame.size.width) * (self.frame.size.height * 180 / 191) - self.frame.size.height * 180 / 191 * 11 / 360, self.frame.size.width * 22 / 27, self.frame.size.width * 22 / 27 / (self.frame.size.width) * (self.frame.size.height * 180 / 191));
        [self addSubview:self.cardItemViews[1]];
        [self.cardItemViews[1] setup];
        self.secondCardItemViewFrame = self.cardItemViews[1].frame;
        [self sendSubviewToBack:self.cardItemViews[1]];
        self.cardItemViews[1].userInteractionEnabled = NO;
        self.visibleCardItemViewCount = 2;
    }
    if (totalNumberOfItemView > 2) {
        [self setupCardItemViewAtArrayIndex:2 index:2];
        self.cardItemViews[2].frame = CGRectMake(self.frame.size.width / 2 - self.frame.size.width * 17 / 27 / 2, self.frame.size.height - self.frame.size.width * 17 / 27 / (self.frame.size.width) * (self.frame.size.height * 180 / 191), self.frame.size.width * 17 / 27, self.frame.size.width * 17 / 27 / (self.frame.size.width) * (self.frame.size.height * 180 / 191));
        [self addSubview:self.cardItemViews[2]];
        [self.cardItemViews[2] setup];
        self.thirdCardItemViewFrame = self.cardItemViews[2].frame;
        self.cardItemViews[2].alpha = 0.5;
        self.cardItemViews[2].userInteractionEnabled = NO;
        [self sendSubviewToBack:self.cardItemViews[2]];
        self.visibleCardItemViewCount = 3;
    }
    
    [self addSubview:self.cardCoverView];
    self.cardCoverView.imageView.image = [self coverImage];
    self.cardCoverView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 180 / 191);
    [self.cardCoverView setup];
}

- (void)setupCardItemViewAtArrayIndex:(NSInteger)arrayIndex index:(NSInteger)index {
    self.cardItemViews[arrayIndex].imageView.image = [self imageAtIndex:index];
    self.cardItemViews[arrayIndex].nameLabel.text = [self nameAtIndex:index];
    self.cardItemViews[arrayIndex].placeLabel.text = [self placeAtIndex:index];
    self.cardItemViews[arrayIndex].isLike = [self likeAtIndex:index];
    self.cardItemViews[arrayIndex].dishId = [self dishIdAtIndex:index];
    self.cardItemViews[arrayIndex].viewModel = [self viewModelAtIndex:index];
}

#pragma mark - Gesture event

- (void)panGestureHandle:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        if ([self.subviews containsObject:self.cardCoverView]) {
            CGPoint movePoint = [panGesture translationInView:self];
            self.cardCoverView.center = CGPointMake(movePoint.x + self.firstCardItemViewCenter.x, movePoint.y * exp(-2) + self.firstCardItemViewCenter.y);
            CGFloat angle = movePoint.x / [UIScreen mainScreen].bounds.size.width / 2;
            self.cardCoverView.transform = CGAffineTransformMakeRotation(angle);
        } else {
            CGPoint movePoint = [panGesture translationInView:self];
            self.cardItemViews[0].center = CGPointMake(movePoint.x + self.firstCardItemViewCenter.x, movePoint.y * exp(-2) + self.firstCardItemViewCenter.y);
            CGFloat angle = movePoint.x / [UIScreen mainScreen].bounds.size.width / 2;
            self.cardItemViews[0].transform = CGAffineTransformMakeRotation(angle);
        }
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        if ([self.subviews containsObject:self.cardCoverView]) {
            if (fabs(self.cardCoverView.center.x - self.firstCardItemViewCenter.x) > [UIScreen mainScreen].bounds.size.width / 2.5 || [panGesture velocityInView:self].x > 800) {
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     if (self.cardCoverView.center.x > self.firstCardItemViewCenter.x) {
                                         self.cardCoverView.center = CGPointMake(self.cardItemViews[0].center.x + [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                                     } else {
                                         self.cardCoverView.center = CGPointMake(self.cardItemViews[0].center.x - [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                                     }
                                 }
                                 completion:^(BOOL finished) {
                                     [self.cardCoverView removeFromSuperview];
                                 }];
            } else {
                self.userInteractionEnabled = NO;
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.cardCoverView.center = self.firstCardItemViewCenter;
                                     self.cardCoverView.transform = CGAffineTransformIdentity;
                                 }
                                 completion:^(BOOL finished) {
                                     self.cardCoverView.frame = self.firstCardItemViewFrame;
                                     self.userInteractionEnabled = YES;
                                 }];
            }
        } else {
            if (fabs(self.cardItemViews[0].center.x - self.firstCardItemViewCenter.x) > [UIScreen mainScreen].bounds.size.width / 2.5 || [panGesture velocityInView:self].x > 800) {
                [self removeFirst];
            } else {
                self.userInteractionEnabled = NO;
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.cardItemViews[0].center = self.firstCardItemViewCenter;
                                     self.cardItemViews[0].transform = CGAffineTransformIdentity;
                                 }
                                 completion:^(BOOL finished) {
                                     self.userInteractionEnabled = YES;
                                 }];
            }
        }
    }
}

- (void)tapGestureHandle:(UITapGestureRecognizer *)tapGesture {
    if ([self.dataSource respondsToSelector:@selector(cardView:didClickAtIndex:)]) {
        [self.dataSource cardView:self didClickAtIndex:self.currentIndex];
    }
}

- (void)removeFirst {
#warning 动画效果需要完善
    
    if (self.visibleCardItemViewCount == 3 && [self numberOfCardItemView] > self.currentIndex + 3) { // 如果第三张cardItemView之后还有数据
        [UIView animateWithDuration:0.2
                         animations:^{
                             if (self.cardItemViews[0].center.x > self.firstCardItemViewCenter.x) {
                                 self.cardItemViews[0].center = CGPointMake(self.cardItemViews[0].center.x + [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                             } else {
                                 self.cardItemViews[0].center = CGPointMake(self.cardItemViews[0].center.x - [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                             }
                             self.cardItemViews[1].frame = self.firstCardItemViewFrame;
                             self.cardItemViews[2].frame = self.secondCardItemViewFrame;
                             self.cardItemViews[2].alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             self.cardItemViews[0].transform = CGAffineTransformMakeRotation(0);
                             [self sendSubviewToBack:self.cardItemViews[0]];
                             self.cardItemViews[0].frame = self.thirdCardItemViewFrame;
                             self.cardItemViews[0].alpha = 0.5;
                             WTECardItemView *tem = self.cardItemViews[0];
                             self.cardItemViews[0] = self.cardItemViews[1];
                             self.cardItemViews[1] = self.cardItemViews[2];
                             self.cardItemViews[2] = tem;
                             [self setupCardItemViewAtArrayIndex:2 index:self.currentIndex + 3];
                             self.currentIndex++;
                             
                             // 更新数据
                             if ([self numberOfCardItemView] == self.currentIndex + 3) {
                                 if ([self.dataSource respondsToSelector:@selector(cardViewNeedsMoreData:)]) {
                                     [self.dataSource cardViewNeedsMoreData:self];
                                 }
                             }
                         }];
    } else if (self.visibleCardItemViewCount == 3 && [self numberOfCardItemView] == self.currentIndex + 3) { // 如果第三张cardItemView是最后一组数据
        [UIView animateWithDuration:0.2
                         animations:^{
                             if (self.cardItemViews[0].center.x > self.firstCardItemViewCenter.x) {
                                 self.cardItemViews[0].center = CGPointMake(self.cardItemViews[0].center.x + [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                             } else {
                                 self.cardItemViews[0].center = CGPointMake(self.cardItemViews[0].center.x - [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                             }
                             self.cardItemViews[1].frame = self.firstCardItemViewFrame;
                             self.cardItemViews[2].frame = self.secondCardItemViewFrame;
                             self.cardItemViews[2].alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             [self.cardItemViews[0] removeFromSuperview];
                             self.cardItemViews[0] = self.cardItemViews[1];
                             self.cardItemViews[1] = self.cardItemViews[2];
                             self.visibleCardItemViewCount = 2;
                             self.currentIndex++;
                         }];
    } else if (self.visibleCardItemViewCount == 2) { // 如果第三张没有显示并且第二张cardItemView是最后一组数据
        [UIView animateWithDuration:0.2
                         animations:^{
                             if (self.cardItemViews[0].center.x > self.firstCardItemViewCenter.x) {
                                 self.cardItemViews[0].center = CGPointMake(self.cardItemViews[0].center.x + [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                             } else {
                                 self.cardItemViews[0].center = CGPointMake(self.cardItemViews[0].center.x - [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                             }
                             self.cardItemViews[1].frame = self.firstCardItemViewFrame;
                         }
                         completion:^(BOOL finished) {
                             [self.cardItemViews[0] removeFromSuperview];
                             self.cardItemViews[0] = self.cardItemViews[1];
                             self.visibleCardItemViewCount = 1;
                             self.currentIndex++;
                         }];
    } else { // 如果仅显示第一张cardItemView
        [UIView animateWithDuration:0.2
                         animations:^{
                             if (self.cardItemViews[0].center.x > self.firstCardItemViewCenter.x) {
                                 self.cardItemViews[0].center = CGPointMake(self.cardItemViews[0].center.x + [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                             } else {
                                 self.cardItemViews[0].center = CGPointMake(self.cardItemViews[0].center.x - [UIScreen mainScreen].bounds.size.width, self.cardItemViews[0].center.y);
                             }
                         }
                         completion:^(BOOL finished) {
                             [self.cardItemViews[0] removeFromSuperview];
                             self.visibleCardItemViewCount = 0;
                             self.currentIndex++;
                         }];
    }
}

#pragma mark - Data Source
- (UIImage *)coverImage {
    return [self.dataSource coverImageForCardView:self];
}

- (StoreItemViewModel *)viewModelAtIndex:(NSInteger)index{
    return [self.dataSource cardView:self viewModelAtIndex:index];
}

- (NSString *)dishIdAtIndex:(NSInteger)index {
    return [self.dataSource cardView:self dishIdAtIndex:index];
}

- (NSInteger)numberOfCardItemView {
    return [self.dataSource numberOfCardItemViewInCardView:self];
}

- (UIImage *)imageAtIndex:(NSInteger)index {
     return [self.dataSource cardView:self imageAtIndex:index];
}

- (NSString *)nameAtIndex:(NSInteger)index {
    return [self.dataSource cardView:self nameAtIndex:index];
}

- (NSString *)placeAtIndex:(NSInteger)index {
    return [self.dataSource cardView:self locationAtIndex:index];
}

- (BOOL)likeAtIndex:(NSInteger)index {
    return [self.dataSource cardView:self likeAtIndex:index];
}

#pragma mark - Getter & Setter
- (WTECardCoverView *)cardCoverView {
    if (_cardCoverView == nil) {
        _cardCoverView = [[WTECardCoverView alloc] init];
    }
    return _cardCoverView;
}

@end
