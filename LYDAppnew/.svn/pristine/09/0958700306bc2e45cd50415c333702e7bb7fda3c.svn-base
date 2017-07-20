//
//  DSYInviteInvestController.m
//  LYDApp
//
//  Created by dai yi on 2017/1/2.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "DSYInviteInvestController.h"
#import "DSYFriendsInvestCell.h"
#import "DSYFriendInvestRecord.h"

#define kDSYPageSize 15

@interface DSYInviteInvestController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation DSYInviteInvestController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view.
    self.navigaTitle = @"投资记录";
    self.view.backgroundColor = RGB(249, 249, 249);
    self.dataList  =[[NSMutableArray alloc] init];
    [self creatUI];
    
   // [self loadData];
    [self.contentTableView.header beginRefreshing];
}

//#pragma mark - 网络加载数据
//- (void)loadData {
//    self.pageIndex = 1;
//    NSString *url = [NSString stringWithFormat:@"%@/user/invite/invests", APIPREFIX];
//    NSDictionary *parameter = [self getParameterForIndex:self.pageIndex];
//    [LYDTool sendGetWithUrl:url parameters:parameter success:^(id data) {
//        id backData = LYDJSONSerialization(data);
//        NSLog(@"%@", backData);
//        [self successDealWithData:backData];
//    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//        [self errorDealWithOperation:operation];
//    }];
//    
//    
//}

//- (void)loadMoreData {
//    self.pageIndex = self.pageIndex + 1;
//    NSString *url = [NSString stringWithFormat:@""];
//}

//- (NSDictionary *)getParameterForIndex:(NSInteger)pageIndex {
//    NSString *timestamp = [LYDTool createTimeStamp];
//    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:pageIndex],@"pageSize":[NSNumber numberWithInteger:15] };
//    // 生成签名认证
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:pageIndex],@"pageSize":[NSNumber numberWithInteger:15],@"sign":sign};
//    return para;
//}










#pragma mark - 网络加载数据----------------------
#pragma mark  加载理财的数据--------------
- (void)loadPlanData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.pageIndex],@"pageSize":[NSNumber numberWithInteger:15] };
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.pageIndex],@"pageSize":[NSNumber numberWithInteger:15],@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/user/invite/invests", APIPREFIX] parameters:para success:^(id data) {
        [self.contentTableView.header endRefreshing];
        [self.contentTableView.footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        //bidType   1零定宝
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            
            
            
            if (![self dx_isNullOrNilWithObject:[backData valueForKey:@"inviteFriendInvestModelList"]]) {
                if (self.pageIndex == 1) {
                    [self.dataList removeAllObjects];
                }
                if ([[backData valueForKey:@"inviteFriendInvestModelList"] count] == 0) {
                    [self.contentTableView.footer noticeNoMoreData];
                    [self.contentTableView.header endRefreshing];
                } else {
                    //                for (NSDictionary *dict in [backData valueForKey:@"inviteFriendInvestModelList"]) {
                    //                    XYPlanModel *model = [[XYPlanModel alloc] init];
                    //                    [model setValuesForKeysWithDictionary:dict];
                    //                    [self.dataList addObject:model];
                    //                }
                    NSMutableArray *tempArr = [DSYFriendInvestRecord baseModelByArr:backData[@"inviteFriendInvestModelList"]];
                    [self.dataList addObjectsFromArray:tempArr];
                    
                    //                if (self.dataList.count < 10) {
                    //                    [self.contentTableView.footer noticeNoMoreData];
                    //                }
                    [self.contentTableView reloadData];
                }

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



//判断对象是否为空

- (BOOL)dx_isNullOrNilWithObject:(id)object;
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}


#pragma mark 网络错误的处理方法
- (void)errorDataHandleWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
//    [self.sanBidTableView.header endRefreshing];
//    [self.sanBidTableView.footer endRefreshing];
    
    id response = LYDJSONSerialization(operation.responseObject);
    NSLog(@"%@",response);
    if ([[response valueForKey:@"code"] integerValue] == 401) {
        [DSYUtils showResponseError_401_ForViewController:self];
        
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}




//#pragma mark 成功处理
//- (void)successDealWithData:(id)data {
//    [MBProgressHUD hideHUDForView:self.view];
//    [self.contentTableView.footer endRefreshing];
//    [self.contentTableView.header endRefreshing];
//    NSInteger statusCode = [data[@"code"] integerValue];;
//    
//    if (statusCode == 200) {
//        // 数据加载成功后设置相应的信息
//        
//        
//        if (![self dxisNullOrNilWithObject:data[@"inviteFriendInvestModelList"]]) {
//            NSMutableArray *tempArr = [DSYFriendInvestRecord baseModelByArr:data[@"inviteFriendInvestModelList"]];
//            if (self.pageIndex == 1) {
//                self.dataList = tempArr;
//            } else {
//                // 成功加载数据，当是加载更多的时候 
//                [self.dataList addObjectsFromArray:tempArr];
//            }
//            if (tempArr.count < kDSYPageSize) {
//                [self.contentTableView.footer noticeNoMoreData];
//                // 如果没有更多数据就让page恢复
//                self.pageIndex --;
//            }
//            [self.contentTableView reloadData];
//        } else {
//            
//        }
//     
//    } else if (statusCode == 600) {
//        [DSYUtils showSuccessForStatus_600_ForViewController:self];
//    } else {
//        [MBProgressHUD showError:data[@"message"] toView:self.view];
//        // 如果加载数据有问题就让page恢复
//        self.pageIndex--;
//    }
//}


- (BOOL)dxisNullOrNilWithObject:(id)object;
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}




- (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
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
        [DSYUtils showResponseError_404_ForViewController:self message:@"未发现任何信息" okHandler:^(UIAlertAction *action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}


- (void)creatUI {
    [self contentTableView];
    //    [self headerView];
}

#pragma mark - UI的创建，创建主要的内容
#pragma mark contentTableView的创建---------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.rowHeight = H(60);
        _contentTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _contentTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageIndex = 1;
            [self loadPlanData];
           // [self loadOtherInfo];
        }];
        
        _contentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            [self loadPlanData];
        }];
    }
    return _contentTableView;
}

#pragma mark - contentTableView的DataSource和Delegate
#pragma mark contentTableView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYFriendsInvestCell *cell = [DSYFriendsInvestCell cellForTableView:tableView];
    
    cell.recod = self.dataList[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *secHeaderVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, 44)];
    secHeaderVeiw.backgroundColor = self.contentTableView.backgroundColor;
    
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, secHeaderVeiw.width, secHeaderVeiw.height)];
    [secHeaderVeiw addSubview:labelView];
    labelView.backgroundColor = RGB(239, 235, 231);
    
    [self creatLabelsWithTitles:@[@"投资人", @"投资金额", @"投标时间", @"标的名称"] forSuperView:labelView];
    return secHeaderVeiw;
}

#pragma mark contentTableView的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 自定义方法-----------------------
#pragma mark 创建tableView的顶部标题栏目
- (void)creatLabelsWithTitles:(NSArray *)titles forSuperView:(UIView *)superView {
    CGFloat width = superView.width / titles.count;
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(i * width, 0, width, superView.height) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(13.0f)];
        [superView addSubview:showLabel];
        showLabel.text = title;
        showLabel.numberOfLines = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
