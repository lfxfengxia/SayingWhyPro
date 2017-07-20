//
//  BannerLayout.m
//  LYDApp
//
//  Created by lyd_Mac on 2017/7/11.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "BannerLayout.h"

@implementation BannerLayout
- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

/**
 *  只要显示的边界发生改变就重新布局:
 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 *  用来设置collectionView停止滚动那一刻的位置
 *
 *  @param proposedContentOffset 原本collectionView停止滚动那一刻的位置
 *  @param velocity              滚动速度
 */

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
     // 1.计算出scrollView最后会停留的范围
    CGRect lastRect;
    lastRect.origin=proposedContentOffset;
    lastRect.size=self.collectionView.frame.size;
    
     // 计算屏幕最中间的x
      CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 2.取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    // 3.遍历所有属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)) {
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);

    
}
/**
 *  一些初始化工作最好在这里实现
 */
-(void)prepareLayout
{
    [super prepareLayout];
    self.itemSize=CGSizeMake(KWidth(200), KHeight(120));
    CGFloat inset = (self.collectionView.frame.size.width - KWidth(200)) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.estimatedItemSize=CGSizeMake(KWidth(200), KHeight(100));
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = KWidth(60);

}

///** 有效距离:当item的中间x距离屏幕的中间x在ActiveDistance以内,才会开始放大, 其它情况都是缩小 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
     // 0.计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size=self.collectionView.frame.size;
    visiableRect.origin=self.collectionView.contentOffset;
     // 1.取得默认的cell的UICollectionViewLayoutAttributes
    NSArray *array=[super layoutAttributesForElementsInRect:rect];
     // 计算屏幕最中间的x
    CGFloat centerX=self.collectionView.contentOffset.x+self.collectionView.frame.size.width*0.5;
     // 2.遍历所有的布局属性
    
    CGFloat ScaleFactor=0.5;
    CGFloat ActiveDistance=KWidth(250);
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // 如果不在屏幕上,直接跳过
        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) continue;
        
        // 每一个item的中点x
        CGFloat itemCenterX = attrs.center.x;
        // 差距越小, 缩放比例越大
        // 根据跟屏幕最中间的距离计算缩放比例
        CGFloat scale = 1 + ScaleFactor * (1 - (ABS(itemCenterX - centerX) / ActiveDistance));
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        if(scale>1)
        {
            [self.delegate ShowIndexPath:attrs.indexPath];
        }
    }
    
    return array;

}


@end
