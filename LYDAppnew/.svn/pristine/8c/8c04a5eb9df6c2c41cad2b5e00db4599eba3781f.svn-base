//
//  XYCommentController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/28.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYCommentController.h"
#import "XYCustomCommentCell.h"
#import "XYCustomCommentModel.h"


@interface XYCommentController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) UITableView   *commentTableView;
@property (nonatomic, copy) NSMutableArray  *commentsArr;
@property (nonatomic, assign) NSInteger     commentPage;

@property (nonatomic, strong) UIView        *TVView;
@property (nonatomic, strong) BRPlaceholderTextView *contentTV;
@property (nonatomic, strong) UIImageView        *TVHeadView;
@property (nonatomic, strong) UILabel       *textLengthLabel;
@property (nonatomic, strong) UIButton      *doneBtn;

@end

@implementation XYCommentController

- (NSMutableArray *)commentsArr
{
    if (!_commentsArr) {
        _commentsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"客户评论";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    self.commentPage = 1;
    
    [self createCommentTableView];
    [self loadCommentData];
    
    // 判断用户是否可以评论
    if ([DSYAccount sharedDSYAccount].canComment == NO) {
        self.doneBtn.backgroundColor = [UIColor colorWithRed:0.73 green:0.68 blue:0.65 alpha:1.00];
        self.doneBtn.enabled = NO;
        [self.doneBtn setTitle:@"未购买产品不可评论" forState:(UIControlStateNormal)];
    }
}

- (void)loadCommentData
{
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.commentPage],@"pageSize":[NSNumber numberWithInteger:10]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.commentPage],@"pageSize":[NSNumber numberWithInteger:10],@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/common/comments",APIPREFIX] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.commentTableView.header endRefreshing];
        [self.commentTableView.footer endRefreshing];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.commentPage == 1) {
                [self.commentsArr removeAllObjects];
            }
            
            if ([[backData valueForKey:@"commentList"] count] == 0) {
                [self.commentTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"commentList"]) {
                    XYCustomCommentModel *model = [[XYCustomCommentModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.commentsArr addObject:model];
                }
                
                
                if (self.commentsArr.count < 10) {
                    [self.commentTableView.footer noticeNoMoreData];
                }
                
                [self.commentTableView reloadData];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
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

- (void)submitMyCommen {
    if (self.contentTV.text.length == 0) {
        [MBProgressHUD showError:@"请输入内容" toView:self.view];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/common/comments/new", APIPREFIX];
    NSDictionary *para = [self getMyPara];
    [LYDTool sendPostWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        // 错误处理方法
        [self errorDealWithOperation:operation message:@"未发现当前用户，是否重登录"];
    }];
}



- (NSDictionary *)getMyPara {
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"content": self.contentTV.text, @"id":self.planId, @"productType":@(self.productType)};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"content": self.contentTV.text, @"id":self.planId, @"productType":@(self.productType), @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        [MBProgressHUD showSuccess:@"评论成功!" toView:self.view];
        self.contentTV.text = @"";
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
    }
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
    self.commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH - 64 - KHeight(394/2)) style:UITableViewStylePlain];
    self.commentTableView.tableFooterView = [[UIView alloc] init];
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    
    self.commentTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.commentPage = 1;
        [self loadCommentData];
    }];
    
    self.commentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.commentPage += 1;
        [self loadCommentData];
    }];
    
    [self.view addSubview:self.commentTableView];
    
    self.TVView = [[UIView alloc] initWithFrame:CGRectMake(0, self.commentTableView.maxY, kSCREENW, KHeight(394/2))];
    self.TVView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TVView];
    
    self.TVHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(44))];
    self.TVHeadView.image = [UIImage imageNamed:@"commentHead"];
    [self.TVView addSubview:self.TVHeadView];
    
    self.contentTV = [[BRPlaceholderTextView alloc] initWithFrame:CGRectMake(0, self.TVHeadView.maxY, kSCREENW, KHeight(218/2))];
    self.contentTV.backgroundColor = [UIColor whiteColor];
    self.contentTV.maxTextLength = 200;
    self.contentTV.delegate = self;
    [self.TVView addSubview:self.contentTV];
    
    self.textLengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(10), self.contentTV.maxY - KHeight(21),kSCREENW - KWidth(25), KHeight(15))];
    self.textLengthLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    self.textLengthLabel.textColor = TEXTGARY;
    self.textLengthLabel.textAlignment = NSTextAlignmentRight;
    self.textLengthLabel.text = [NSString stringWithFormat:@"0/200"];
    [self.TVView addSubview:self.textLengthLabel];
    
    self.doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.contentTV.maxY, kSCREENW, KHeight(44))];
    self.doneBtn.backgroundColor = ORANGECOLOR;
    [self.doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.doneBtn addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.TVView addSubview:self.doneBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCustomCommentCell *cell = [XYCustomCommentCell cellWithTableView:tableView];
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

- (void)textViewDidChange:(UITextView *)textView
{
    
    self.textLengthLabel.text = [NSString stringWithFormat:@"%zi/200",textView.text.length > 200 ? 200 : textView.text.length];
}


- (void)doneBtnClicked:(UIButton *)button
{
    [self submitMyCommen];
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
