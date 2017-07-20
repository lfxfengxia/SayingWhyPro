//
//  factoryMethod.h
//  RYApp
//
//  Created by Riber on 16/8/22.
//  Copyright © 2016年 dookay_73. All rights reserved.
//  工厂化方法--> 这里只初始化控件 事件不在这里添加

#import <Foundation/Foundation.h>

@interface RYFactoryMethod : NSObject

// 不可设置粗体
+ (UILabel *)initWithLabelFrame:(CGRect)frame andTextColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize;

// 可设置粗体
+ (UILabel *)initWithLabelFrame:(CGRect)frame andTextColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize isBold:(BOOL)isBold;

// inageView
+ (UIImageView *)initWithImageViewFrame:(CGRect)frame;

+ (UIImageView *)initWithNormalImageViewFrame:(CGRect)frame andImageName:(NSString *)name;

// 新手引导
+ (void)initWithGuideImageViewTarget:(id)target Name:(NSString *)imageName buttonFrame:(CGRect)frame;

// 横的分割线
+ (UIView *)initWithLineViewFrame:(CGRect)frame;

// 带边框的按钮
+ (UIButton *)initWithButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize;

+ (UIButton *)initWithNormalButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize;


// textField
+ (UITextField *)initWithTextFieldFrame:(CGRect)frame andTextColor:(UIColor *)color placeHoder:(NSString *)placeHoder fontOfSystemSize:(CGFloat)fontSize;

+ (NSMutableAttributedString *)addAttributed:(NSString *)oldString attributes:(NSDictionary *)attributesDic range:(NSRange)range;

// 提示用的 alertView
+ (void)alertViewOrControllerShow:(NSString *)alertString viewController:(UIViewController *)viewController;

/**
 * 带有确定，取消的提示框
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message forViewController:(UIViewController *)viewController okHandler:(void (^ __nullable)(UIAlertAction *action))okHandler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler;

@end
