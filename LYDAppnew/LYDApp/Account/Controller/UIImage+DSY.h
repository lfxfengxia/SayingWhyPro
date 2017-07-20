//
//  UIImage+DSY.h
//  LYDApp
//
//  Created by dai yi on 2016/11/5.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DSY)

/**
 * 返回中心拉伸的图片
 */
+ (UIImage *)stretchedImageWithName:(NSString *)name;

+ (UIImage *)stretchedImageWithImage:(UIImage *)image;

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;

@end
