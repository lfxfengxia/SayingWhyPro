//
//  RBNewHandAreaViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBNewHandAreaViewController.h"
#import "RBNewHandAreaCell.h"
#import "DSYNewInvesting.h"
#import "DSYFinancingDetailController.h"
#import "DSYFinancingModel.h"

#define kDSYPageSize 15
@interface RBNewHandAreaViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *capitalLabel;
@property (nonatomic, strong) UILabel *profitLabel;
@property (nonatomic, strong) UILabel *statuLabel;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation RBNewHandAreaViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"新手专区";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageIndex = 1;
    
    [self createUI];
    
    [self loadData];
}

- (void)loadData {
    self.pageIndex = 1;
    [self.dataArray removeAllObjects];
    NSString *url = [NSString stringWithFormat:@"%@/user/investNews", APIPREFIX];
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
        [self errorDealWithOperation:operation];
    }];
}

- (void)loadMoreData {
    self.pageIndex++;
    NSString *url = [NSString stringWithFormat:@"%@/user/investNews", APIPREFIX];
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
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"pageIndex":@(pageIndex), @"pageSize":@(kDSYPageSize)};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"pageIndex":@(pageIndex), @"pageSize":@(kDSYPageSize), @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    [self.tableView.footer endRefreshing];
    [self.tableView.header endRefreshing];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        if (self.pageIndex == 1) {
            self.dataArray = [DSYNewInvesting baseModelByArr:data[@"investNewModelList"]];
        } else {
            // 成功加载数据，当是加载更多的时候
            [self.dataArray addObjectsFromArray:[DSYNewInvesting baseModelByArr:data[@"investNewModelList"]]];
        }
        if (self.dataArray.count < kDSYPageSize) {
            [self.tableView.footer noticeNoMoreData];
            // 如果没有更多数据就让page恢复
            self.pageIndex --;
        }
        [self.tableView reloadData];
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
        // 如果加载数据有问题就让page恢复
        self.pageIndex--;
    }
}

#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    [self.tableView.footer endRefreshing];
    [self.tableView.header endRefreshing];
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


- (void)createUI {
//    [self.dataArray addObjectsFromArray:@[@"1", @"2", @"4"]];
    NSLog(@"%f %f %f %f", self.navigationController.navigationBar.frame.size.height, [UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.origin.y, NavMaxY);
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, NavMaxY, kSCREENW, 40)];
    _headerView.backgroundColor= RGB(239, 235, 231);

    
    
    
    [self.view addSubview:_headerView];
    
    _nameLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, 0, kSCREENW/4.0, _headerView.height) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(13.0f)];
    _nameLabel.text = @"标的名称";
    [_headerView addSubview:_nameLabel];
    
    _capitalLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(kSCREENW/4.0, 0, kSCREENW/4.0, _headerView.height) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(13.0f)];
    _capitalLabel.text = @"投资本金(元)";
    [_headerView addSubview:_capitalLabel];
    
    _profitLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(2*kSCREENW/4.0, 0, kSCREENW/4.0, _headerView.height) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(13.0f)];
    _profitLabel.text = @"收益(元)";
    [_headerView addSubview:_profitLabel];
    
    _statuLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(3*kSCREENW/4.0, 0, kSCREENW/4.0, _headerView.height) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(13.0f)];
    _statuLabel.text = @"状态";
    [_headerView addSubview:_statuLabel];
    
    UIView *lineView = [RYFactoryMethod initWithLineViewFrame:CGRectMake(0, _headerView.height - 1, kSCREENW, 1)];
    [_headerView addSubview:lineView];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavMaxY + 40, kSCREENW, kSCREENH-NavMaxY-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = LIGHTGRAYTEXT;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.view addSubview:_tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBNewHandAreaCell *cell = [RBNewHandAreaCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.invest = self.dataArray[indexPath.row];
    cell.block = ^(NSIndexPath *index) {
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYNewInvesting *invest = self.dataArray[indexPath.row];
    if (invest.type==2) {

        DSYFinancingModel *financing = [[DSYFinancingModel alloc] init];
        financing.investId = invest.investId;
        
        
        DSYFinancingDetailController *detailVC = [[DSYFinancingDetailController alloc] initWithFinancing:financing];
        detailVC.titles = @[@"账单详情", @"服务协议", @"债权列表"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

@end
