//
//  DSYDivergenceAssigningController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//  散标下的转让中

#import "DSYDivergenceAssigningController.h"
#import "DSYDivergenceCompleteCell.h"

#import "DSYFinancingModel.h"

#import "DSYServiceProtocolViewController.h"
#import "DSYFinancingBillDetailController.h"
#import "DSYFinancingInvestmentsController.h"
#import "DSYAccountCommenController.h"

@interface DSYDivergenceAssigningController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataList;           /**< 保存数据的数据 */

@end

@implementation DSYDivergenceAssigningController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    
    [self setupUI];
    
    [self loadData];
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataList;
}


- (void)setupUI {
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData {
    DSYFinancingModel *financing = [[DSYFinancingModel alloc] init];
    financing.title = @"一个月0356";
    financing.financeingStatus = 2;
    financing.investMoney = 100.00;
    financing.countPanMoney = 50.00;
    financing.incomeMoney = 150.00;
    financing.time = 142582563625;
    
    DSYFinancingModel *financing1 = [[DSYFinancingModel alloc] init];
    financing1.title = @"一个月0356";
    financing1.financeingStatus = 2;
    financing1.investMoney = 100.00;
    financing1.countPanMoney = 50.00;
    financing1.incomeMoney = 150.00;
    financing1.time = 142582563625;
    
    DSYFinancingModel *financing2 = [[DSYFinancingModel alloc] init];
    financing2.title = @"一个月0356";
    financing2.financeingStatus = 2;
    financing2.investMoney = 100.00;
    financing2.countPanMoney = 50.00;
    financing2.incomeMoney = 150.00;
    financing2.time = 142582563625;
    
    [self.dataList addObject:financing];
    [self.dataList addObject:financing1];
    [self.dataList addObject:financing2];
    
    [self.contentTableView reloadData];
}

#pragma mark - contentTableView的Datasource和Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYDivergenceCompleteCell *cell = [DSYDivergenceCompleteCell cellForTableView:tableView];
    
    cell.financing = self.dataList[indexPath.row];
    cell.currentIndex = indexPath;
    cell.block = ^(NSIndexPath *index, DSYFinancingCellButtonClickType type) {
        if (type == DSYFinancingCellButtonClickTypeServerBook) {
            // 服务协议按钮
            DSYServiceProtocolViewController *protocolVC = [[DSYServiceProtocolViewController alloc] init];
            [self.navigationController pushViewController:protocolVC animated:YES];
        } else if (type == DSYFinancingCellButtonClickTypeDetail) {
            // 账单详情
            DSYFinancingBillDetailController *detailVC = [[DSYFinancingBillDetailController alloc] init];
            [self.navigationController pushViewController:detailVC animated:YES];
        } else if (type == DSYFinancingCellButtonClickTypeCommen) {
            // 客户评语
            DSYAccountCommenController *feedBackVC = [[DSYAccountCommenController alloc] init];
            [self.parentViewController.navigationController pushViewController:feedBackVC animated:YES];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return H(270);
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
