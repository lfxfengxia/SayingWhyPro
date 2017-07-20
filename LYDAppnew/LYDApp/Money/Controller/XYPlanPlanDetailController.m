//
//  XYPlanPlanDetailController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/28.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYPlanPlanDetailController.h"

#import "XYPlanDetailCell.h"
#import "XYPlanDetailModel.h"
#import "DSYCouponModel.h"

@interface XYPlanPlanDetailController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *planDetailTableView;
@property (nonatomic, copy) NSMutableArray  *planDetailsArr;
@property (nonatomic, assign) NSInteger     planDetailPage;

@end

@implementation XYPlanPlanDetailController

- (NSMutableArray *)planDetailsArr
{
    if (!_planDetailsArr) {
        _planDetailsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _planDetailsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"项目详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    self.planDetailPage = 1;
    [self createPlanDetailTableView];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [self loadPlanDetailData];
    
}

- (void)loadPlanDetailData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planDetailPage],@"pageSize":[NSNumber numberWithInteger:10],@"planId":self.planId};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planDetailPage],@"pageSize":[NSNumber numberWithInteger:10],@"planId":self.planId,@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@/loans",APIPREFIX,self.planId] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        [self.planDetailTableView.header endRefreshing];
        [self.planDetailTableView.footer endRefreshing];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.planDetailPage == 1) {
                [self.planDetailsArr removeAllObjects];
            }
            
            if ([[backData valueForKey:@"loanList"] count] == 0) {
                [self.planDetailTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"loanList"]) {
                    XYPlanDetailModel *model = [[XYPlanDetailModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.planDetailsArr addObject:model];
                }
                
                [self.planDetailTableView.header endRefreshing];
                [self.planDetailTableView.footer endRefreshing];
                
                if (self.planDetailsArr.count < 10) {
                    [self.planDetailTableView.footer noticeNoMoreData];
                }
                
                [self.planDetailTableView reloadData];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [self.planDetailTableView.header endRefreshing];
            [self.planDetailTableView.footer endRefreshing];
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [self.planDetailTableView.header endRefreshing];
            [self.planDetailTableView.footer endRefreshing];
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            
        }

    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.planDetailTableView.header endRefreshing];
        [self.planDetailTableView.footer endRefreshing];
        
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

- (void)createPlanDetailTableView
{
    self.planDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH - 64) style:UITableViewStyleGrouped];
    self.planDetailTableView.delegate = self;
    self.planDetailTableView.dataSource = self;
    
    self.planDetailTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.planDetailPage = 1;
        [self loadPlanDetailData];
    }];
    
    self.planDetailTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.planDetailPage += 1;
        [self loadPlanDetailData];
    }];
    [self.view addSubview:self.planDetailTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.planDetailsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYPlanDetailCell *cell = [XYPlanDetailCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.planDetailsArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XYPlanDetailCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KHeight(44);
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
    UIView *labelV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(44))];
    labelV.backgroundColor = [UIColor whiteColor];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(12), KHeight(13), kSCREENW - KWidth(12) * 2, KHeight(12))];
    hintLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    hintLabel.textColor = TEXTBLACK;
    hintLabel.text = @"*以下仅展示部分债权信息";
    [labelV addSubview:hintLabel];
    return labelV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
