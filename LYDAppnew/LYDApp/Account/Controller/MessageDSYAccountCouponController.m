//
//  MessageDSYAccountCouponController.m
//  LYDApp
//
//  Created by fcl on 17/3/24.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "MessageDSYAccountCouponController.h"
#import "RBTitleView.h"

#import "DSYCouponUnBindController.h"
#import "DSYCouponUnUseController.h"
#import "DSYCouponUsedController.h"
#import "DSYCouponOverduedController.h"
#import "DSYCouponAddController.h"

@interface MessageDSYAccountCouponController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) RBTitleView *topTabbar;     /**< 顶部的tabbar切换卡 */

@property (nonatomic, strong) UIScrollView *mainScrollView;  /**< 主要内容区域 */
@property (nonatomic, strong) DSYCouponUnBindController *unBindVC;    /**< 未绑定 */
@property (nonatomic, strong) DSYCouponUnUseController *unUseVC;      /**< 未使用 */
@property (nonatomic, strong) DSYCouponUsedController *usedVC;       /**< 已使用 */
@property (nonatomic, strong) DSYCouponOverduedController *overduedVC;/**< 已过期 */
@property (nonatomic, strong) DSYCouponAddController *addVC;          /**< 添加 */@end

@implementation MessageDSYAccountCouponController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"优惠券";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatUI];
    
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
    //    [self.mainScrollView addGestureRecognizer:pan];
    [self.mainScrollView.panGestureRecognizer requireGestureRecognizerToFail:pan];
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    // 默认选择
    self.currentIndex = 0;
    
    
    
    self.view.backgroundColor=[UIColor redColor];
    [self backui];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backAction) name:@"xiaohui" object:nil];//销毁之前的消息
}



-(void)backui
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 40, 40);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
}



-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}



- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    _currentIndex = currentIndex;
    
    if (_currentIndex == 0) {
        [self unBindVC];
    } else if (_currentIndex == 1) {
        [self unUseVC];
        if (self.unUsedRefresh) {
            self.unUsedRefresh = NO;
            [self.unUseVC beiginRefresh];
        }
    } else if (_currentIndex == 2) {
        [self usedVC];
    } else if (_currentIndex == 3) {
        [self overduedVC];
    } else if (_currentIndex == 4) {
        [self addVC];
    } else {
        [self addVC];
        _currentIndex = 4;
    }
    
    //    [self.titleView setSelectIndex:_currentIndex];
    [UIView animateWithDuration:0.3 animations:^{
        if (_currentIndex >= 0 && _currentIndex < 5) {
            self.mainScrollView.contentOffset = CGPointMake(_currentIndex * kSCREENW, 0);
        }
    }];
    
}

- (void)creatUI {
    [self topTabbar];
    [self mainScrollView];
}

#pragma mark - property的getter方法(属性的懒加载)
#pragma mark topTabbar的创建------------
- (RBTitleView *)topTabbar {
    if (!_topTabbar) {
        _topTabbar = [[RBTitleView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, H(45)) andTitleArray:@[@"未绑定", @"未使用", @"已使用", @"已过期",@"添加"]];
        [self.view addSubview:_topTabbar];
        __weak MessageDSYAccountCouponController *weakSelf = self;
        _topTabbar.titleButtonClickBlock = ^(NSUInteger index) {
            weakSelf.currentIndex = index;
        };
        
    }
    return _topTabbar;
}


#pragma mark mainScrollView的创建------------
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topTabbar.maxY, kSCREENW, self.view.height - self.topTabbar.maxY)];
        [self.view addSubview:_mainScrollView];
        _mainScrollView.contentSize = CGSizeMake(5 * kSCREENW, 0);
        _mainScrollView.backgroundColor = rgba(249, 249, 249, 1);
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        
    }
    return _mainScrollView;
}


#pragma mark - 创建子控制器
#pragma mark unBindVC的创建
- (DSYCouponUnBindController *)unBindVC {
    if (!_unBindVC) {
        _unBindVC = [[DSYCouponUnBindController alloc] init];
        [self addChildViewController:_unBindVC];
        _unBindVC.view.frame = CGRectMake(0, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_unBindVC.view];
        
    }
    return _unBindVC;
}

#pragma mark unUseVC的创建
- (DSYCouponUnUseController *)unUseVC {
    if (!_unUseVC) {
        _unUseVC = [[DSYCouponUnUseController alloc] init];
        [self addChildViewController:_unUseVC];
        _unUseVC.view.frame = CGRectMake(kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_unUseVC.view];
        
    }
    return _unUseVC;
}

#pragma mark usedVC的创建
- (DSYCouponUsedController *)usedVC {
    if (!_usedVC) {
        _usedVC = [[DSYCouponUsedController alloc] init];
        [self addChildViewController:_usedVC];
        _usedVC.view.frame = CGRectMake(2 * kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_usedVC.view];
        
    }
    return _usedVC;
}

#pragma mark overduedVC的创建
- (DSYCouponOverduedController *)overduedVC {
    if (!_overduedVC) {
        _overduedVC = [[DSYCouponOverduedController alloc] init];
        [self addChildViewController:_overduedVC];
        _overduedVC.view.frame = CGRectMake(3 * kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_overduedVC.view];
        
    }
    return _overduedVC;
}

#pragma mark addVC的创建
- (DSYCouponAddController *)addVC {
    if (!_addVC) {
        _addVC = [[DSYCouponAddController alloc] init];
        [self addChildViewController:_addVC];
        _addVC.view.frame = CGRectMake(4 * kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_addVC.view];
        
    }
    return _addVC;
}


#pragma mark - maiScrollView的Delegate方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        NSInteger index = (NSInteger)(self.mainScrollView.contentOffset.x / self.mainScrollView.width);
        
        // 如果超过页面数量或小于0的时候默认选择为0
        if (index < 0 && index > 4) {
            self.currentIndex = 0;
        } else {
            self.currentIndex = index;
        }
        [self.topTabbar setSelectIndex:self.currentIndex];
    }
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
    CGPoint touchPoint =  [touch locationInView:self.mainScrollView];
    NSLog(@"%f---", touchPoint.x);
    if (touchPoint.x > 100 && gestureRecognizer == self.pan) {
        return NO;
    }
    return YES;
}
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan {
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
