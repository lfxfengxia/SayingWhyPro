
//
//  DSYFinancingBillDetailController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/7.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBillDetailController.h"
#import "DSYFinancingBillDetailTableCell.h"
#import "DSYFinancingModel.h"
#import "DSYFinancingBillDetailTableCell.h"
#import "DSYFinancingDebtsTableCell.h"

#define kDSYTextGrayColor_102 rgba(102, 102, 102, 1)
#define kDSYTextGrayColor_153 rgba(153, 153, 153, 1)
#define KDSYMargin_LR         X(15)   // 左右边距
#define kDSYThinFont          [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin]
#define kStartViewTag        3000

@interface DSYFinancingBillDetailController ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) UIView *headerView;          /**< tabView以上的头视图 */

@property (nonatomic, strong) UIView *noticeBgView;       /**< 提示信息的背景视图 */
@property (nonatomic, strong) UILabel *noticeLabel;       /**< 提示的信息 */

@property (nonatomic, strong) UIView *detailBgView;       /**< 账单详细背景视图 */

@property (nonatomic, strong) UIView *titleBgView;        /**< title的背景视图 */
@property (nonatomic, strong) UILabel *titleLabel;               /**< 账单的title */

@property (nonatomic, strong) UIView *firstBgView;        /**< 金额区域 */
@property (nonatomic, strong) UILabel *receiveingAmountLabel;    /**< 本期应收金额 */
@property (nonatomic, strong) UILabel *capitalAmountLabel;       /**< 投标本金 */
@property (nonatomic, strong) UILabel *receivedAmountLabel;      /**< 已收金额 */
@property (nonatomic, strong) UILabel *remainAmountLabel;        /**< 剩余应收款 */

@property (nonatomic, strong) UIView *secondBgView;       /**< 第二个区域 */
@property (nonatomic, strong) UILabel *deadLineDateLabel;        /**< 计划到期时间 */
@property (nonatomic, strong) UILabel *yearRateLabel;            /**< 年利率 */
@property (nonatomic, strong) UILabel *receivedTimesLabel;       /**< 已收的期数 */
@property (nonatomic, strong) UILabel *benefitMoneyLabel;        /**< 活动券金额 */

@property (nonatomic, strong) UIView *thirdBgView;        /**< 第三个区域 */
@property (nonatomic, strong) UILabel *returnMoneyWaysLabel;     /**< 还款方式 */
@property (nonatomic, strong) UILabel *totalMoneyLabel;          /**< 本息合计应收金额 */
@property (nonatomic, strong) UILabel *remaindTimesLabel;        /**< 剩余期数 */


@property (nonatomic, strong) UIView *tabbarView;         /**< tabbar视图 */
@property (nonatomic, strong) UIView *sliderView;         /**< 滑动条 */

@property (nonatomic, strong) UIScrollView *contentScrollView;   /**< 列表的承载视图 */
@property (nonatomic, strong) UITableView *backAmountTableView;  /**< 汇款情况 */
@property (nonatomic, strong) UITableView *debtsTableView;       /**< 债权列表 */


@property (nonatomic, assign) NSUInteger currentIndex;     /**< 当前选择的tabbar */

@property (nonatomic, strong) NSMutableArray *backDataList;  /**< 回款情况数据 */
@property (nonatomic, strong) NSMutableArray *debtsDataList; /**< 债权列表数据 */
@property (nonatomic, strong) NSMutableArray *showDataList;  /**< 需要显示的数据 */

@end

@implementation DSYFinancingBillDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"账单详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatUI];
    
    [self loadData];
    
    self.currentIndex = 100;
    self.currentIndex = 0;
}


- (void)loadData {
    self.receiveingAmountLabel.text = [NSString stringWithFormat:@"本期应收金额: %.2f元", 100.88];
    self.capitalAmountLabel.text    = [NSString stringWithFormat:@"投标本金: %.2f元", 100.00];
    self.receivedAmountLabel.text   = [NSString stringWithFormat:@"已收金额: %.2f元", 95.88];
    self.remainAmountLabel.text     = [NSString stringWithFormat:@"剩余应收款: %.2f元", 0.00];
    
    self.deadLineDateLabel.text     = [NSString stringWithFormat:@"计划到期时间: %@", @"2016-12-01"];
    self.yearRateLabel.text         = [NSString stringWithFormat:@"年利率: %.1f%%", 10.6];
    self.receivedTimesLabel.text    = [NSString stringWithFormat:@"已收期数: %d期", 1];
    self.benefitMoneyLabel.text     = [NSString stringWithFormat:@"活动券金额: %.2f元", 5.00];
    
    self.returnMoneyWaysLabel.text  = [NSString stringWithFormat:@"划款方式: %@", @"按月付息、到期还款"];
    self.totalMoneyLabel.text       = [NSString stringWithFormat:@"本息合计应收金额: %.2f元", 100.88];
    self.remaindTimesLabel.text     = [NSString stringWithFormat:@"剩余期数: %d期", 0];
}

- (void)creatUI {
//    [self mainScrollView];
    [self contentTableView];
    [self headerView];
    
    [self noticeBgView];
    [self noticeLabel];
    
    [self detailBgView];
    
    [self titleBgView];
    [self titleLabel];
    
    [self firstBgView];
    [self receiveingAmountLabel];
    [self capitalAmountLabel];
    [self receivedAmountLabel];
    [self remainAmountLabel];
    
    [self secondBgView];
    [self deadLineDateLabel];
    [self yearRateLabel];
    [self receivedTimesLabel];
    [self benefitMoneyLabel];
    
    [self thirdBgView];
    [self returnMoneyWaysLabel];
    [self totalMoneyLabel];
    [self remaindTimesLabel];
    
    [self tabbarView];
    
    //
}


- (void)setCurrentIndex:(NSUInteger)currentIndex {
    NSUInteger oldIndex = _currentIndex;
    if (_currentIndex != currentIndex) {
        _currentIndex = currentIndex;
        
        // topTabBar的宽度
        CGFloat tabbarWidth = self.tabbarView.width / 2;
        [UIView animateWithDuration:0.25 animations:^{
            self.sliderView.centerX =  tabbarWidth * (0.5 + _currentIndex);  // topTabbarWidth / 2 + topTabbarWidth * _selectIndex;
        } completion:^(BOOL finished) {
            // 修改原来的button的颜色
            UIButton *oldSelectBtn = [self.tabbarView viewWithTag:(oldIndex + kStartViewTag)];
            [oldSelectBtn setTitleColor:kDSYTextGrayColor_102 forState:(UIControlStateNormal)];
            // 修改现在的button的颜色
            UIButton *currentSelectBtn = [self.tabbarView viewWithTag:(_currentIndex + kStartViewTag)];
            [currentSelectBtn setTitleColor:ORANGECOLOR forState:(UIControlStateNormal)];
        }];
        
        if (_currentIndex == 0) {
            [self.contentTableView reloadData];
        } else if (_currentIndex == 1) {
            [self.contentTableView reloadData];
        }
        
    }
}

#pragma mark - property的getter方法(懒加载)
//#pragma mark mainScrollView的创建------------
//- (UIScrollView *)mainScrollView {
//    if (!_mainScrollView) {
//        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, self.view.height - 64)];
//        [self.view addSubview:_mainScrollView];
//        
//        _mainScrollView.backgroundColor = [UIColor redColor];
////        _mainScrollView.contentSize = CGSizeMake(kSCREENW, H(1000));
//    }
//    return _mainScrollView;
//}

#pragma mark contentTableView的创建------------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, self.view.height - 64) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.sectionHeaderHeight = H(64);
        
    }
    return _contentTableView;
}


#pragma mark headerView的创建------------
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(466))];
//        [self.mainScrollView addSubview:_headerView];
        self.contentTableView.tableHeaderView = _headerView;
        _headerView.backgroundColor = rgba(249, 249, 249, 1);
    }
    return _headerView;
}

#pragma mark noticeBgView的创建------------
- (UIView *)noticeBgView {
    if (!_noticeBgView) {
        CGFloat width = self.headerView.width;
        _noticeBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, H(73))];
        [self.headerView addSubview:_noticeBgView];
        _noticeBgView.backgroundColor = [UIColor whiteColor];
        
        // 添加两条灰色的线条
        [self creatSolidLineWithFrame:CGRectMake(0, 0, width, H(0.5)) toView:_noticeBgView];
        [self creatSolidLineWithFrame:CGRectMake(0, _noticeBgView.height - H(1), width, H(0.5)) toView:_noticeBgView];
    }
    return _noticeBgView;
}

#pragma mark noticeLabel的创建------------
- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KDSYMargin_LR, Y(10), self.noticeBgView.width  - 2 * KDSYMargin_LR, self.noticeBgView.height - Y(20))];
        [self.noticeBgView addSubview:_noticeLabel];
        _noticeLabel.font = DSY_NORMALFONT_13;
        _noticeLabel.textColor = kDSYTextGrayColor_153;
        _noticeLabel.numberOfLines = 0;
        NSString *text = @"感谢您使用零用贷安全网络平台理财服务，为确保您应收账准确，请您仔细阅读理财款账单明细信息。";
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:H(7.5)];//调整行间距
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        _noticeLabel.attributedText = attributedString;
    }
    return _noticeLabel;
}

#pragma mark detailBgView的创建------------
- (UIView *)detailBgView {
    if (!_detailBgView) {
        _detailBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.noticeBgView.maxY + Y(7), self.headerView.width, H(395))];
        [self.headerView addSubview:_detailBgView];
        _detailBgView.backgroundColor = [UIColor whiteColor];
    }
    return _detailBgView;
}

#pragma mark first的创建------------
- (UIView *)titleBgView {
    if (!_titleBgView) {
        _titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.detailBgView.width, H(45))];
        [self.detailBgView addSubview:_titleBgView];
        
        [self creatSolidLineWithFrame:CGRectMake(0, 0, _titleBgView.width, H(0.5)) toView:_titleBgView];
    }
    return _titleBgView;
}


#pragma mark titleLabel的创建------------
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KDSYMargin_LR, 0, self.titleBgView.width - 2 * KDSYMargin_LR, self.titleBgView.height)];
        [self.titleBgView addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:W(15.0f) weight:UIFontWeightSemibold];
        _titleLabel.textColor = kDSYTextGrayColor_102;
        _titleLabel.text = @"零定宝-一个月0339";
    }
    return _titleLabel;
}

#pragma mark firstBgView的创建------------
- (UIView *)firstBgView {
    if (!_firstBgView) {
        _firstBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleBgView.maxY, self.detailBgView.width, H(123))];
        [self.detailBgView addSubview:_firstBgView];
        
        [self creatSolidLineWithFrame:CGRectMake(0, 0, _firstBgView.width, H(0.5)) toView:_firstBgView];
    }
    return _firstBgView;
}

#pragma mark receiveingAmountLabel的创建------------
- (UILabel *)receiveingAmountLabel {
    if (!_receiveingAmountLabel) {
        _receiveingAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(KDSYMargin_LR, Y(11), self.firstBgView.width - 2 * KDSYMargin_LR, H(25))];
        [self.firstBgView addSubview:_receiveingAmountLabel];
        _receiveingAmountLabel.textColor = kDSYTextGrayColor_102;
        _receiveingAmountLabel.font = kDSYThinFont;
    }
    return _receiveingAmountLabel;
}

#pragma mark capitalAmountLabel的创建------------
- (UILabel *)capitalAmountLabel {
    if (!_capitalAmountLabel) {
        _capitalAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.receiveingAmountLabel.x, self.receiveingAmountLabel.maxY, self.receiveingAmountLabel.width, self.receiveingAmountLabel.height)];
        [self.firstBgView addSubview:_capitalAmountLabel];
        _capitalAmountLabel.textColor = kDSYTextGrayColor_102;
        _capitalAmountLabel.font = kDSYThinFont;
    }
    return _capitalAmountLabel;
}

#pragma mark receivedAmountLabel的创建------------
- (UILabel *)receivedAmountLabel {
    if (!_receivedAmountLabel) {
        _receivedAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.capitalAmountLabel.x, self.capitalAmountLabel.maxY, self.capitalAmountLabel.width, self.capitalAmountLabel.height)];
        [self.firstBgView addSubview:_receivedAmountLabel];
        _receivedAmountLabel.textColor = kDSYTextGrayColor_102;
        _receivedAmountLabel.font = kDSYThinFont;
    }
    return _receivedAmountLabel;
}

#pragma mark remainAmountLabel的创建------------
- (UILabel *)remainAmountLabel {
    if (!_remainAmountLabel) {
        _remainAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.receivedAmountLabel.x, self.receivedAmountLabel.maxY, self.receivedAmountLabel.width, self.receivedAmountLabel.height)];
        [self.firstBgView addSubview:_remainAmountLabel];
        _remainAmountLabel.textColor = kDSYTextGrayColor_102;
        _remainAmountLabel.font = kDSYThinFont;
    }
    return _remainAmountLabel;
}

#pragma mark secondBgView的创建------------
- (UIView *)secondBgView {
    if (!_secondBgView) {
        _secondBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.firstBgView.maxY, self.detailBgView.width, H(123))];
        [self.detailBgView addSubview:_secondBgView];
        
        [self creatSolidLineWithFrame:CGRectMake(0, 0, _secondBgView.width, H(0.5)) toView:_secondBgView];
    }
    return _secondBgView;
}

#pragma mark deadLineDateLabel的创建------------
- (UILabel *)deadLineDateLabel {
    if (!_deadLineDateLabel) {
        _deadLineDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KDSYMargin_LR, Y(11), self.secondBgView.width - 2 * KDSYMargin_LR, H(25))];
        [self.secondBgView addSubview:_deadLineDateLabel];
        _deadLineDateLabel.textColor = kDSYTextGrayColor_102;
        _deadLineDateLabel.font = kDSYThinFont;
    }
    return _deadLineDateLabel;
}

#pragma mark yearRateLabel的创建------------
- (UILabel *)yearRateLabel {
    if (!_yearRateLabel) {
        _yearRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.deadLineDateLabel.x, self.deadLineDateLabel.maxY, self.deadLineDateLabel.width, self.deadLineDateLabel.height)];
        [self.secondBgView addSubview:_yearRateLabel];
        _yearRateLabel.textColor = kDSYTextGrayColor_102;
        _yearRateLabel.font = kDSYThinFont;
    }
    return _yearRateLabel;
}

#pragma mark receivedTimesLabel的创建------------
- (UILabel *)receivedTimesLabel {
    if (!_receivedTimesLabel) {
        _receivedTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.yearRateLabel.x, self.yearRateLabel.maxY, self.yearRateLabel.width, self.yearRateLabel.height)];
        [self.secondBgView addSubview:_receivedTimesLabel];
        _receivedTimesLabel.textColor = kDSYTextGrayColor_102;
        _receivedTimesLabel.font = kDSYThinFont;
    }
    return _receivedTimesLabel;
}

#pragma mark benefitMoneyLabel的创建------------
- (UILabel *)benefitMoneyLabel {
    if (!_benefitMoneyLabel) {
        _benefitMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.receivedTimesLabel.x, self.receivedTimesLabel.maxY, self.receivedTimesLabel.width, self.receivedTimesLabel.height)];
        [self.secondBgView addSubview:_benefitMoneyLabel];
        _benefitMoneyLabel.textColor = kDSYTextGrayColor_102;
        _benefitMoneyLabel.font = kDSYThinFont;
    }
    return _benefitMoneyLabel;
}

#pragma mark thirdBgView的创建------------
- (UIView *)thirdBgView {
    if (!_thirdBgView) {
        _thirdBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.secondBgView.maxY, self.detailBgView.width, self.detailBgView.height - self.secondBgView.maxY)];
        [self.detailBgView addSubview:_thirdBgView];
        
        [self creatSolidLineWithFrame:CGRectMake(0, 0, _thirdBgView.width, H(0.5)) toView:_thirdBgView];
        [self creatSolidLineWithFrame:CGRectMake(0, _thirdBgView.height - H(0.5), _thirdBgView.width, H(0.5)) toView:_thirdBgView];
        
//        _thirdBgView.backgroundColor = [UIColor redColor];
    }
    return _thirdBgView;
}

#pragma mark returnMoneyWaysLabel的创建------------
- (UILabel *)returnMoneyWaysLabel {
    if (!_returnMoneyWaysLabel) {
        _returnMoneyWaysLabel = [[UILabel alloc] initWithFrame:CGRectMake(KDSYMargin_LR, Y(11), self.thirdBgView.width - 2 * KDSYMargin_LR, H(25))];
        [self.thirdBgView addSubview:_returnMoneyWaysLabel];
        _returnMoneyWaysLabel.textColor = kDSYTextGrayColor_102;
        _returnMoneyWaysLabel.font = kDSYThinFont;
    }
    return _returnMoneyWaysLabel;
}

#pragma mark totalMoneyLabel的创建------------
- (UILabel *)totalMoneyLabel {
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.returnMoneyWaysLabel.x, self.returnMoneyWaysLabel.maxY, self.returnMoneyWaysLabel.width, self.returnMoneyWaysLabel.height)];
        [self.thirdBgView addSubview:_totalMoneyLabel];
        _totalMoneyLabel.textColor = kDSYTextGrayColor_102;
        _totalMoneyLabel.font = kDSYThinFont;
    }
    return _totalMoneyLabel;
}

#pragma mark remaindTimesLabel的创建------------
- (UILabel *)remaindTimesLabel {
    if (!_remaindTimesLabel) {
        _remaindTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.totalMoneyLabel.x, self.totalMoneyLabel.maxY, self.totalMoneyLabel.width, self.totalMoneyLabel.height)];
        [self.thirdBgView addSubview:_remaindTimesLabel];
        
        _remaindTimesLabel.textColor = kDSYTextGrayColor_102;
        _remaindTimesLabel.font = kDSYThinFont;
    }
    return _remaindTimesLabel;
}

#pragma mark tabbarView的创建------------
- (UIView *)tabbarView {
    if (!_tabbarView) {
//        _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.detailBgView.maxY + Y(10), self.headerView.width, self.headerView.height - self.detailBgView.maxY - Y(20))];
//        [self.headerView addSubview:_tabbarView];
        _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, Y(10), kSCREENW, H(44))];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        // 创建
        [self creatTitleWithTitles:@[@"回款情况", @"债权列表"]];
        
        self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, _tabbarView.height - H(1), _tabbarView.width / 2, H(1))];
        [_tabbarView addSubview:self.sliderView];
        self.sliderView.backgroundColor = ORANGECOLOR;
    }
    return _tabbarView;
}


#pragma mark solidLine的创建
- (void)creatSolidLineWithFrame:(CGRect)frame toView:(UIView *)superView {
    UIView *solidLine = [[UIView alloc] initWithFrame:frame];
    solidLine.backgroundColor = rgba(235, 235, 235, 1);
    
    [superView addSubview:solidLine];
}

#pragma mark 创建tabbarView上的两个tabbar卡
- (void)creatTitleWithTitles:(NSArray *)titles {
    for (int i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        CGFloat width = self.tabbarView.width / 2;
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.tabbarView addSubview:button];
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setTitleColor:kDSYTextGrayColor_102 forState:(UIControlStateNormal)];
        button.frame = CGRectMake(i * width, 0, width, self.tabbarView.height);
        button.tag = kStartViewTag + i;
        button.titleLabel.font = DSY_NORMALFONT_14;
        
        [button addTarget:self action:@selector(selectList:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}


#pragma mark - contentTableView的Datasource和Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *ID = @"tableviewCell";
    if (self.currentIndex == 0) {
        DSYFinancingBillDetailTableCell *cell = [DSYFinancingBillDetailTableCell cellForTableView:tableView];
        
        cell.model = [[DSYFinancingModel alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else {
        DSYFinancingDebtsTableCell *cell = [DSYFinancingDebtsTableCell cellForTableView:tableView];
        
        cell.model = [[DSYFinancingModel alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}
     
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentIndex == 0) {
        return 5;
    } else if (self.currentIndex == 1) {
        return 5;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == 0) {
        return H(180);
    }
    return H(150);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, H(64))];
    bg.backgroundColor = rgba(249, 249, 249, 1);
    [bg addSubview:self.tabbarView];
    self.tabbarView.center = bg.center;
    return bg;
}


#pragma mark - 自定义方法

- (void)selectList:(UIButton *)button {
    NSUInteger buttonTag = button.tag - kStartViewTag;
    if (buttonTag == 1 || buttonTag == 0) {
        self.currentIndex = buttonTag;
    }
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
