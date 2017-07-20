//
//  UIViewController+DSY.h
//  LYDApp
//
//  Created by dai yi on 2016/12/22.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DSY)
// push到登录页面
- (void)pushToLoginController;

// present一个背景透明的控制器
- (void)presentDSYViewController:(UIViewController *)viewController;

// present登录控制器
- (void)presentToLoginController:(void (^ __nullable)(void))completion;
@end
