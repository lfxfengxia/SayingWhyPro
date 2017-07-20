//
//  UIView+AddLine.m
//  DDJApp
//
//  Created by dai yi on 2016/11/17.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "UIView+AddLine.h"
#import <objc/runtime.h>

//static const char kLineKey = 'd';
@implementation UIView (AddLine)
/**
 * 通过线条的宽度，对齐方式添加一条rgb为225的灰色线条
 */
- (void)insertLineWithFrame:(CGRect)frame color:(UIColor *)color {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:lineView];
    lineView.backgroundColor = color;
    
//    self.dsy_lines = [NSMutableArray arrayWithArray:self.dsy_lines];
//    [self.dsy_lines addObject:lineView];
//    self addObserver:self forKeyPath:@"frame" options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)#>
}

- (void)insertLineWithSize:(CGSize)size color:(UIColor *)color forCenter:(CGPoint)center {
    CGRect frame =  CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height);
    
    [self insertLineWithFrame:frame color:color];
}

/**
 * 通过线条宽度，颜色，对其方式(有上，左，下，右)添加一条线
 */
- (void)insertLineWithWidth:(CGFloat)width color:(UIColor *)color align:(UIViewLineAlignment)alignment {
    CGRect frame;
    if (alignment == UIViewLineAlignmentTop) {
        frame = CGRectMake(0, 0, self.frame.size.width, width);
    } else if (alignment == UIViewLineAlignmentLeft) {
        frame = CGRectMake(0, 0, width, self.frame.size.height);
    } else if (alignment == UIViewLineAlignmentRight) {
        frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
    } else {
        frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
    }
    
    [self insertLineWithFrame:frame color:color];
}

/**
 * 通过线条的宽度，rgb相同的纯颜色，对齐方式(有上，左，下，右)添加一条线条
 */
- (void)insertLineWithWidth:(CGFloat)width rgbColor:(CGFloat)rgbColor align:(UIViewLineAlignment)alignment {
    UIColor *color = [UIColor colorWithRed:rgbColor / 255.0 green:rgbColor / 255.0 blue:rgbColor / 255.0 alpha:1];
    
    [self insertLineWithWidth:width color:color align:alignment];
}


/**
 * 通过线条的宽度，对齐方式添加一条rgb为225的灰色线条
 */
- (void)insertLineWithWidth:(CGFloat)width align:(UIViewLineAlignment)alignment {
    CGFloat rgbColor = 225.0f;
    [self insertLineWithWidth:width rgbColor:rgbColor align:alignment];
}



/**
 * 通过线条的宽度，对齐方式添加一条rgb为225的灰色线条
 */
- (void)insertLayoutLineWithWidth:(CGFloat)width align:(UIViewLineAlignment)alignment {
    CGFloat rgbColor = 225.0f;
    [self insertLayoutLineWithWidth:width rgbColor:rgbColor align:alignment];
    
}

/**
 * 通过线条的宽度，rgb相同的纯颜色，对齐方式(有上，左，下，右)添加一条线条
 */
- (void)insertLayoutLineWithWidth:(CGFloat)width rgbColor:(CGFloat)rgbColor align:(UIViewLineAlignment)alignment {
    UIColor *color = [UIColor colorWithRed:rgbColor / 255.0 green:rgbColor / 255.0 blue:rgbColor / 255.0 alpha:1];
    
    [self insertLayoutLineWithWidth:width color:color align:alignment];
}

/**
 * 通过线条宽度，颜色，对其方式(有上，左，下，右)添加一条线
 */
- (void)insertLayoutLineWithWidth:(CGFloat)width color:(UIColor *)color align:(UIViewLineAlignment)alignment {
    CGRect frame;
    if (alignment == UIViewLineAlignmentTop) {
        frame = CGRectMake(0, 0, self.frame.size.width, width);
    } else if (alignment == UIViewLineAlignmentLeft) {
        frame = CGRectMake(0, 0, width, self.frame.size.height);
    } else if (alignment == UIViewLineAlignmentRight) {
        frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
    } else {
        frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
    }
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:lineView];
    lineView.backgroundColor = color;
    
    if (alignment == UIViewLineAlignmentTop) {
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self).with.offset(0);
            make.height.mas_equalTo(width);
        }];
    } else if (alignment == UIViewLineAlignmentLeft) {
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self).with.offset(0);
            make.width.mas_equalTo(width);
        }];
    } else if (alignment == UIViewLineAlignmentRight) {
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self).with.offset(0);
            make.width.mas_equalTo(width);
        }];
    } else {
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self).with.offset(0);
            make.height.mas_equalTo(width);
        }];
    }
}

/**
 * 通过约束和颜色添加一条线
 */
- (void)insertLayoutLineWithConstraints:(void(^)(MASConstraintMaker *))block color:(UIColor *)color {
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = color;
    [lineView mas_makeConstraints:block];
}
//- (void)setDsy_lines:(NSMutableArray *)dsy_lines {
//    objc_setAssociatedObject(self, &kLineKey, dsy_lines, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (NSMutableArray *)dsy_lines {
//    
//    return objc_getAssociatedObject(self, &kLineKey);
//}

@end
