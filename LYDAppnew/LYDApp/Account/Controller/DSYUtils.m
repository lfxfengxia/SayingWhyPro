//
//  DSYUtils.m
//  LYDApp
//
//  Created by dai yi on 2016/12/1.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYUtils.h"
#import "LoginStareViewController.h"

@implementation DSYUtils

/**
 * 显示401 错误返回信息处理
 */
+ (void)showResponseError_401_ForViewController:(UIViewController *)viewController okHandler:(void (^)(UIAlertAction *))okHandler {
    NSString *title = @"注意";
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:@"账号在其他设备登录,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:okHandler];
    [alertVC addAction:alertAC];
    
    // 设置样式
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [alertVC setValue:alertControllerStr forKey:@"attributedTitle"];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}


+ (void)showResponseError_401_ForViewController:(UIViewController *)viewController {
    [self showResponseError_401_ForViewController:viewController okHandler:^(UIAlertAction *action) {

        [viewController pushToLoginController];
    }];
}

+ (void)showResponseError_404_ForViewController:(UIViewController *)viewController message:(NSString *)message okHandler:(void (^ __nullable)(UIAlertAction *action))okHandler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelHandler {
    NSString *title = @"注意";
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:okHandler];
    
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:cancelHandler];
    
    [alertVC addAction:alertAC];
    [alertVC addAction:loginAction];
    
    // 设置样式
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [alertVC setValue:alertControllerStr forKey:@"attributedTitle"];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)showSuccessForStatus_600_FroView:(UIView *)view {
    [MBProgressHUD showError:@"登录状态已过期，请重新登录" toView:view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LoginStareViewController alloc] init];
    });
}

+ (void)showSuccessForStatus_600_ForViewController:(UIViewController *)viewController {
    NSString *title = @"温馨提示";
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:@"登录状态已过期，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [viewController pushToLoginController];
    }];
    [alertVC addAction:alertAC];
    
    // 设置样式
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [alertVC setValue:alertControllerStr forKey:@"attributedTitle"];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)showSuccessForStatus_600_ForViewController:(UIViewController *)viewController okHandler:(void (^ __nullable)(UIAlertAction *action))okHandler {
    NSString *title = @"温馨提示";
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:@"登录状态已过期，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:okHandler];
    [alertVC addAction:alertAC];
    
    // 设置样式
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [alertVC setValue:alertControllerStr forKey:@"attributedTitle"];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

@end
