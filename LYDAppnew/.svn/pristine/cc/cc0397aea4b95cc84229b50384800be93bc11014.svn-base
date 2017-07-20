//
//  RBMessageCenterViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/3.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBMessageCenterViewController.h"
#import "RBDatePickerView.h"
#import "RBMessageCenterCell.h"
#import "RBMessageModel.h"
#import "DSYMessageDetailViewController.h"

#define kDSYPageSize 15
@interface RBMessageCenterViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *startTimeButton;
@property (nonatomic, strong) UIButton *endTimeButton;
@property (nonatomic, strong) RBDatePickerView *startDatePicker;
@property (nonatomic, strong) RBDatePickerView *endDatePicker;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic,   copy) NSString *startDate;     /**< 开始时间 */
@property (nonatomic,   copy) NSString *endDate;       /**< 结束时间 */

@end

@implementation RBMessageCenterViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"消息中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    [self loadData];
}

- (void)loadData {
    self.pageIndex = 1;
    //    [self.dataList removeAllObjects];
    NSString *url = [NSString stringWithFormat:@"%@/user/message/list", APIPREFIX];
    NSDictionary *para = [self getMyParaWithIndex:self.pageIndex];
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
        self.pageIndex--;
        // 错误处理方法
        [self errorDealWithOperation:operation];
    }];
}

- (void)loadMoreData {
    self.pageIndex++;
    NSString *url = [NSString stringWithFormat:@"%@/user/message/list", APIPREFIX];
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
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"pageIndex":@(pageIndex), @"pageSize":@(kDSYPageSize), @"createTimeStart":self.startDate, @"createTimeEnd":self.endDate};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"pageIndex":@(pageIndex), @"pageSize":@(kDSYPageSize), @"createTimeStart":self.startDate, @"createTimeEnd":self.endDate, @"sign":sign};
    
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
            self.dataArray = [RBMessageModel baseModelByArr:data[@"messageModelList"]];
        } else {
            // 成功加载数据，当是加载更多的时候
            [self.dataArray addObjectsFromArray:[RBMessageModel baseModelByArr:data[@"messageModelList"]]];
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


#pragma mark - 获取时间
- (NSString *)startDate {
    if (!_startDate || _startDate.length <= 0) {
        _startDate = [[NSDate dateWithTimeInterval:-(30 * 60 * 60 *24) sinceDate:[NSDate date]] getDateStringWithFormatterStr:@"yyyyMMdd"];
    }
    return _startDate;
}


- (NSString *)endDate {
    if (!_endDate || _endDate.length <= 0) {
        NSDate *currentDate = [NSDate dateWithTimeInterval:(60 * 60 *24) sinceDate:[NSDate date]];
        _endDate = [currentDate getDateStringWithFormatterStr:@"yyyyMMdd"];
    }
    return _endDate;
}


#pragma mark - 标记全部已读
- (void)readAllButton:(UIButton *)button {
    
}

- (void)createUI {
    UIButton *navButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(0, 0, 100, 40) title:@"全部已读" titleColor:rgba(102, 102, 102, 1) fontOfSystemSize:KWidth(14)];
    navButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [navButton addTarget:self action:@selector(readAllButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _startTimeButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(0, 64, kSCREENW/2.0, 44) title:@"请选择开始时间" titleColor:rgba(102, 102, 102, 1) fontOfSystemSize:KWidth(14)];
    _startTimeButton.backgroundColor = [UIColor whiteColor];
    [_startTimeButton addTarget:self action:@selector(showStartTimePickerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startTimeButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kSCREENW/2.0-1, 4, 0.5, 36)];
    lineView.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    [_startTimeButton addSubview:lineView];
    
    _endTimeButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(kSCREENW/2.0, 64, kSCREENW/2.0, 44) title:@"请选择结束时间" titleColor:rgba(102, 102, 102, 1) fontOfSystemSize:KWidth(14)];
    _endTimeButton.backgroundColor = [UIColor whiteColor];
    [_endTimeButton addTarget:self action:@selector(showEndTimePickerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_endTimeButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _startTimeButton.maxY, kSCREENW, kSCREENH-_startTimeButton.maxY) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    _startDatePicker = [[RBDatePickerView alloc] initWithFrame:CGRectMake(0, kSCREENH, kSCREENW, 244 )];
    _startDatePicker.promptString = @"请选择开始时间";
    
    __weak typeof(RBDatePickerView *) weakStartDatePicker = _startDatePicker;
    weakStartDatePicker.cancelButtonClickBlock = ^(UIDatePicker *datePicker) {
        [UIView animateWithDuration:0.2 animations:^{
            _startDatePicker.transform = CGAffineTransformIdentity;
        }];
    };
    weakStartDatePicker.doneButtonClickBlock = ^(UIDatePicker *datePicker) {
        [UIView animateWithDuration:0.2 animations:^{
            _startDatePicker.transform = CGAffineTransformIdentity;
        }];

        NSDate *startDate = [datePicker date];
        NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
        fomatter.dateFormat = @"yyyy-MM-dd";
        NSString *startDateString = [fomatter stringFromDate:startDate];

        // 先选结束时间 后选开始时间
        if (![self limitEndTimeDateAscendingCompareStartTimeDate:[[_endTimeButton currentTitle] substringFromIndex:4] andStartTimeDate:startDateString]) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"起始时间不能大于结束时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
        }
        else {
            [_startTimeButton setTitle:[NSString stringWithFormat:@"起始于：%@", [fomatter stringFromDate:startDate]] forState:UIControlStateNormal];
            self.startDate = [startDate getDateStringWithFormatterStr:@"yyyyMMdd"];
            if (_endTimeButton.currentTitle.length > 4) {
                
            }
        }

    };
    
    [self.view addSubview:_startDatePicker];
    
    _endDatePicker = [[RBDatePickerView alloc] initWithFrame:CGRectMake(0, kSCREENH, kSCREENW, 244 )];
    _endDatePicker.promptString = @"请选择结束时间";
    
    __weak typeof(RBDatePickerView *) weakEndDatePicker = _endDatePicker;
    weakEndDatePicker.cancelButtonClickBlock = ^(UIDatePicker *datePicker) {
        [UIView animateWithDuration:0.2 animations:^{
            _endDatePicker.transform = CGAffineTransformIdentity;
        }];
    };
    weakEndDatePicker.doneButtonClickBlock = ^(UIDatePicker *datePicker) {
        [UIView animateWithDuration:0.2 animations:^{
            _endDatePicker.transform = CGAffineTransformIdentity;
        }];

        NSDate *endDate = [datePicker date];
        NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
        fomatter.dateFormat = @"yyyy-MM-dd";
        NSString *endDateString = [fomatter stringFromDate:endDate];
        
        if (![self limitEndTimeDateAscendingCompareStartTimeDate:endDateString andStartTimeDate:[[_startTimeButton currentTitle] substringFromIndex:4]]) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"结束时间不能小于起始时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
        }
        else
        {
            [_endTimeButton setTitle:[NSString stringWithFormat:@"结束于：%@", [fomatter stringFromDate:endDate]] forState:UIControlStateNormal];
            self.endDate = [endDate getDateStringWithFormatterStr:@"yyyyMMdd"];
            if (_startTimeButton.currentTitle.length > 4) {
                [self loadData];
            }
        }
    };

    [self.view addSubview:_endDatePicker];
}


- (BOOL)limitEndTimeDateAscendingCompareStartTimeDate:(NSString *)endTimeString andStartTimeDate:(NSString *)startTimeString {
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *startDate = [fomatter dateFromString:startTimeString];
    
    NSDate *endTimeDate = [fomatter dateFromString:endTimeString];
    // 小于
    if ([endTimeDate compare:startDate] == NSOrderedAscending) {
        return NO;
    }
    else
    {
        return YES; // 大于或等于
    }
}

- (void)showStartTimePickerClick:(UIButton *)startTimeButton {
    if (_endDatePicker.y != kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _endDatePicker.transform = CGAffineTransformIdentity;
        }];
    }
    
    if (_startDatePicker.y == kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _startDatePicker.transform = CGAffineTransformMakeTranslation(0, -244);

        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            _startDatePicker.transform = CGAffineTransformIdentity;

        }];
    }

}

- (void)showEndTimePickerClick:(UIButton *)endTimeButton {
    if (_startDatePicker.y != kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _startDatePicker.transform = CGAffineTransformIdentity;

        }];
    }
    
    if (_endDatePicker.y == kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _endDatePicker.transform = CGAffineTransformMakeTranslation(0, -244);

        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            _endDatePicker.transform = CGAffineTransformIdentity;

        
        }];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40+KHeight(25);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBMessageCenterCell *cell = [RBMessageCenterCell cellForTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYMessageDetailViewController *detailVC = [[DSYMessageDetailViewController alloc] init];
    detailVC.message = self.dataArray[indexPath.row];
    detailVC.block = ^() {
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_startDatePicker.y != kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _startDatePicker.transform = CGAffineTransformIdentity;
            
        }];
    }
    if (_endDatePicker.y != kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _endDatePicker.transform = CGAffineTransformIdentity;
            
            
        }];
    }
}

@end
