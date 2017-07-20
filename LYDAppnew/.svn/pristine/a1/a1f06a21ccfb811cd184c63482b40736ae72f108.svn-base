//
//  MoreBaseViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/3.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "MoreBaseViewController.h"

@interface MoreBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation MoreBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[DSYImage(@"back_icon.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [self createUI];
    [self loadData];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleNavigationTransition:(UIPanGestureRecognizer *)pan {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI {
    
}

- (void)loadData {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    self.tabBarController.tabBar.hidden = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
