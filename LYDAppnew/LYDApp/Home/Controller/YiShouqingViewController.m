//
//  YiShouqingViewController.m
//  LYDApp
//
//  Created by fcl on 2017/6/21.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "YiShouqingViewController.h"
#import "XYPlanModel.h"
#import "XYHomeLDBShouQingCell.h"
#import "YiYueBiaoShouQingViewController.h"


@interface YiShouqingViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView   *planTableView;
@property (nonatomic, assign) NSInteger     planPageNum;
@property (nonatomic, copy) NSMutableArray  *plansArr;
@property (nonatomic, copy) NSDictionary  *gongxiangDic;

@end

@implementation YiShouqingViewController

- (NSMutableArray *)plansArr
{
    if (!_plansArr) {
        _plansArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _plansArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigaTitle = @"已售罄-1月标";
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    self.planPageNum = 1;
    [self createUI];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        [self loadPlanData];
       
    }];
}


#pragma mark - 网络加载数据----------------------
#pragma mark  加载理财的数据--------------
- (void)loadPlanData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:15]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:15],@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plansFinish",APIPREFIX] parameters:para success:^(id data) {
        [self.planTableView.header endRefreshing];
        [self.planTableView.footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        //bidType   1零定宝
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.planPageNum == 1) {
                [self.plansArr removeAllObjects];
            }
            if ([[backData valueForKey:@"planList"] count] == 0) {
                [self.planTableView.footer noticeNoMoreData];
                [self.planTableView.header endRefreshing];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"planList"]) {
                    XYPlanModel *model = [[XYPlanModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.plansArr addObject:model];
                }
                
                if (self.plansArr.count < 10) {
                    [self.planTableView.footer noticeNoMoreData];
                }
                [self.planTableView reloadData];
            }
            
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorDataHandleWithOperation:operation];
    }];
    
    
}

- (NSMutableAttributedString *)showAttributedTextWithText:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(18)] range:NSMakeRange(attributeStr.length - 1, 1)];
    return attributeStr;
}

#pragma mark 网络错误的处理方法
- (void)errorDataHandleWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];

    
    id response = LYDJSONSerialization(operation.responseObject);
    NSLog(@"%@",response);
    if ([[response valueForKey:@"code"] integerValue] == 401) {
        [DSYUtils showResponseError_401_ForViewController:self];
        
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}


#pragma mark - UI的创建-----------------------
- (void)createUI
{
    [self createPlanTableView];
}

- (void)createPlanTableView
{

    
    self.planTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kSCREENW, self.view.height) style:UITableViewStyleGrouped];
    self.planTableView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.planTableView.delegate = self;
    self.planTableView.dataSource = self;
    self.planTableView.separatorColor=[UIColor clearColor];
    self.planTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.planPageNum = 1;
        [self loadPlanData];
    }];
    
    self.planTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.planPageNum += 1;
        [self loadPlanData];
       
    }];
    
    [self.view addSubview:self.planTableView];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark - tableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.planTableView) {

        return     self.plansArr.count;
    }
    return 0;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.planTableView) {
        
        NSLog(@"%ld",(long)indexPath.row);
        //        if (tt.bidType.intValue==1) {//零定宝
        XYHomeLDBShouQingCell *cell = [XYHomeLDBShouQingCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.plansArr[indexPath.row];
        return cell;

        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return  [XYHomeLDBShouQingCell cellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
    YiYueBiaoShouQingViewController *YiYueBiaoDetail=[[YiYueBiaoShouQingViewController alloc] init];
    YiYueBiaoDetail.hidesBottomBarWhenPushed=YES;
    YiYueBiaoDetail.chanshu=tt;
    [self.navigationController pushViewController:YiYueBiaoDetail animated:YES];
    
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
