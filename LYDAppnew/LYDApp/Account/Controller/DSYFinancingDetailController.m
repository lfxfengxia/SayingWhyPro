//
//  DSYFanancingDetailController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingDetailController.h"
#import "RBTitleView.h"
#import "DSYFinancingModel.h"

#import "DSYCheckDetailController.h"
#import "DSYServiceProtocolViewController.h"
#import "DSYInvestGroupController.h"
#import "DSYFinancingAsiignDebtsController.h"

@interface DSYFinancingDetailController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) RBTitleView *titleView;

@property (nonatomic, assign) NSInteger currentIndex;                       /**< 当前的选项卡 */
@property (nonatomic, strong) UIScrollView *mainScrollView;                 /**< 主要内容区域 */



@property (nonatomic, strong) DSYCheckDetailController *detailVC;               /**< 账单详情 */
@property (nonatomic, strong) DSYServiceProtocolViewController *protocolVC;     /**< 服务协议 */
@property (nonatomic, strong) DSYInvestGroupController *groupVC;                /**< 投资组合 */
@property (nonatomic, strong) DSYFinancingAsiignDebtsController *assignVC;        /**< 债权转让 */

@end

@implementation DSYFinancingDetailController

- (instancetype)initWithFinancing:(DSYFinancingModel *)financing {
    self = [super init];
    if (self) {
        _financing = financing;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigaTitle = @"投资详情";
    if (self.financing == nil) {
        // 新手进入
        
    }
    
    self.navigaTitle = self.financing.title;
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

- (NSArray *)titles {
    if (!_titles || _titles.count == 0) {
       // _titles = @[@"账单详情", @"服务协议", @"投资组合", @"债权转让"];
        _titles = @[@"账单详情", @"服务协议", @"债权列表"];
    }
    return _titles;
}

/**
 * 创建UI
 */

- (void)createUI {
    
    self.titleView = [[RBTitleView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, H(45)) andTitleArray:self.titles];
    [self.view addSubview:_titleView];
    __weak DSYFinancingDetailController *weakSelf = self;
    _titleView.titleButtonClickBlock = ^(NSUInteger index) {
        weakSelf.currentIndex = index;
    };
    
    [self mainScrollView];
    
    
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    
//    _currentIndex = currentIndex;
//    
//    if (_currentIndex == 0) {
//        [self detailVC];
//    } else if (_currentIndex == 1) {
//        [self protocolVC];
//    } else if (_currentIndex == 2) {
//        [self groupVC];
//    } else if (_currentIndex == 3) {
//        [self assignVC];
//    } else {
//        [self detailVC];
//        _currentIndex = 0;
//    }
//    
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        if (_currentIndex >= 0 && _currentIndex < self.titles.count) {
//            self.mainScrollView.contentOffset = CGPointMake(_currentIndex * kSCREENW, 0);
//        }
//    }];
    
    
    
    _currentIndex = currentIndex;
    
    if (_currentIndex == 0) {
        [self detailVC];
    } else if (_currentIndex == 1) {
        [self protocolVC];
    } else if (_currentIndex == 2) {
        [self groupVC];
    } else {
        [self detailVC];
        _currentIndex = 0;
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        if (_currentIndex >= 0 && _currentIndex < self.titles.count) {
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
        _mainScrollView.contentSize = CGSizeMake(self.titles.count * kSCREENW, 0);
        _mainScrollView.backgroundColor = rgba(249, 249, 249, 1);
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

#pragma mark - 创建子控制器
#pragma mark detailVC的创建
- (DSYCheckDetailController *)detailVC {
    if (self.titles.count < 1) {
        return nil;
    }
    if (!_detailVC) {
        _detailVC = [[DSYCheckDetailController alloc] initWithFinancing:self.financing];
        [self addChildViewController:_detailVC];
        _detailVC.view.frame = CGRectMake(0, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_detailVC.view];
        
    }
    return _detailVC;
}

#pragma mark protocolVC的创建
- (DSYServiceProtocolViewController *)protocolVC {
    if (self.titles.count < 2) {
        return nil;
    }
    if (!_protocolVC) {
        _protocolVC = [[DSYServiceProtocolViewController alloc] init];
        _protocolVC.model=_financing;
        [self addChildViewController:_protocolVC];
        _protocolVC.view.frame = CGRectMake(kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_protocolVC.view];
        
    }
    return _protocolVC;
}

#pragma mark groupVC的创建
- (DSYInvestGroupController *)groupVC {
    if (self.titles.count < 3) {
        return nil;
    }
    if (!_groupVC) {
        _groupVC = [[DSYInvestGroupController alloc] initWithFinancing:self.financing];
        [self addChildViewController:_groupVC];
        _groupVC.view.frame = CGRectMake(2 * kSCREENW, 0, kSCREENW, self.mainScrollView.height);
        [self.mainScrollView addSubview:_groupVC.view];
        
    }
    return _groupVC;
}

//#pragma mark assignVC的创建
//- (DSYFinancingAsiignDebtsController *)assignVC {
//    if (self.titles.count < 4) {
//        return nil;
//    }
//    if (!_assignVC) {
//        _assignVC = [[DSYFinancingAsiignDebtsController alloc] initWithFinancing:self.financing];
//        [self addChildViewController:_assignVC];
//        _assignVC.view.frame = CGRectMake(3 * kSCREENW, 0, kSCREENW, self.mainScrollView.height);
//        [self.mainScrollView addSubview:_assignVC.view];
//    }
//    return _assignVC;
//}



#pragma mark - maiScrollView的Delegate方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        NSInteger index = (NSInteger)(self.mainScrollView.contentOffset.x / self.mainScrollView.width);
        
        // 如果超过页面数量或小于0的时候默认选择为0
        if (index < 0 || index > self.titles.count) {
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
