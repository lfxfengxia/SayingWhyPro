//
//  UILabel+FixWidth.m
//  LYDApp
//
//  Created by dai yi on 2016/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "UILabel+FixWidth.h"

@implementation UILabel (FixWidth)

- (void)fixSingleWidth {
    CGRect origalRect = self.frame;
    [self sizeToFit];
    self.frame = CGRectMake(origalRect.origin.x, origalRect.origin.y, self.width + 4, origalRect.size.height);
}


- (void)fixSingleWidthForRight {
    CGRect origalRect = self.frame;
    
    CGFloat maxX = origalRect.origin.x + origalRect.size.width;
    
    [self sizeToFit];
    
    self.frame = CGRectMake(maxX - self.frame.size.width - 2, origalRect.origin.y, self.frame.size.width + 4, origalRect.size.height);
}

- (void)fixSignleWidthForLeftBellowMaxWidth:(CGFloat)maxWidth {
    [self fixSingleWidth];
    CGRect origalRect = self.frame;
    if (origalRect.size.width > maxWidth) {
        origalRect.size.width = maxWidth;
    }
    self.frame = origalRect;
}

/**
 * 修复宽度，默认右边，有最大宽度
 */
- (void)fixSingleWidthForRightBellowMaxWidth:(CGFloat)maxWidth {
    [self fixSingleWidthForRight];
    CGRect origalRect = self.frame;
    if (origalRect.size.width > maxWidth) {
        origalRect.size.width = maxWidth;
    }
    // 原来的最大x
    CGFloat max = self.frame.origin.x + self.frame.size.width;
    
    self.frame = CGRectMake(max - origalRect.size.width, self.frame.origin.y, origalRect.size.width, self.frame.size.height);
}

/**
 * 修复宽度，默认左边，有最小宽度
 */
- (void)fixSignleWidthForLeftOverMinWidth:(CGFloat)minWidth {
    [self fixSingleWidth];
    CGRect origalRect = self.frame;
    if (origalRect.size.width < minWidth) {
        origalRect.size.width = minWidth;
    }
    self.frame = origalRect;
}

/**
 * 修复宽度，默认右边，有最小宽度
 */
- (void)fixSingleWidthForRightOverMinWidth:(CGFloat)minWidth {
    [self fixSingleWidthForRight];
    CGRect origalRect = self.frame;
    if (origalRect.size.width > minWidth) {
        origalRect.size.width = minWidth;
    }
    // 原来的最大x
    CGFloat max = self.frame.origin.x + self.frame.size.width;
    
    self.frame = CGRectMake(max - origalRect.size.width, self.frame.origin.y, origalRect.size.width, self.frame.size.height);
}

/**
 * 修复宽度，有最大最小值, 左对齐方式
 */
- (void)fixSingleWidthForLeftMaxWidth:(CGFloat)maxWidth minWidth:(CGFloat)minWidth {
    [self fixSignleWidthForLeftBellowMaxWidth:maxWidth];
    // 获取得到的宽度
    if (self.frame.size.width < minWidth) {
        [self fixSignleWidthForLeftOverMinWidth:minWidth];
    }
    
}

/**
 * 修复宽度，有最大最小值, 右对齐方式
 */
- (void)fixSingleWidthForRightMaxWidth:(CGFloat)maxWidth minWidth:(CGFloat)minWidth {
    [self fixSingleWidthForRightBellowMaxWidth:maxWidth];
    if (self.frame.size.width < minWidth) {
        [self fixSingleWidthForRightOverMinWidth:minWidth];
    }
}

/**
 * 修复宽度，有最大最小值, 中心点不变
 */
- (void)fixSignleWidthForCenterMaxWidth:(CGFloat)maxWidth minWidth:(CGFloat)minWidth {
    CGPoint center = self.center;
    [self fixSingleWidthForLeftMaxWidth:maxWidth minWidth:minWidth];
    if (self.frame.size.width > maxWidth) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, maxWidth, self.frame.size.height);
    }
    if (self.frame.size.width < minWidth) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, minWidth, self.frame.size.height);
    }
    
    self.center = center;
}


@end
