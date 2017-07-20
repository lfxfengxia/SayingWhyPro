//
//  CapitalDeatilViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBCapitalDeatilViewController.h"
#import "RBCapitalCell.h"
#import "RBPikerView.h"
#import "DSYUserTradeRecord.h"
#import "DSYCapitalTypeModel.h"

#define kDSYPageSize 15
#define kTimeTitleKey @"title"
#define kTimeValueKey @"value"

@interface RBCapitalDeatilViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIView *topBgView;
@property (nonatomic, strong) UILabel *blanceNameLabel;
@property (nonatomic, strong) UILabel *blancePriceLabel;

@property (nonatomic, strong) UIView *middleBgView;
@property (nonatomic, strong) UIButton *allTypeButton;
@property (nonatomic, strong) UIButton *allTimeButton;

@property (nonatomic, strong) UIView *tableBgView;
@property (nonatomic, strong) RBPikerView *allTypePickerView;
@property (nonatomic, strong) RBPikerView *allTimePickerView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *allTypeArray;
@property (nonatomic, strong) NSMutableArray *allTimeArray;
@property (nonatomic, assign) NSInteger currentIndex;             /**< 类型选择序号 */
@property (nonatomic, assign) NSInteger currentTimeIndex;         /**< 当前时间选择的序号 */

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *showDataList;       /**< 需要展示 */




@end

@implementation RBCapitalDeatilViewController

@synthesize showDataList = _showDataList;

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}

- (NSMutableArray *)showDataList {
    if (!_showDataList) {
        _showDataList = [NSMutableArray arrayWithCapacity:0];
    }
    return _showDataList;
}

- (NSMutableArray *)allTypeArray {
    if (!_allTypeArray) {
        _allTypeArray = [NSMutableArray arrayWithCapacity:0];
        
        DSYCapitalTypeModel *allModel = [[DSYCapitalTypeModel alloc] init];
        allModel.value = 0;
        allModel.desc = @"全部类型";
       // [_allTypeArray addObject:allModel];
        
        
    }
    return _allTypeArray;
}

- (NSMutableArray *)allTimeArray {
    if (!_allTimeArray) {
        _allTimeArray = [NSMutableArray arrayWithCapacity:0];
        
        NSDictionary *dic1 = @{kTimeTitleKey:@"全部时间", kTimeValueKey:@0};
        NSDictionary *dic2 = @{kTimeTitleKey:@"一周内", kTimeValueKey:@1};
        NSDictionary *dic3 = @{kTimeTitleKey:@"一个月内", kTimeValueKey:@2};
        NSDictionary *dic4 = @{kTimeTitleKey:@"三个月内", kTimeValueKey:@3};
        
        [_allTimeArray addObject:dic1];
        [_allTimeArray addObject:dic2];
        [_allTimeArray addObject:dic3];
        [_allTimeArray addObject:dic4];
    }
    return _allTimeArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"资金明细";
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createUI];
    
   
    self.blancePriceLabel.text = [NSString stringWithFormat:@"￥ %.2f",  [DSYAccount sharedDSYAccount].availableBalance];
    self.blancePriceLabel.attributedText = [RYFactoryMethod addAttributed:_blancePriceLabel.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KWidth(18)]} range:NSMakeRange(0, 1)];
    self.allTimePickerView.backgroundColor = [UIColor whiteColor];
    self.allTypePickerView.backgroundColor = [UIColor whiteColor];
    
    // 先加载类型,没有动画提示
    [self loadTypeDataWithLoading:NO];
//    [self loadData];
}

#pragma mark - 加载数据------------------
- (void)loadData {
    self.pageIndex = 1;
    NSString *url = [NSString stringWithFormat:@"%@/account/tradeRecords", APIPREFIX];
    NSDictionary *para = [self getMyParaWithIndex:self.pageIndex];
    [MBProgressHUD showMessage:@"正在加载记录..." toView:self.view];
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
    NSString *url = [NSString stringWithFormat:@"%@/account/tradeRecords", APIPREFIX];
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
    
    // 获取当前选择的类型
    DSYCapitalTypeModel *typeModel = self.allTypeArray[self.currentIndex];
    NSDictionary *dic = self.allTimeArray[self.currentTimeIndex];
    
    NSLog(@"%ld----%@", typeModel.value, dic[kTimeValueKey]);
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"pageIndex":@(pageIndex), @"pageSize":@(kDSYPageSize), @"tradeType":@(typeModel.value), @"time":dic[kTimeValueKey]};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"pageIndex":@(pageIndex), @"pageSize":@(kDSYPageSize), @"tradeType":@(typeModel.value), @"time":dic[kTimeValueKey], @"sign":sign};
    
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
            self.showDataList = [DSYUserTradeRecord baseModelByArr:data[@"userTradeRecordList"]];
        } else {
            // 成功加载数据，当是加载更多的时候
            [self.showDataList addObjectsFromArray:[DSYUserTradeRecord baseModelByArr:data[@"userTradeRecordList"]]];
        }
        if (self.showDataList.count < kDSYPageSize) {
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



#pragma mark - 加载类型的数据
- (void)loadTypeDataWithLoading:(BOOL)loading {
    NSString *url = [NSString stringWithFormat:@"%@/account/tradeTypes", APIPREFIX];
    //
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, };
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    if (loading) {
        [MBProgressHUD showMessage:@"正在加载类型" toView:self.view];
    }
    
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        NSInteger statusCode = [backData[@"code"] integerValue];;
        if (statusCode == 200) {
            // 数据加载成功后设置相应的信息
            [self.allTypeArray addObjectsFromArray:[DSYCapitalTypeModel baseModelByArr:backData[@"tradeTypeModelList"]]];
            
            // 获取标题
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
            for (DSYCapitalTypeModel *type in self.allTypeArray) {
                [tempArr addObject:type.desc];
            }
            self.allTypePickerView.dataArray = tempArr;
            [self.allTypePickerView reloadData];
            [self.allTypePickerView layoutIfNeeded];
            // 刷新完毕后就直接加载数据
            if (!loading) {
                [self loadData];
            }
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
            // 刷新完毕后就直接加载数据
            if (!loading) {
                [self loadData];
            }
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
        [self errorDealWithOperation:operation];
        // 刷新完毕后就直接加载数据
        if (!loading) {
            [self loadData];
        }
    }];
}

#pragma mark - 创建UI视图------------------------
- (void)createUI {
    _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, NavMaxY, kSCREENW, KHeight(110))];
    _topBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topBgView];
    
    _blanceNameLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, KHeight(20), kSCREENW, 20) andTextColor:rgba(76, 76, 78, 1) fontOfSystemSize:KWidth(15)];
    _blanceNameLabel.text = @"余额";
    [_topBgView addSubview:_blanceNameLabel];

    _blancePriceLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, _blanceNameLabel.maxY + 10, kSCREENW, 40) andTextColor:rgba(252, 120, 35, 1) fontOfSystemSize:KWidth(36) isBold:YES];
    _blancePriceLabel.text = @"￥ 00.00";
    [_topBgView addSubview:_blancePriceLabel];

     _blancePriceLabel.attributedText = [RYFactoryMethod addAttributed:_blancePriceLabel.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KWidth(18)]} range:NSMakeRange(0, 1)];
    
    _middleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _topBgView.maxY + 10, kSCREENW, 44)];
    _middleBgView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    [self.view addSubview:_middleBgView];
    
    _allTypeButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(0, 0, kSCREENW/2-1, _middleBgView.height) title:@"全部类型" titleColor:rgba(76, 76, 78, 1) fontOfSystemSize:KWidth(15)];
    [_allTypeButton addTarget:self action:@selector(allTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _allTypeButton.backgroundColor = [UIColor whiteColor];
    [_middleBgView addSubview:_allTypeButton];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENW/2-1-KWidth(14+40), (_middleBgView.height-8)/2.0, 14, 8)];
    arrowImageView.image = [UIImage imageNamed:@"arrow_down"];
    [_allTypeButton addSubview:arrowImageView];
    [_allTypeButton.titleLabel fixSignleWidthForLeftBellowMaxWidth:_allTypeButton.width - 70];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_allTypeButton.mas_right).with.offset((-8));
        make.left.equalTo(_allTypeButton.titleLabel.mas_right).with.offset(8);
        make.centerY.equalTo(_allTypeButton);
        make.size.mas_equalTo(arrowImageView.frame.size);
    }];
    
    _allTimeButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(kSCREENW/2 + 1, 0, kSCREENW/2-1, _middleBgView.height) title:@"全部时间" titleColor:rgba(76, 76, 78, 1) fontOfSystemSize:KWidth(15)];
    [_allTimeButton addTarget:self action:@selector(allTimeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _allTimeButton.backgroundColor = [UIColor whiteColor];
    [_middleBgView addSubview:_allTimeButton];
    
    UIImageView *allTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENW/2.0-KWidth(14+40), (_middleBgView.height-8)/2.0, 14, 8)];
    allTimeImageView.image = [UIImage imageNamed:@"arrow_down"];
    [_allTimeButton addSubview:allTimeImageView];
    [_allTimeButton.titleLabel fixSignleWidthForLeftBellowMaxWidth:_allTimeButton.width - 70];
    [allTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_allTimeButton.mas_right).with.offset((-8));
        make.left.equalTo(_allTimeButton.titleLabel.mas_right).with.offset(8);
        make.centerY.equalTo(_allTimeButton);
        make.size.mas_equalTo(allTimeImageView.frame.size);
    }];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _middleBgView.maxY + 10, kSCREENW, kSCREENH-_middleBgView.maxY) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];

    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    _allTypePickerView = [[RBPikerView alloc] initWithFrame:CGRectMake(0, kSCREENH, kSCREENW, 244) andDataArray:_allTypeArray];
    
    __weak typeof(RBPikerView *) weakAllTypePickerView = _allTypePickerView;
    weakAllTypePickerView.cancelButtonClickBlock = ^(NSInteger row) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTypePickerView.transform = CGAffineTransformIdentity;
        }];
    };
    weakAllTypePickerView.doneButtonClickBlock = ^(NSInteger row) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTypePickerView.transform = CGAffineTransformIdentity;
        }];
        if (self.allTypeArray.count == 1) {
            [self loadTypeDataWithLoading:YES];
        }
        
        DSYCapitalTypeModel *type = self.allTypeArray[row];
        [_allTypeButton setTitle:type.desc forState:UIControlStateNormal];
        [_allTypeButton.titleLabel fixSignleWidthForLeftBellowMaxWidth:_allTypeButton.width - 70];
        // 如果是相同的选项就什么都不能做
        if (row == _currentIndex) {
            return ;
        } else {// 否者重新加载数据
            _currentIndex = row;
            [self loadData];
        }
    };
    [self.view addSubview:_allTypePickerView];
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in self.allTimeArray) {
        [tempArr addObject:dic[kTimeTitleKey]];
    }
    _allTimePickerView = [[RBPikerView alloc] initWithFrame:CGRectMake(0, kSCREENH, kSCREENW, 244) andDataArray:tempArr];
    __weak typeof(RBPikerView *) weakAllTimePickerView = _allTimePickerView;
    weakAllTimePickerView.cancelButtonClickBlock = ^(NSInteger row) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTimePickerView.transform = CGAffineTransformIdentity;
        }];
    };
    weakAllTimePickerView.doneButtonClickBlock = ^(NSInteger row) {
        
        [UIView animateWithDuration:0.2 animations:^{
            _allTimePickerView.transform = CGAffineTransformIdentity;
        }];
        NSDictionary *dic = self.allTimeArray[row];
        [_allTimeButton setTitle:dic[kTimeTitleKey] forState:UIControlStateNormal];
        [_allTimeButton.titleLabel fixSignleWidthForLeftBellowMaxWidth:_allTimeButton.width - 70];
        
        if (row == self.currentTimeIndex) {
            return ;
        } else {
            self.currentTimeIndex = row;
            [self loadData];
        }
    };
    [self.view addSubview:_allTimePickerView];
}

- (void)startRequestOfType {
    
}

- (void)startRequestOfTime {
    
}

- (void)allTypeButtonClick:(UIButton *)allTypeButton {
    if (_allTimePickerView.y != kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTimePickerView.transform = CGAffineTransformIdentity;
        }];
    }
    
    if (_allTypePickerView.y == kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTypePickerView.transform = CGAffineTransformMakeTranslation(0, -244);
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            _allTypePickerView.transform = CGAffineTransformIdentity;
            
        }];
    }
}

- (void)allTimeButtonClick:(UIButton *)allTimeButton {
    if (_allTypePickerView.y != kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTypePickerView.transform = CGAffineTransformIdentity;
        }];
    }
    
    if (_allTimePickerView.y == kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTimePickerView.transform = CGAffineTransformMakeTranslation(0, -244);
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            _allTimePickerView.transform = CGAffineTransformIdentity;
            
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld", self.showDataList.count);
    return self.showDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBCapitalCell *cell = [RBCapitalCell cellForTableView:tableView];
    
    cell.tradeRecord = self.showDataList[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}


#pragma mark - 自定义方法-------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_allTypePickerView.y != kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTypePickerView.transform = CGAffineTransformIdentity;
        }];
    }

    if (_allTimePickerView.y != kSCREENH) {
        [UIView animateWithDuration:0.2 animations:^{
            _allTimePickerView.transform = CGAffineTransformIdentity;
        }];
    }

    if (scrollView.contentOffset.y > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            _topBgView.y = -KHeight(110) + NavMaxY;
            _middleBgView.y = _topBgView.maxY;
            _tableView.y = _middleBgView.maxY + 10;
            _tableView.height = kSCREENH - _middleBgView.maxY - 10;
        }];
    }
    if (scrollView.contentOffset.y < 0) {
        if (_middleBgView.y >= _topBgView.maxY + 10) {
            return;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            _topBgView.y = NavMaxY;
            _middleBgView.y = _topBgView.maxY + 10;
            _tableView.y = _middleBgView.maxY + 10;
            _tableView.height = kSCREENH - _middleBgView.maxY - 10;
        } completion:^(BOOL finished) {
        }];
    }
}




@end
