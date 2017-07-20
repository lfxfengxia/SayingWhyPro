//
//  XYMainTabBarController.m
//  LYDApp
//
//  Created by dookay_73 on 16/10/31.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYMainTabBarController.h"
#import "XYHomeController.h"
#import "XYMoneyController.h"
#import "XYMoreController.h"
#import "XYHomeControllerXin.h"
#import "ShouYiViewController.h"
#import "XYAccountController.h"
#import "FuWuViewController.h"
#import "MyViewController.h"

@interface XYMainTabBarController ()

@end

@implementation XYMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 更新用户数据
//    [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
//        [self setupChildControllers];
//    }];
    
//    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        [self setupChildControllers];
//    }];
    self.delegate=self;
    [self.tabBar setBarTintColor:[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f]];
    
}

- (void)setupChildControllers
{
    XYHomeControllerXin *home = [[XYHomeControllerXin alloc] init];
    [self setupChildControllers:home WithTitle:@"理财" imageName:@"理财" selectedImageName:@"理财-show"];
    
    ShouYiViewController *ShouYiView = [[ShouYiViewController alloc] init];
    [self setupChildControllers:ShouYiView WithTitle:@"收益" imageName:@"收益" selectedImageName:@"收益show"];
    
    FuWuViewController *FuWu = [[FuWuViewController alloc] init];
    [self setupChildControllers:FuWu WithTitle:@"服务" imageName:@"服务" selectedImageName:@"服务show"];
    
    MyViewController *my = [[MyViewController alloc] init];
    [self setupChildControllers:my WithTitle:@"我的" imageName:@"我的" selectedImageName:@"我的show"];
}

#pragma mark - 设置子控制器的方法
- (void)setupChildControllers:(UIViewController *)childVC WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVC.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [nav.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self addChildViewController:nav];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger index=[self.viewControllers indexOfObject:viewController];
    if (index==1 && tabBarController.selectedIndex==index) {
        UINavigationController *nav=(UINavigationController *)viewController;
        if(nav.viewControllers.count==1)
        {
            return YES;
        }else
        {
            return NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
