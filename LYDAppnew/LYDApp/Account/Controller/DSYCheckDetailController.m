//
//  DSYCheckDetailController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYCheckDetailController.h"
#import "DSYFinancingCheckCell.h"
#import "DSYCheckModel.h"
#import "DSYFinancingModel.h"

#define kDSYPageSize 15

@interface DSYCheckDetailController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation DSYCheckDetailController

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
    self.view.backgroundColor = RGB(249, 249, 249);
    
    [self contentTableView];
    
    [self loadData];
}



- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataList;
}

- (void)loadData {
    self.pageIndex = 1;
//    [self.dataList removeAllObjects];
//    [self.contentTableView reloadData];
    NSString *url = [NSString stringWithFormat:@"%@/user/invests/%ld/bills", APIPREFIX, self.financing.investId];
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
    NSString *url = [NSString stringWithFormat:@"%@/user/invests/%ld/bills", APIPREFIX, self.financing.investId];
    NSDictionary *para = [self getMyParaWithIndex:self.pageIndex];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        // 错误处理方法
        self.pageIndex--;
        [self errorDealWithOperation:operation];
    }];
}


- (NSDictionary *)getMyParaWithIndex:(NSInteger)pageIndex {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"investId":@(self.financing.investId)};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"investId":@(self.financing.investId), @"sign":sign};
    
//    , @"investId":@(self.financing.investId)
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    [self.contentTableView.footer endRefreshing];
    [self.contentTableView.header endRefreshing];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        if (self.pageIndex == 1) {
            self.dataList = [DSYCheckModel baseModelByArr:data[@"billInvestList"]];
        } else {
            // 成功加载数据，当是加载更多的时候
            [self.dataList addObjectsFromArray:[DSYCheckModel baseModelByArr:data[@"billInvestList"]]];
        }
        if (self.dataList.count < kDSYPageSize) {
            [self.contentTableView.footer noticeNoMoreData];
            // 如果没有更多数据就让page恢复
            self.pageIndex --;
        }
        [self.contentTableView reloadData];
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

#pragma mark contentTableView的创建---------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.tableFooterView = [UIView new];
        _contentTableView.backgroundColor = self.view.backgroundColor;
        _contentTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _contentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _contentTableView;
}


#pragma mark - contentTableView的DataSource和Delegate
#pragma mark contentTableView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYFinancingCheckCell *cell = [DSYFinancingCheckCell cellForTableView:tableView];
    
    cell.check = self.dataList[indexPath.row];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return H(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *secHeaderVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, 44)];
    secHeaderVeiw.backgroundColor = self.contentTableView.backgroundColor;
    
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, secHeaderVeiw.width, secHeaderVeiw.height - 12)];
    [secHeaderVeiw addSubview:labelView];
    labelView.backgroundColor = RGB(239, 235, 231);
    
//    [self creatLabelsWithTitles:@[@"名称", @"回款金额(元)", @"回款日期", @"实际回款日期"] forSuperView:labelView];
    [self creatLabelsWithTitles:@[@"标的名称", @"回款金额(元)", @"回款日期"] forSuperView:labelView];
    
    
    return secHeaderVeiw;
}

#pragma mark contentTableView的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}




#pragma mark - 自定义方法

- (void)creatLabelsWithTitles:(NSArray *)titles forSuperView:(UIView *)superView {
    CGFloat width = superView.width / titles.count;
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(i * width, 0, width, superView.height) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
        showLabel.textAlignment=NSTextAlignmentCenter;
        [superView addSubview:showLabel];
        showLabel.text = title;
        showLabel.numberOfLines = 0;
        
        if (i == 0) {
            showLabel.textAlignment = NSTextAlignmentLeft;
            showLabel.x = X(10);
            showLabel.width = showLabel.width - X(10);
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
