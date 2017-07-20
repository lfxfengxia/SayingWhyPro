//
//  factoryMethod.m
//  RYApp
//
//  Created by Riber on 16/8/22.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RYFactoryMethod.h"

@implementation RYFactoryMethod

// 旧方法
+ (UILabel *)initWithLabelFrame:(CGRect)frame andTextColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize
{
    UILabel *factoryLabel = [[UILabel alloc] initWithFrame:frame];
    factoryLabel.textColor = color;
    factoryLabel.textAlignment = NSTextAlignmentCenter;
    factoryLabel.font = [UIFont systemFontOfSize:fontSize];
    
    return factoryLabel;
}

// 新方法 可设置粗体
+ (UILabel *)initWithLabelFrame:(CGRect)frame andTextColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize isBold:(BOOL)isBold
{
    UILabel *factoryLabel = [[UILabel alloc] initWithFrame:frame];
    factoryLabel.textColor = color;
    if (isBold) {
        factoryLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }
    else
    {
        factoryLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    factoryLabel.textAlignment = NSTextAlignmentCenter;

    return factoryLabel;
}

+ (UIImageView *)initWithImageViewFrame:(CGRect)frame
{
    UIImageView *factoryImageView = [[UIImageView alloc] initWithFrame:frame];
    factoryImageView.layer.masksToBounds = YES;
    factoryImageView.layer.cornerRadius = 5;
    
    return factoryImageView;
}

+ (UIImageView *)initWithNormalImageViewFrame:(CGRect)frame andImageName:(NSString *)name
{
    UIImageView *factoryImageView = [[UIImageView alloc] initWithFrame:frame];
    factoryImageView.image = [UIImage imageNamed:name];
    
    return factoryImageView;
}


+ (void)initWithGuideImageViewTarget:(id)target Name:(NSString *)imageName buttonFrame:(CGRect)frame
{
    UIImageView *factoryImageView = [[UIImageView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    factoryImageView.userInteractionEnabled = YES;
    factoryImageView.image = [UIImage imageNamed:imageName];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
//    button.backgroundColor = [UIColor redColor];
    [button addTarget:target action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [factoryImageView addSubview:button];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(tapImageView:)];
//    [factoryImageView addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow addSubview:factoryImageView];
}

+ (UIView *)initWithLineViewFrame:(CGRect)frame
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.00];

    return lineView;
}

+ (UIButton *)initWithButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize
{
    UIButton *factoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    factoryButton.frame = frame;
    [factoryButton setTitle:title forState:UIControlStateNormal];
    [factoryButton setTitleColor:color forState:UIControlStateNormal];
    factoryButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    factoryButton.layer.cornerRadius = 5;
    factoryButton.layer.borderWidth = 1;
    factoryButton.layer.borderColor = color.CGColor;
    
    return factoryButton;
}

+ (UIButton *)initWithNormalButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color fontOfSystemSize:(CGFloat)fontSize
{
    UIButton *factoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    factoryButton.frame = frame;
    [factoryButton setTitle:title forState:UIControlStateNormal];
    [factoryButton setTitleColor:color forState:UIControlStateNormal];
    factoryButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];

    return factoryButton;
}


+ (UITextField *)initWithTextFieldFrame:(CGRect)frame andTextColor:(UIColor *)color placeHoder:(NSString *)placeHoder fontOfSystemSize:(CGFloat)fontSize
{
    UITextField *factoryTF = [[UITextField alloc] initWithFrame:frame];
    factoryTF.placeholder = placeHoder;
    factoryTF.textColor = color;
    factoryTF.font = [UIFont systemFontOfSize:fontSize];
    //[factoryTF setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [factoryTF setValue:[UIFont systemFontOfSize:fontSize] forKeyPath:@"_placeholderLabel.font"];
    
    return factoryTF;
}

+ (NSMutableAttributedString *)addAttributed:(NSString *)oldString attributes:(NSDictionary *)attributesDic range:(NSRange)range
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:oldString];
    [attributedString addAttributes:attributesDic range:range];

    return attributedString;
}

+ (void)alertViewOrControllerShow:(NSString *)alertString viewController:(UIViewController *)viewController
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:alertString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"" message:alertString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        
        [alertViewController addAction:action];
        [viewController presentViewController:alertViewController animated:YES completion:nil];
    }
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message forViewController:(UIViewController *)viewController okHandler:(void (^ __nullable)(UIAlertAction *action))okHandler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:cancelHandler];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:okHandler];
    [cancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    [alertViewController addAction:cancel];
    [alertViewController addAction:action];
    
    
    // 设置样式
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [alertViewController setValue:alertControllerStr forKey:@"attributedTitle"];
    
    [viewController presentViewController:alertViewController animated:YES completion:nil];
}

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    
}

- (void)buttonClick:(UIButton *)button {
    
}

@end
