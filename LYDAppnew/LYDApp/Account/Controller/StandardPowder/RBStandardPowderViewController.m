//
//  RBStandardPowderViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/7.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBStandardPowderViewController.h"
#import "RBTitleView.h"
// 五个控制器
#import "DSYDivergenceAllController.h"
#import "DSYDivergenceHoldingController.h"
#import "DSYDivergenceCompleteController.h"
#import "DSYDivergenceAssigningController.h"
#import "DSYDivergenceAssignedController.h"



@interface RBStandardPowderViewController ()<UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) RBTitleView *titleView;

@property (nonatomic, assign) NSInteger currentIndex;                       /**< 当前的选项卡 */
@property (nonatomic, strong) UIScrollView *mainScrollView;                 /**< 主要内容区域 */

@property (nonatomic, strong) DSYDivergenceAllController *allVC;            /**< 全部 */
@property (nonatomic, strong) DSYDivergenceHoldingController *holdVC;       /**< 持有中 */
@property (nonatomic, strong) DSYDivergenceCompleteController *completeVC;  /**< 已完成 */
@property (nonatomic, strong) DSYDivergenceAssigningController *assigningVC;/**< 转让中 */
@property (nonatomic, strong) DSYDivergenceAssignedController *assignedVC;  /**< 已转让 */

@end

@implementation RBStandardPowderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"散标投资";
    self.view.backgroundColor = BgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    
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
    
}

/**
 * 创建UI
 */

- (void)createUI {
    
    self.titleView = [[RBTitleView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, H(45)) andTitleArray:@[@"全部", @"持有中", @"已完成", @"转让中",@"已转让"]];
    [self.view addSubview:_titleView];
    __weak RBStandardPowderViewController *weakSelf = self;
    _titleView.titleButtonClickBlock = ^(NSUInteger index) {
        weakSelf.currentIndex = index;
    };
    
    [self mainScrollView];

}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    
    _currentIndex = currentIndex;
    
    if (_currentIndex == 0) {
        [self allVC];
    } else if (_currentIndex == 1) {
        [self holdVC];
    } else if (_currentIndex == 2) {
        [self completeVC];
    } else if (_currentIndex == 3) {
        [self assigningVC];
    } else if (_currentIndex == 4) {
        [self assignedVC];
    } else {
        [self allVC];
        _currentIndex = 0;
    }
    
//    [self.titleView setSelectIndex:_currentIndex];
    [UIView animateWithDuration:0.3 animations:^{
        if (_currentIndex >= 0 && _currentIndex < 5) {
            self.mainScrollView.contentOffset = CGPointMake(_currentIndex * kSCREENW, 0);
        }
    }];
    
}


#pragma mark - property的getter方法(属性的懒加载)
#pragma mark mainScrollView的创建------------
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleView.maxY, kSCREENW, self.view.height - self.titleView.maxY)];
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
#pragma mark allVC的创建
- (DSYDivergenceAllController *)allVC {
    if (!_allVC) {
        _allVC = [[DSYDivergenceAllController alloc] init];
        [self addChildViewController:_allVC];
        _allVC.view.frame = CGRectMake(0, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_allVC.view];
        
    }
    return _allVC;
}

#pragma mark holdVC的创建
- (DSYDivergenceHoldingController *)holdVC {
    if (!_holdVC) {
        _holdVC = [[DSYDivergenceHoldingController alloc] init];
        [self addChildViewController:_holdVC];
        _holdVC.view.frame = CGRectMake(kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_holdVC.view];
        
    }
    return _holdVC;
}

#pragma mark completeVC的创建
- (DSYDivergenceCompleteController *)completeVC {
    if (!_completeVC) {
        _completeVC = [[DSYDivergenceCompleteController alloc] init];
        [self addChildViewController:_completeVC];
        _completeVC.view.frame = CGRectMake(2 * kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_completeVC.view];
        
    }
    return _completeVC;
}

#pragma mark assigningVC的创建
- (DSYDivergenceAssigningController *)assigningVC {
    if (!_assigningVC) {
        _assigningVC = [[DSYDivergenceAssigningController alloc] init];
        [self addChildViewController:_assigningVC];
        _assigningVC.view.frame = CGRectMake(3 * kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_assigningVC.view];
        
    }
    return _assigningVC;
}

#pragma mark assignedVC的创建
- (DSYDivergenceAssignedController *)assignedVC {
    if (!_assignedVC) {
        _assignedVC = [[DSYDivergenceAssignedController alloc] init];
        [self addChildViewController:_assignedVC];
        _assignedVC.view.frame = CGRectMake(4 * kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_assignedVC.view];
        
    }
    return _assignedVC;
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
        [self.titleView setSelectIndex:self.currentIndex];
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
