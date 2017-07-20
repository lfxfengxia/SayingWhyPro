//
//  UIView+AddLine.h
//  DDJApp
//
//  Created by dai yi on 2016/11/17.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewLineAlignment) {
    UIViewLineAlignmentTop,
    UIViewLineAlignmentLeft,
    UIViewLineAlignmentBottom,
    UIViewLineAlignmentRight
};
@interface UIView (AddLine)

//@property (nonatomic, strong) NSMutableArray *dsy_lines;     /**< 当前view的线条 */

/**
 * 通过线条的宽度，对齐方式添加一条rgb为225的灰色线条
 */
- (void)insertLineWithWidth:(CGFloat)width align:(UIViewLineAlignment)alignment;

/**
 * 通过线条的宽度，rgb相同的纯颜色，对齐方式(有上，左，下，右)添加一条线条
 */
- (void)insertLineWithWidth:(CGFloat)width rgbColor:(CGFloat)rgbColor align:(UIViewLineAlignment)alignment;

/**
 * 通过线条宽度，颜色，对其方式(有上，左，下，右)添加一条线
 */
- (void)insertLineWithWidth:(CGFloat)width color:(UIColor *)color align:(UIViewLineAlignment)alignment;

/**
 * 在一个中心点插入一条xian
 */
- (void)insertLineWithSize:(CGSize)size color:(UIColor *)color forCenter:(CGPoint)center;

/**
 * 通过frame和颜色添加一条线
 */
- (void)insertLineWithFrame:(CGRect)frame color:(UIColor *)color;


/**
 * 通过线条的宽度，对齐方式添加一条rgb为225的灰色线条(autoLayout)
 */
- (void)insertLayoutLineWithWidth:(CGFloat)width align:(UIViewLineAlignment)alignment;

/**
 * 通过线条的宽度，rgb相同的纯颜色，对齐方式(有上，左，下，右)添加一条线条(autoLayout)
 */
- (void)insertLayoutLineWithWidth:(CGFloat)width rgbColor:(CGFloat)rgbColor align:(UIViewLineAlignment)alignment;

/**
 * 通过线条宽度，颜色，对其方式(有上，左，下，右)添加一条线(autoLayout)
 */
- (void)insertLayoutLineWithWidth:(CGFloat)width color:(UIColor *)color align:(UIViewLineAlignment)alignment;

/**
 * 通过约束和颜色添加一条线
 */
- (void)insertLayoutLineWithConstraints:(void(^)(MASConstraintMaker *))block color:(UIColor *)color;


@end
