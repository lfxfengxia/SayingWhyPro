//
//  DSYUtils.h
//  LYDApp
//
//  Created by dai yi on 2016/12/1.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSYUtils : NSObject
/**
 * 显示401 错误返回信息处理, 并且重新登录
 */
+ (void)showResponseError_401_ForViewController:(UIViewController *__nullable)viewController;

/**
 * 显示401 错误返回信息处理
 */
+ (void)showResponseError_401_ForViewController:(UIViewController *__nullable)viewController okHandler:(void (^ __nullable)(UIAlertAction *__nullable))okHandler;

/**
 * 404错误处理
 */
+ (void)showResponseError_404_ForViewController:(UIViewController *__nullable)viewController message:(NSString *__nullable)message okHandler:(void (^ __nullable)(UIAlertAction *__nullable))okHandler cancelHandler:(void (^ __nullable)(UIAlertAction *__nullable))cancelHandler;

/**
 * 600 状态吗的处理
 */

//+ (void)showSuccessForStatus_600_FroView:(UIView *)view;

+ (void)showSuccessForStatus_600_ForViewController:(UIViewController *__nullable)viewController;

+ (void)showSuccessForStatus_600_ForViewController:(UIViewController *__nullable)viewController okHandler:(void (^ __nullable)(UIAlertAction *__nullable))okHandler;

@end
