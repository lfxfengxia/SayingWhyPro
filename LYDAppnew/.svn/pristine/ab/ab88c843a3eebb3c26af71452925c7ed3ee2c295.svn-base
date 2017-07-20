//
//  DSYFinancingBaseDetailController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseDetailController.h"

@interface DSYFinancingBaseDetailController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation DSYFinancingBaseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 获取系统自带滑动手势的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    self.pan = pan;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    //    [self.allVC.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // 给UIWebView添加UserAgent
    [self addUserAgent];
}

- (void)addUserAgent {
    NSString *oldAgent = [[[UIWebView alloc] init] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newAgent;
    if ([oldAgent hasSuffix:@"lyd-app"]) {
        newAgent = oldAgent;
    } else {
        newAgent = [oldAgent stringByAppendingString:@"lyd-app"];
    }
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}

#pragma mark - pan手势的代理
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    //    NSLog(@"%f", self.mainScrollView.contentOffset.x);
    
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if(self.navigationController.childViewControllers.count == 1){
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchPoint =  [touch locationInView:self.view];
    // 判断滑动的起始点是否在小于左边的100
    if (touchPoint.x > 100 && gestureRecognizer == self.pan) {
        return NO;
    }
    
    return YES;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self.view];
    NSLog(@"偏移: %f", point.x);
    
    [self.navigationController popViewControllerAnimated:YES];
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
