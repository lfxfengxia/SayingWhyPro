//
//  DSYAlertViewController.h
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertViewControllerOKBlock)(UIViewController *);
typedef void(^AlertViewControllerCancelBlock)(UIViewController *);
typedef void(^AlertViewControllerDismissBlock)(UIViewController *);
@interface DSYAlertViewController : UIViewController

- (instancetype)initWithMessage:(NSString *)message oKBlock:(AlertViewControllerOKBlock)okBlock cancelBlock:(AlertViewControllerCancelBlock)cancelBlock dismissBlock:(AlertViewControllerDismissBlock)dismissBlock;

@property (nonatomic,   copy) NSString *message;

@end
