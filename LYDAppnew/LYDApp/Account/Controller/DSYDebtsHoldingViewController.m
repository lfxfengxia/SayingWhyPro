//
//  DSYDebtsHoldingViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYDebtsHoldingViewController.h"
#import "DSYDebtsTableViewCell.h"

#import "DSYFinancingModel.h"

#import "DSYServiceProtocolViewController.h"
#import "DSYFinancingBillDetailController.h"

#import "DSYFinancingNewCell.h"

#import "DSYDebtsTransfers.h"

#define kDSYPageSize 15

@interface DSYDebtsHoldingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataList;           /**< 保存数据的数据 */
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation DSYDebtsHoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    
    [self setupUI];
    
    [self loadData];
    [self.queryBtn addTarget:self action:@selector(loadData) forControlEvents:(UIControlEventTouchUpInside)];
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
    self.contentTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.contentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadData {
    self.pageIndex = 1;
    NSString *url = [NSString stringWithFormat:@"%@/user/transfers/out", APIPREFIX];
    NSDictionary *para = [self getMyParaWithIndex:self.pageIndex];
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
        // 错误处理方法
        self.pageIndex--;
        [self errorDealWithOperation:operation];
    }];
}

- (void)loadMoreData {
    self.pageIndex++;
    NSString *url = [NSString stringWithFormat:@"%@/user/transfers/out", APIPREFIX];
    NSDictionary *para = [self getMyParaWithIndex:self.pageIndex];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        // 错误处理方法
        [self errorDealWithOperation:operation];
    }];
}


- (NSDictionary *)getMyParaWithIndex:(NSInteger)pageIndex {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"pageIndex":@(pageIndex), @"pageSize":@(kDSYPageSize),  @"startDate":self.startDate, @"endDate":self.endDate, @"status":@(3)};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"pageIndex":@(pageIndex), @"pageSize":@(kDSYPageSize),  @"startDate":self.startDate, @"endDate":self.endDate, @"status":@(3), @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    [self.contentTableView.footer endRefreshing];
    [self.contentTableView.header endRefreshing];
    NSInteger statusCode = [data[@"code"] integerValue];;
    NSLog(@"%@", data);
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        if (self.pageIndex == 1) {
            self.dataList = [DSYDebtsTransfers baseModelByArr:data[@"transferOutModelList"]];
        } else {
            // 成功加载数据，当是加载更多的时候
            [self.dataList addObjectsFromArray:[DSYDebtsTransfers baseModelByArr:data[@"transferOutModelList"]]];
        }
        if (self.dataList.count < kDSYPageSize) {
            [self.contentTableView.footer noticeNoMoreData];
            // 如果没有更多数据就让page恢复
            self.pageIndex --;
        }
        [self showTotalInvestAmount];
        [self.contentTableView reloadData];
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
        // 如果加载数据有问题就让page恢复
        self.pageIndex--;
    }
}

- (void)showTotalInvestAmount {
    CGFloat amount = 0;
    for (DSYDebtsTransfers *finace in self.dataList) {
        amount += finace.investAmount;
    }
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f", amount];
}

#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    [self.contentTableView.footer endRefreshing];
    [self.contentTableView.header endRefreshing];
    NSInteger errorData = operation.response.statusCode;
    NSLog(@"%zi",operation.response.statusCode);
    if (errorData == 401) {
        // 401错误处理
        [DSYUtils showResponseError_401_ForViewController:self];
    } else if (errorData == 404) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}

#pragma mark - contentTableView的Datasource和Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYFinancingNewCell *cell = [DSYFinancingNewCell cellForTableView:tableView];
    
    cell.transers = self.dataList[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return H(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *secHeaderVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, 56)];
    secHeaderVeiw.backgroundColor = self.contentTableView.backgroundColor;
    
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, secHeaderVeiw.width, secHeaderVeiw.height - 12)];
    [secHeaderVeiw addSubview:labelView];
    labelView.backgroundColor = RGB(239, 235, 231);
    
    [self creatLabelsWithTitles:@[@"标的名称", @"投资日期\n还款日期", @"投资本金\n(优惠券金额)", @"收益(元)"] forSuperView:labelView];
    
    return secHeaderVeiw;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYFinancingModel *financing = [[DSYFinancingModel alloc] init];
    DSYDebtsTransfers *tranfers = self.dataList[indexPath.row];
    financing.investId = tranfers.investId;
    
    DSYFinancingDetailController *detailVC = [[DSYFinancingDetailController alloc] initWithFinancing:financing];
    detailVC.titles = @[@"账单详情", @"服务协议", @"债权列表"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 自定义方法

- (void)creatLabelsWithTitles:(NSArray *)titles forSuperView:(UIView *)superView {
    CGFloat width = superView.width / titles.count;
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(i * width, 0, width, superView.height) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(13.0f)];
        [superView addSubview:showLabel];
        showLabel.text = title;
        showLabel.numberOfLines = 0;
        if (i == 2) {
            
            if ([title containsString:@"("] && [title containsString:@")"]) {
                showLabel.attributedText = [self getAttributeWithTitle:title];
            }
        }
        
    }
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
