//
//  UIImage+DSY.m
//  LYDApp
//
//  Created by dai yi on 2016/11/5.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "UIImage+DSY.h"

@implementation UIImage (DSY)

+ (UIImage *)stretchedImageWithImage:(UIImage *)image {
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    return [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}


+ (UIImage *)stretchedImageWithName:(NSString *)name {
    return [UIImage stretchedImageWithImage:[UIImage imageNamed:name]];
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect {
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
