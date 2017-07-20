//
//  RBTitleView.h
//  LYDApp
//
//  Created by Riber on 16/11/7.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NormalColor [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.00]
#define SelectColor [UIColor colorWithRed:0.98 green:0.42 blue:0.13 alpha:1.00]
#define LIGHTGRAYTEXT [UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.00]

@interface RBTitleView : UIView

@property (nonatomic, strong) void (^titleButtonClickBlock)(NSUInteger);
@property (nonatomic, assign) BOOL isHaveRightLine;

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray;

// 设置选中第几个按钮
- (void)setSelectIndex:(NSInteger)index;

// 设置字体
- (void)setButtonTitleFont:(UIFont *)font;

@end
