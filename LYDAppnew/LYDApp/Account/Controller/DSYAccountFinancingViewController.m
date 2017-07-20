//
//  DSYAccountFinancingViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/5.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountFinancingViewController.h"
#import "DSYFinancingAllController.h"
#import "DSYFinancingHoldingController.h"
#import "DSYFinancingCompleteController.h"
#import "DSYFinancingTranferingController.h"
#import "DSYFinancingTranferedController.h"

#define kDSYTextColorGray_102     rgba(102, 102, 102, 1)
#define kAccountFinancingStartTag 4000
@interface DSYAccountFinancingViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, assign) NSInteger selectIndex;         /**< 当前选择的页面  */

@property (nonatomic, strong) UIScrollView *mainScrollView;  /**< 主要内容区域 */
@property (nonatomic, strong) UIImageView *topTabbarView;         /**< 顶部Tabbar的背景视图 */
@property (nonatomic, strong) UIView *sliderView;            /**< 滑动条 */


//@property (nonatomic, strong) DSYFinancingAllController *allVC;                /**< 全部的的页面 */
@property (nonatomic, strong) DSYFinancingHoldingController *holdingVC;        /**< 持有中的页面 */
@property (nonatomic, strong) DSYFinancingCompleteController *completeVC;      /**< 已完成的页面 */
//@property (nonatomic, strong) DSYFinancingTranferingController *tranferingVC;  /**< 转让中的页面 */
//@property (nonatomic, strong) DSYFinancingTranferedController *tranferedVC;    /**< 已转让的页面 */


@end

@implementation DSYAccountFinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"零定宝";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    
    
    [self creatUI];
    
    // 默认选择
    self.selectIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)creatUI {
    [self topTabbarView];
    // 创建tabbar
    [self creatTabbars];
    [self sliderView];
    
    [self mainScrollView];
    // 默认第一个页面
//    [self allVC];
    
    
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
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    NSInteger oldSelectIndex = _selectIndex;
    _selectIndex = selectIndex;
    
    // topTabBar的宽度
    CGFloat topTabbarWidth = self.topTabbarView.width / 2;
    [UIView animateWithDuration:0.25 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(_selectIndex * kSCREENW, 0);
        self.sliderView.centerX =  topTabbarWidth * (0.5 + _selectIndex);  // topTabbarWidth / 2 + topTabbarWidth * _selectIndex;
    } completion:^(BOOL finished) {
        // 修改原来的button的颜色
        UIButton *oldSelectBtn = [self.topTabbarView viewWithTag:(oldSelectIndex + kAccountFinancingStartTag)];
        [oldSelectBtn setTitleColor:kDSYTextColorGray_102 forState:(UIControlStateNormal)];
        // 修改现在的button的颜色
        UIButton *currentSelectBtn = [self.topTabbarView viewWithTag:(_selectIndex + kAccountFinancingStartTag)];
        [currentSelectBtn setTitleColor:ORANGECOLOR forState:(UIControlStateNormal)];
    }];
    
    if (_selectIndex == 0) {
//        [self allVC];
        [self holdingVC];
    } else if (_selectIndex == 1) {
        [self completeVC];
        if (self.completeRefresh == YES) {
            [self.completeVC refreshMyData];
            self.completeRefresh = NO;
        }
    } else {
//        [self allVC];
        [self holdingVC];
        _selectIndex = 0;
    }
    
//    if (_selectIndex == 4) {
//        self.mainScrollView.bounces = NO;
//    } else {
//        self.mainScrollView.bounces = YES;
//    }
    
//    switch (_selectIndex) {
//        case 0:
//            [self allVC];
//            break;
//        case 1:
//            [self holdingVC];
//            break;
//        case 2:
//            [self completeVC];
//            break;
//        case 3:
//            [self tranferingVC];
//            break;
//        case 4:
//            [self tranferedVC];
//            
//        default: [self allVC];
//            break;
//    }
    
}

#pragma mark - property的getter方法(懒加载)
#pragma mark topTabbarView的创建
- (UIImageView *)topTabbarView {
    if (!_topTabbarView) {
        _topTabbarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, H(45))];
        [self.view addSubview:_topTabbarView];
        
//        _topTabbarView.image = [UIImage stretchedImageWithImage:DSYImage(@"account_financing_topbar_bg.png")];
        _topTabbarView.image = DSYImage(@"account_financing_topbar_bg.png");
        _topTabbarView.userInteractionEnabled = YES;
    }
    return _topTabbarView;
}

#pragma mark sliderView的创建
- (UIView *)sliderView {
    if (!_sliderView) {
        CGFloat sliderHeight = H(2);
        _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topTabbarView.height - sliderHeight, W(44), sliderHeight)];
        _sliderView.centerX = self.topTabbarView.width / 5 / 2;
        [self.topTabbarView addSubview:_sliderView];
        _sliderView.backgroundColor = ORANGECOLOR;
    }
    return _sliderView;
}

#pragma mark mainScrollView的创建
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topTabbarView.maxY, kSCREENW, self.view.height - self.topTabbarView.maxY)];
        [self.view addSubview:_mainScrollView];
        _mainScrollView.contentSize = CGSizeMake(2 * kSCREENW, 0);
        _mainScrollView.backgroundColor = rgba(249, 249, 249, 1);
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
//        _mainScrollView.bounces = NO;

        
//        _mainScrollView.panGestureRecognizer.requireGestureRecognizerToFail(self.navigationController.interactivePopGestureRecognizer);
    
    }
    return _mainScrollView;
}

#pragma mark - 创建子控制器
#pragma mark holdingVC的创建
- (DSYFinancingHoldingController *)holdingVC {
    if (!_holdingVC) {
        _holdingVC = [[DSYFinancingHoldingController alloc] init];
        _holdingVC.bidType=self.bidType;
        [self addChildViewController:_holdingVC];
        _holdingVC.view.frame = CGRectMake(0, 0, self.mainScrollView.width, self.mainScrollView.height);
        [self.mainScrollView addSubview:_holdingVC.view];
    }
    return _holdingVC;
}
#pragma mark completeVC的创建
- (DSYFinancingCompleteController *)completeVC {
    if (!_completeVC) {
        _completeVC = [[DSYFinancingCompleteController alloc] init];
        _completeVC.bidType=self.bidType;
        [self addChildViewController:_completeVC];
        _completeVC.view.frame = CGRectMake(self.mainScrollView.width, 0, self.mainScrollView.width, self.mainScrollView.height);
        [self.mainScrollView addSubview:_completeVC.view];
    }
    return _completeVC;
}



#pragma mark 创建tabbar
- (void)creatTabbars {
    NSArray *titleArr = @[@"持有中", @"已完成"];
    CGFloat width = self.topTabbarView.width / titleArr.count;
    CGFloat height = self.topTabbarView.height;
    for (int i = 0; i < titleArr.count; i++) {
        NSString *title = titleArr[i];
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.topTabbarView addSubview:button];
        button.frame = CGRectMake(i * width, 0, width, height);
        button.tag = kAccountFinancingStartTag + i;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:kDSYTextColorGray_102 forState:(UIControlStateNormal)];
        [button setTitle:title forState:(UIControlStateNormal)];
        
        [button addTarget:self action:@selector(topTabbarClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}


#pragma mark - maiScrollView的Delegate方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        NSInteger index = (NSInteger)(self.mainScrollView.contentOffset.x / self.mainScrollView.width);
        
        // 如果超过页面数量或小于0的时候默认选择为0
        if (index < 0 && index > 2) {
            self.selectIndex = 0;
        } else {
            self.selectIndex = index;
        }
        
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%f", self.mainScrollView.contentOffset.x);
    if (self.mainScrollView.contentOffset.x < 0) {
//        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - topTabBar的点击方法
- (void)topTabbarClick:(UIButton *)button {
    self.selectIndex = button.tag - kAccountFinancingStartTag;
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

-(void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
    //
    
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
