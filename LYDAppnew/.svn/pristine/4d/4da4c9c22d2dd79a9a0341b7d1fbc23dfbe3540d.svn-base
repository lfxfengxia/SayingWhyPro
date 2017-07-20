//
//  DSYAccountBankController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountBankController.h"
#import "DSYAccountBankTableViewCell.h"
#import "DSYBankManageViewController.h"

#import "DSYBankModel.h"
#import "DSYOpenAccountController.h"

@interface DSYAccountBankController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;         /**< 主要区域 */

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UIView *footerView;   /**< tableView的tableViewFooter */

@property (nonatomic, strong) UIButton *addBankCardBtn; /**< 增加银行卡 */

@property (nonatomic, strong) UIButton *synBtn;         /**< 同步按钮 */

@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation DSYAccountBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    self.navigaTitle = @"银行卡";
   
    self.pageNum = 1;

    [self contentTableView];
    [self footerView];
    [self addBankCardBtn];
    [self synBtn];
    
//    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.pageNum = 1;
    [self loadData];
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataList;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, self.view.height) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_contentTableView];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.rowHeight = H(125);
        _contentTableView.backgroundColor = rgba(249, 249, 249, 1);
        _contentTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _contentTableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, H(190))];
        self.contentTableView.tableFooterView = _footerView;
    }
    return _footerView;
}

- (UIButton *)addBankCardBtn {
    if (!_addBankCardBtn) {
        _addBankCardBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.footerView  addSubview:_addBankCardBtn];
        [_addBankCardBtn setBackgroundImage:DSYImage(@"account_bank_add.png") forState:(UIControlStateNormal)];
        [_addBankCardBtn setTitle:@"+添加银行卡" forState:(UIControlStateNormal)];
        [_addBankCardBtn setTitleColor:rgba(102, 102, 102, 1) forState:(UIControlStateNormal)];
        _addBankCardBtn.titleLabel.font = DSY_NORMALFONT_18;
        _addBankCardBtn.frame = CGRectMake(X(12), Y(6), self.footerView.width - 2 * X(12), H(110));
        
        [_addBankCardBtn addTarget:self action:@selector(addBankCardBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBankCardBtn;
}

- (UIButton *)synBtn {
    if (!_synBtn) {
        _synBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.footerView addSubview:_synBtn];
        _synBtn.frame = CGRectMake(self.addBankCardBtn.x, self.footerView.height - H(44) - KHeight(20), self.addBankCardBtn.width, H(44));
        _synBtn.layer.cornerRadius = X(3);
        _synBtn.backgroundColor = ORANGECOLOR;
        _synBtn.titleLabel.font = DSY_NORMALFONT_16;
        [_synBtn setTitle:@"同步" forState:(UIControlStateNormal)];
        [_synBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_synBtn addTarget:self action:@selector(synButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _synBtn;
}

- (void)synButtonClick:(UIButton *)syncButton {
    [self loadData];
//    [self loadDataSync];
}

- (void)loadData {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.pageNum],@"pageSize":[NSNumber numberWithInteger:10]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.pageNum],@"pageSize":[NSNumber numberWithInteger:10],@"sign":sign};
    [MBProgressHUD showMessage:@"正在加载信息" toView:self.view];
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/bankAccounts",APIPREFIX] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if (self.pageNum == 1) {
            [self.dataList removeAllObjects];
        }
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
            if ([[backData allKeys] count] == 0) {
                [self.contentTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"bankAccountList"]) {
                    DSYBankModel *bank = [[DSYBankModel alloc] initWithDic:dict];
                    [self.dataList addObject:bank];
                }
                
                [self.contentTableView.header endRefreshing];
                [self.contentTableView.footer endRefreshing];
                
                if (self.dataList.count < 10) {
                    [self.contentTableView.footer noticeNoMoreData];
                }
                
                [self.contentTableView reloadData];
                if (self.dataList.count>=1) {
                    _addBankCardBtn.hidden=YES;
                }
                else
                {
                    _addBankCardBtn.hidden=NO;
                }
                
            }
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.contentTableView.header endRefreshing];
        [self.contentTableView.footer endRefreshing];
        
        
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:@"账号在其他设备登录,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self pushToLoginController];
            }];
            [alertVC addAction:alertAC];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
}






#pragma mark  数据源方法(DataSource) 和 协议方法(Delegate)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSYAccountBankTableViewCell *cell = [DSYAccountBankTableViewCell cellForTableView:tableView];
    cell.backgroundColor=[UIColor greenColor];
    DSYBankModel *bank = self.dataList[indexPath.row];
    if (bank.isDefault == 1) {
        cell.defaultLabel.hidden = NO;
        cell.iconView.image = DSYImage(@"dsy_bank_default.png");
    } else {
        cell.defaultLabel.hidden = YES;
        cell.iconView.image = DSYImage(@"dsy_bank_normal.png");
    }
    
    cell.bankNameLabel.text = bank.bankCode;
    cell.cardNumberLabel.text = [bank.account substringWithRange:NSMakeRange(bank.account.length-4, 4)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataList.count>=1) {
        return 1;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return H(2.5);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return H(2.5);
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DSYBankModel *bank = self.dataList[indexPath.row];
//    DSYBankManageViewController *bankManageVC = [[DSYBankManageViewController alloc] init];
//    bankManageVC.myBank = bank;
//    [self.navigationController pushViewController:bankManageVC animated:YES];
}

#pragma mark - 添加银行卡的按钮点击方法
- (void)addBankCardBtnClicked:(UIButton *)sender {
    
    DSYBindCardViewController *bindVC = [[DSYBindCardViewController alloc] init];
    [self.navigationController pushViewController:bindVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadDataSync {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign};
    
    [MBProgressHUD showMessage:@"正在同步" toView:self.view];
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/bankAccounts/sync",APIPREFIX] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        self.contentTableView.contentOffset = CGPointMake(0, -70);
        
        if (self.pageNum == 1) {
            [self.dataList removeAllObjects];
        }
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            [MBProgressHUD showSuccess:@"同步成功"];
            
            if ([[backData allKeys] count] == 0) {
                [self.contentTableView.footer noticeNoMoreData];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"bankAccountList"]) {
                    DSYBankModel *bank = [[DSYBankModel alloc] initWithDic:dict];
                    [self.dataList addObject:bank];
                }
                
                [self.contentTableView.header endRefreshing];
                [self.contentTableView.footer endRefreshing];
                
                if (self.dataList.count < 10) {
                    [self.contentTableView.footer noticeNoMoreData];
                }
                
                [self.contentTableView reloadData];
                
            }
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.contentTableView.header endRefreshing];
        [self.contentTableView.footer endRefreshing];
        
        
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:@"账号在其他设备登录,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self pushToLoginController];
                
            }];
            [alertVC addAction:alertAC];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
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
