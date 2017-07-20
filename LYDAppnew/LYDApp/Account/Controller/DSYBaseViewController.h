//
//  DSYBaseViewController.h
//  LYDApp
//
//  Created by dai yi on 2016/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSYBaseViewController : UIViewController

@property (nonatomic, weak) UILabel *titleNavigationBarLabel;

@property (nonatomic,   copy) NSString *navigaTitle;

- (void)back;

@end
