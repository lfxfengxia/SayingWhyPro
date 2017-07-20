//
//  UITextField+DSY.m
//  DDJApp
//
//  Created by dai yi on 2016/11/14.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "UITextField+DSY.h"

@implementation UITextField (DSY)

-(void)addLeftViewWithImage:(NSString *)image width:(CGFloat)width{
    
    
    // 输入框左边图片
    UIImageView *leftImgView = [[UIImageView alloc] init];
    
    // 设置尺寸
    leftImgView.frame = CGRectMake(0, 0, width, self.bounds.size.height);
    
    // 设置图片
    leftImgView.image = [[UIImage imageNamed:image] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    // 设置图片居中显示
    leftImgView.contentMode = UIViewContentModeCenter;
    
    // 添加TextFiled的左边视图
    self.leftView = leftImgView;
    
    // 设置TextField左边的总是显示
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)addRightViewWithImage:(NSString *)image width:(CGFloat)width {
    // 输入框左边图片
    UIImageView *rightImgView = [[UIImageView alloc] init];
    
    // 设置尺寸
    rightImgView.frame = CGRectMake(0, 0, width, self.bounds.size.height);
    
    // 设置图片
    rightImgView.image = [[UIImage imageNamed:image] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    // 设置图片居中显示
    rightImgView.contentMode = UIViewContentModeCenter;
    
    // 添加TextFiled的左边视图
    self.rightView = rightImgView;
    
    // 设置TextField左边的总是显示
    self.rightViewMode = UITextFieldViewModeAlways;
}


- (void)addLeftViewWithImage:(NSString *)leftImage rightViewWithImage:(NSString *)rightImage forWidth:(CGFloat)width {
    [self addLeftViewWithImage:leftImage width:width];
    [self addRightViewWithImage:rightImage width:width];
}


@end
