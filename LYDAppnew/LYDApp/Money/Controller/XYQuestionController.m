//
//  XYQuestionController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/28.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYQuestionController.h"
#import "XYQACell.h"
#import "XYQAModel.h"

@interface XYQuestionController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *questionTableView;
@property (nonatomic, copy) NSMutableArray  *questionsArr;
@property (nonatomic, assign) NSInteger     questionPage;

@end

@implementation XYQuestionController

- (NSMutableArray *)questionsArr
{
    if (!_questionsArr) {
        _questionsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _questionsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"常见问题";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.questionPage = 1;
    
    [self createQuestionTableView];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [self loadQuestionData];
}

- (void)loadQuestionData
{
//    XYQAModel *model1 = [[XYQAModel alloc] init];
//    model1.question = @"源计划标的收益有多少？";
//    model1.anwser = @"预期年化收益率15%，但根据借款人发布的利率不同和借款人的实际履约情况不同，每个投资人的实际收益率存在些许差异。";
//    
//    XYQAModel *model2 = [[XYQAModel alloc] init];
//    model2.question = @"源计划标的投资收益方式？";
//    model2.anwser = @"源计划标采用一次性还本付息方式，投资人到期获得投资收益。";
//    
//    XYQAModel *model3 = [[XYQAModel alloc] init];
//    model3.question = @"源计划标的投资收益方式源计划标的投资收益方式源计划标的投资收益方式源计划标的投资收益方式源计划标的投资收益方式？";
//    model3.anwser = @"预期年化收益率15%，但根据借款人发布的利率不同和借款人的实际履约情况不同，每个投资人的实际收益率存在些许差异预期年化收益率15%，但根据借款人发布的利率不同和借款人的实际履约情况不同，每个投资人的实际收益率存在些许差异预期年化收益率15%，但根据借款人发布的利率不同和借款人的实际履约情况不同，每个投资人的实际收益率存在些许差异预期年化收益率15%，但根据借款人发布的利率不同和借款人的实际履约情况不同，每个投资人的实际收益率存在些许差异。";
//    
//    [self.questionsArr addObject:model1];
//    [self.questionsArr addObject:model2];
//    [self.questionsArr addObject:model3];
//    [self.questionsArr addObject:model1];
//    [self.questionsArr addObject:model2];
//    [self.questionsArr addObject:model3];
//    
//    [self.questionTableView reloadData];
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.questionPage],@"pageSize":[NSNumber numberWithInteger:10]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.questionPage],@"pageSize":[NSNumber numberWithInteger:10],@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/content/questions",APIPREFIX] parameters:para success:^(id data) {
        [self.questionTableView.header endRefreshing];
        [self.questionTableView.footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.questionPage == 1) {
                [self.questionsArr removeAllObjects];
            }
            
            if ([[backData valueForKey:@"newsModelList"] count] == 0) {
                [self.questionTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"newsModelList"]) {
                    XYQAModel *model = [[XYQAModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.questionsArr addObject:model];
                }
                
                [self.questionTableView.header endRefreshing];
                [self.questionTableView.footer endRefreshing];
                
                if (self.questionsArr.count < 10) {
                    [self.questionTableView.footer noticeNoMoreData];
                }
                
                [self.questionTableView reloadData];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [self.questionTableView.header endRefreshing];
            [self.questionTableView.footer endRefreshing];
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
            
        } else {
            
            [self.questionTableView.header endRefreshing];
            [self.questionTableView.footer endRefreshing];
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
        
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.questionTableView.header endRefreshing];
        [self.questionTableView.footer endRefreshing];
        
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

- (void)createQuestionTableView
{
    self.questionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH - 64) style:UITableViewStylePlain];
    self.questionTableView.tableFooterView = [[UIView alloc] init];
    self.questionTableView.delegate = self;
    self.questionTableView.dataSource = self;
    
    self.questionTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.questionPage = 1;
        [self loadQuestionData];
    }];
    
    self.questionTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.questionPage += 1;
        [self loadQuestionData];
    }];
    
    [self.view addSubview:self.questionTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYQACell *cell = [XYQACell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.questionsArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.questionsArr[indexPath.row] cellHeight];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
