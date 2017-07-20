//
//  XYJoinRecordController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/28.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYJoinRecordController.h"

#import "XYJoinRecordModel.h"
#import "XYRecordCell.h"

@interface XYJoinRecordController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *recordTableView;
@property (nonatomic, copy) NSMutableArray  *recordsArr;
@property (nonatomic, assign) NSInteger     recordPage;

@end

@implementation XYJoinRecordController

- (NSMutableArray *)recordsArr
{
    if (!_recordsArr) {
        _recordsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _recordsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"购买记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    self.recordPage = 1;
    [self createRecordTabelView];
    
    
    if ([self.type isEqualToString:@"理财计划"]) {
        [MBProgressHUD showMessage:@"正在加载" toView:self.view];
        [self loadPlansRecordData];
    } else if ([self.type isEqualToString:@"散标"]) {
        [MBProgressHUD showMessage:@"正在加载" toView:self.view];
        [self loadSanBidRecordData];
    } else if ([self.type isEqualToString:@"债权转让"]) {
        [MBProgressHUD showMessage:@"正在加载" toView:self.view];
        [self loadTransferRecordData];
    } else {
        [MBProgressHUD showMessage:@"正在加载" toView:self.view];
        [self loadExprienceRecordData];
    }
    
    
}


#pragma mark - 加载理财计划标的的购买记录
- (void)loadPlansRecordData
{

    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"bidType":self.model.bidType,@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.recordPage],@"pageSize":[NSNumber numberWithInteger:10],@"planId":self.planId};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"bidType":self.model.bidType,@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.recordPage],@"pageSize":[NSNumber numberWithInteger:10],@"planId":self.planId,@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@/invests",APIPREFIX,self.planId] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.recordTableView.header endRefreshing];
        [self.recordTableView.footer endRefreshing];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.recordPage == 1) {
                [self.recordsArr removeAllObjects];
            }
            
            
            if ([[backData valueForKey:@"investList"] count] == 0) {
                [self.recordTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"investList"]) {
                    XYJoinRecordModel *model = [[XYJoinRecordModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.recordsArr addObject:model];
                }
                
                if (self.recordsArr.count < 10) {
                    [self.recordTableView.footer noticeNoMoreData];
                }
                
                [self.recordTableView reloadData];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.recordTableView.header endRefreshing];
        [self.recordTableView.footer endRefreshing];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else if ([[response valueForKey:@"code"] integerValue] == 404) {
            [DSYUtils showResponseError_404_ForViewController:self message:@"理财计划未找到" okHandler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } cancelHandler:^(UIAlertAction *action) {
            }];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
    
}

#pragma mark - 加载散标的数据
- (void)loadSanBidRecordData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.recordPage],@"pageSize":[NSNumber numberWithInteger:10],@"bidId":self.planId};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.recordPage],@"pageSize":[NSNumber numberWithInteger:10],@"planId":self.planId,@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/bids/%@/invests",APIPREFIX,self.planId] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.recordTableView.header endRefreshing];
        [self.recordTableView.footer endRefreshing];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.recordPage == 1) {
                [self.recordsArr removeAllObjects];
            }
            
            if ([[backData valueForKey:@"investList"] count] == 0) {
                [self.recordTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"investList"]) {
                    XYJoinRecordModel *model = [[XYJoinRecordModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.recordsArr addObject:model];
                }

                if (self.recordsArr.count < 10) {
                    [self.recordTableView.footer noticeNoMoreData];
                }
                
                [self.recordTableView reloadData];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
            
        } else {

            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.recordTableView.header endRefreshing];
        [self.recordTableView.footer endRefreshing];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else if ([[response valueForKey:@"code"] integerValue] == 404) {
            
            [DSYUtils showResponseError_404_ForViewController:self message:@"理财计划未找到" okHandler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } cancelHandler:^(UIAlertAction *action) {
                
            }];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
}

#pragma mark - 加载债权转让的购买记录
- (void)loadTransferRecordData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"transferId":self.planId};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"transferId":self.planId,@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/transfers/%@/invest",APIPREFIX,self.planId] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.recordTableView.header endRefreshing];
        [self.recordTableView.footer endRefreshing];
        
        if (self.recordPage == 1) {
            [self.recordsArr removeAllObjects];
        }
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData allKeys] count] == 0) {
            [self.recordTableView.footer noticeNoMoreData];
        } else {

                XYJoinRecordModel *model = [[XYJoinRecordModel alloc] init];
                [model setValuesForKeysWithDictionary:[backData valueForKey:@"investModel"]];
                [self.recordsArr addObject:model];
            
            if (self.recordsArr.count < 10) {
                [self.recordTableView.footer noticeNoMoreData];
            }
            
            [self.recordTableView reloadData];
        }
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.recordTableView.header endRefreshing];
        [self.recordTableView.footer endRefreshing];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:@"账号在其他设备登录,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self pushToLoginController];
                
            }];
            [alertVC addAction:alertAC];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        } else if ([[response valueForKey:@"code"] integerValue] == 404) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:@"理财计划未找到" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }];
            [alertVC addAction:alertAC];
            [self presentViewController:alertVC animated:YES completion:nil];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
}

#pragma mark - 加载体验标购买记录
- (void)loadExprienceRecordData {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"bidId":self.planId,@"pageIndex":[NSNumber numberWithInteger:self.recordPage],@"pageSize":[NSNumber numberWithInteger:10]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"bidId":self.planId,@"pageIndex":[NSNumber numberWithInteger:self.recordPage],@"pageSize":[NSNumber numberWithInteger:10],@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/bidsNews/%@/investList",APIPREFIX,self.planId] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.recordTableView.header endRefreshing];
        [self.recordTableView.footer endRefreshing];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.recordPage == 1) {
                [self.recordsArr removeAllObjects];
            }
            
            if ([[backData valueForKey:@"investModelList"] count] == 0) {
                [self.recordTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"investModelList"]) {
                    XYJoinRecordModel *model = [[XYJoinRecordModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.recordsArr addObject:model];
                }
                
                if (self.recordsArr.count < 10) {
                    [self.recordTableView.footer noticeNoMoreData];
                }
                
                [self.recordTableView reloadData];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
            
        } else {
            
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.recordTableView.header endRefreshing];
        [self.recordTableView.footer endRefreshing];
        
        NSInteger statusCode = operation.response.statusCode;

        if (statusCode == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else if (statusCode == 404) {
            
            [DSYUtils showResponseError_404_ForViewController:self message:@"理财计划未找到" okHandler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } cancelHandler:^(UIAlertAction *action) {
                
            }];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
}



- (void)createRecordTabelView
{
    self.recordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH - 64) style:UITableViewStylePlain];
    self.recordTableView.tableFooterView = [[UIView alloc] init];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    
    self.recordTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.recordPage = 1;
        if ([self.type isEqualToString:@"理财计划"]) {
            [self loadPlansRecordData];
        } else if ([self.type isEqualToString:@"散标"]) {
            [self loadSanBidRecordData];
        } else if ([self.type isEqualToString:@"债权转让"]) {
            [self loadTransferRecordData];
        } else {
            // 体验标购买记录加载
            [self loadExprienceRecordData];
        }
        
        
    }];
    
    self.recordTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.recordPage += 1;
        if ([self.type isEqualToString:@"理财计划"]) {
            [self loadPlansRecordData];
        } else if ([self.type isEqualToString:@"散标"]) {
            [self loadSanBidRecordData];
        } else if ([self.type isEqualToString:@"债权转让"]) {
            [self loadTransferRecordData];
        } else {
            // 体验标购买记录加载
            [self loadExprienceRecordData];
        }
        
    }];

    
    [self.view addSubview:self.recordTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYRecordCell *cell = [XYRecordCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.recordsArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return [XYRecordCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return KHeight(35);
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(35))];
    headV.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    
    UILabel *phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(0, KHeight(12), kSCREENW / 4, KHeight(10))];
    phoneLable.font = [UIFont systemFontOfSize:KHeight(12)];
    phoneLable.textAlignment = NSTextAlignmentCenter;
    phoneLable.textColor = TEXTBLACK;
    phoneLable.text = @"投资人";
    [headV addSubview:phoneLable];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENW / 4, KHeight(12), kSCREENW / 4, KHeight(10))];
    moneyLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = TEXTBLACK;
    moneyLabel.text = @"投资金额";
    [headV addSubview:moneyLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREENW / 4) * 2, KHeight(12), kSCREENW / 4, KHeight(10))];
    timeLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = TEXTBLACK;
    timeLabel.text = @"投资时间";
    [headV addSubview:timeLabel];
    
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREENW / 4) * 3, KHeight(12), kSCREENW / 4, KHeight(10))];
    sourceLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    sourceLabel.textAlignment = NSTextAlignmentCenter;
    sourceLabel.textColor = TEXTBLACK;
    sourceLabel.text = @"投资来源";
    [headV addSubview:sourceLabel];
    
    return headV;
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
