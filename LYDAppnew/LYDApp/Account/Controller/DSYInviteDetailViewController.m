//
//  DSYInviteDetailViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/30.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYInviteDetailViewController.h"
#import "DSYFriendsInvestCell.h"
#import "DSYFriendInvestModel.h"

#define kDSYPageSize 15

@interface DSYInviteDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

//@property (nonatomic, strong) UIView *headerView;
//@property (nonatomic, strong) UITextField *registerStartField;     /**< 开始注册时间 */
//@property (nonatomic, strong) UITextField *registerEndField;       /**< 注册的结束时间 */
//@property (nonatomic, strong) UITextField *investStartField;       /**< 投资的开始时间 */
//@property (nonatomic, strong) UITextField *investEndField;         /**< 投资的结束时间 */

@property (nonatomic, strong) DSYDateModel *myDate;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation DSYInviteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"推荐好友";
    self.view.backgroundColor = RGB(249, 249, 249);
    
    [self creatUI];
    
[self loadData];
    [self.contentTableView.header beginRefreshing];

}

#pragma mark - 网络加载数据
- (void)loadData {
    self.pageIndex = 1;
    NSString *url = [NSString stringWithFormat:@"%@/user/invite/friends", APIPREFIX];
    NSDictionary *parameter = [self getParameterForIndex:self.pageIndex];
    [LYDTool sendGetWithUrl:url parameters:parameter success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorDealWithOperation:operation];
    }];
    
    
}

- (void)loadMoreData {
    self.pageIndex++;
    NSString *url = [NSString stringWithFormat:@"%@/user/invite/friends", APIPREFIX];

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
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:pageIndex], @"pageSize":@"20"};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:pageIndex], @"pageSize":@"20", @"sign":sign};
    
    //    , @"investId":@(self.financing.investId)
    
    return para;
}




- (NSDictionary *)getParameterForIndex:(NSInteger)pageIndex {
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:pageIndex], @"pageSize":@"20"};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:pageIndex], @"pageSize":@"20",@"sign":sign};
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    [self.contentTableView.footer endRefreshing];
    [self.contentTableView.header endRefreshing];
    NSInteger statusCode = [data[@"code"] integerValue];;
    NSMutableArray *tempArr;
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        
        
        if ([self isNullOrNilWithObject:data[@"inviteFriendModelList"]]) {
            tempArr = nil;
        }
        else
        {
        
        tempArr = [DSYFriendInvestModel baseModelByArr:data[@"inviteFriendModelList"]];
        
        }
        
        if (self.pageIndex == 1) {
            self.dataList = tempArr;
        } else {
            // 成功加载数据，当是加载更多的时候
            [self.dataList addObjectsFromArray:tempArr];
        }
        if (tempArr.count < kDSYPageSize) {
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







- (BOOL)isNullOrNilWithObject:(id)object;
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
    //[self headerView];
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
        
        _contentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _contentTableView;
}

//- (UIView *)headerView {
//#pragma mark headerView的创建------------
//    if (!_headerView) {
//        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(90))];
//        self.contentTableView.tableHeaderView = _headerView;
//        // 输入
//        UIImageView *registerBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _headerView.width, _headerView.height / 2)];
//        [_headerView addSubview:registerBgView];
//        UIImageView *investBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, registerBgView.maxY, _headerView.width, _headerView.height / 2)];
//        [_headerView addSubview:investBgView];
//        
//        registerBgView.image = DSYImage(@"accoun_date_bg_icon.png");
//        investBgView.image   = DSYImage(@"accoun_date_bg_icon.png");
//        registerBgView.userInteractionEnabled = YES;
//        investBgView.userInteractionEnabled   = YES;
//        
//        // 四个TExtField
////        self.registerStartField = [UITextField alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//        
//    }
//    return _headerView;
//}


#pragma mark - contentTableView的DataSource和Delegate
#pragma mark contentTableView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYFriendsInvestCell *cell = [DSYFriendsInvestCell cellForTableView:tableView];
    
    cell.friendInvest = self.dataList[indexPath.row];
    
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
    
    [self creatLabelsWithTitles:@[@"受邀人", @"注册时间", @"投资总额"] forSuperView:labelView];
    return secHeaderVeiw;
}

#pragma mark contentTableView的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 自定义方法-----------------------
#pragma mark 创建一个textField
- (UITextField *)creatTextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textAlignment:(NSTextAlignment)textAlignment {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.textAlignment = textAlignment;
    textField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder];
    
    return textField;
}

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


#pragma mark -   DSYDateModel @implementation
@implementation DSYDateModel
- (NSString *)rigsterStartDate {
    if (!_rigsterStartDate || _rigsterStartDate.length <= 0) {
        _rigsterStartDate = [[NSDate dateWithTimeInterval:-(30 * 60 * 60 *24) sinceDate:[NSDate date]] getDateStringWithFormatterStr:@"yyyyMMdd"];
    }
    return _rigsterStartDate;
}

- (NSString *)rigsterEndDate {
    if (!_rigsterEndDate || _rigsterEndDate.length <= 0) {
        _rigsterEndDate = [[NSDate dateWithTimeInterval:(60 * 60 *24) sinceDate:[NSDate date]] getDateStringWithFormatterStr:@"yyyyMMdd"];
    }
    return _rigsterEndDate;
}


- (NSString *)investStartDate {
    if (!_investStartDate || _investStartDate.length <= 0) {
        _investStartDate = [[NSDate dateWithTimeInterval:-(30 * 60 * 60 *24) sinceDate:[NSDate date]] getDateStringWithFormatterStr:@"yyyyMMdd"];
    }
    return _investStartDate;
}

- (NSString *)investEndDate {
    if (!_investEndDate || _investEndDate.length <= 0) {
        _investEndDate = [[NSDate dateWithTimeInterval:(60 * 60 *24) sinceDate:[NSDate date]] getDateStringWithFormatterStr:@"yyyyMMdd"];
    }
    return _investEndDate;
}
@end
