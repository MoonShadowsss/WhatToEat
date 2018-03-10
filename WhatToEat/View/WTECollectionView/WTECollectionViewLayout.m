//
//  WTECollectionViewLayout.m
//  WhatToEat
//
//  Created by 翟元浩 on 2018/1/26.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import "WTECollectionViewLayout.h"
@interface WTECollectionViewLayout()

@property (assign, nonatomic) NSInteger itemCount;
@property (assign, nonatomic) UIEdgeInsets edge;


@end

@implementation WTECollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.edge = UIEdgeInsetsMake(0, (self.collectionView.frame.size.width - self.itemSize.width) / 2, 0, (self.collectionView.frame.size.width - self.itemSize.width) / 2);
    self.collectionView.contentInset = self.edge;
    self.itemCount = [self.collectionView numberOfItemsInSection:0];
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.itemCount * self.itemSize.width + (self.itemCount - 1) * self.spacing, self.itemSize.height);
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width / 2;
    NSInteger index = centerX / (self.itemSize.width + self.spacing);
    NSInteger minIndex = MAX(0, index - 1);
    NSInteger maxIndex = MIN([self.collectionView numberOfItemsInSection:0] - 1, index + 1);
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i == [self currentIndex]) {
            attributes.zIndex = 100;
        } else {
            attributes.zIndex = 1;
        }
        [array addObject:attributes];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    attributes.center = CGPointMake(indexPath.row * self.itemSize.width + self.itemSize.width / 2 + indexPath.row * self.spacing, self.collectionView.frame.size.height / 2);
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    proposedContentOffset.x = [self centerXForIndex:[self currentIndex]];
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

- (NSInteger)currentIndex {
    NSInteger index = roundf((self.collectionView.contentOffset.x + self.edge.left - 0.5 * self.spacing) / (self.itemSize.width + self.spacing));
    return index;
}

- (CGFloat)centerXForIndex:(NSInteger) index {
    return index * (self.itemSize.width + self.spacing) - self.edge.left;
}


@end
