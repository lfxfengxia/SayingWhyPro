//
//  XiaoXiViewController.m
//  LYDApp
//
//  Created by fcl on 2017/7/1.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "XiaoXiViewController.h"
#import "xiaoxiCell.h"
#import "xiaoxiModel.h"

@interface XiaoXiViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic, strong) UITableView   *commentTableView;
@property (nonatomic, copy) NSMutableArray  *commentsArr;
@property (nonatomic, assign) NSInteger     commentPage;
@end

@implementation XiaoXiViewController

- (NSMutableArray *)commentsArr
{
    if (!_commentsArr) {
        _commentsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"消息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    self.commentPage = 1;
    
    [self createCommentTableView];
    [self loadCommentData];
    

}

- (void)loadCommentData
{
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.commentPage],@"pageSize":[NSNumber numberWithInteger:10]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.commentPage],@"pageSize":[NSNumber numberWithInteger:10],@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/user/getPushList",APIPREFIX] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.commentTableView.header endRefreshing];
        [self.commentTableView.footer endRefreshing];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        
            if (self.commentPage == 1) {
                [self.commentsArr removeAllObjects];
            }
        
            if ([backData count] == 0) {
                [self.commentTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in backData) {
                    xiaoxiModel *model = [[xiaoxiModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.commentsArr addObject:model];
                }
                
                
                if (self.commentsArr.count < 10) {
                    [self.commentTableView.footer noticeNoMoreData];
                }
                
                [self.commentTableView reloadData];
            }

    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.commentTableView.header endRefreshing];
        [self.commentTableView.footer endRefreshing];
        
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







#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation message:(NSString *)message {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger errorData = operation.response.statusCode;
    NSLog(@"%zi",operation.response.statusCode);
    if (errorData == 401) {
        // 401错误处理
        [DSYUtils showResponseError_401_ForViewController:self];
    } else if (errorData == 404) {
        [DSYUtils showResponseError_404_ForViewController:self message:message okHandler:^(UIAlertAction *action) {
            [self pushToLoginController];
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}

- (void)createCommentTableView
{
    self.commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH-64) style:UITableViewStylePlain];
    self.commentTableView.tableFooterView = [[UIView alloc] init];
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    self.commentTableView.separatorStyle = NO;
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.commentPage = 1;
        [self loadCommentData];
    }];
    
    self.commentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.commentPage += 1;
        [self loadCommentData];
    }];
    
    [self.view addSubview:self.commentTableView];
    

    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    xiaoxiCell *cell = [xiaoxiCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.commentsArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.commentsArr[indexPath.row] cellHeight];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
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






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
