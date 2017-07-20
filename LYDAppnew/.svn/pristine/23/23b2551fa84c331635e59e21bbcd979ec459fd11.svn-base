//
//  DSYAccountCashController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/3.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountCashController.h"
#import "DSYBankModel.h"
#import "DSYCashViewController.h"
#import "Helper.h"
#define kMaxAmount 99999999


#define kTextColorGray_153 rgba(153, 153, 153, 1)

@interface DSYAccountCashController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIView *headerBGView;         /**< 头部视图 */
@property (nonatomic, strong) UILabel *cashValueLabel;      /**< 提现的值 */

@property (nonatomic, strong) UITableView *contentTableView; /**< 主要视图区域 */

@property (nonatomic, strong) UIView *tableViewFooter;       /**< 提现列表的为仕途 */
@property (nonatomic, strong) UILabel *noticeLabel;          /**< 提示 */
@property (nonatomic, strong) UIButton *confireBtn;          /**< 确认提现按钮 */

@property (nonatomic, strong) NSMutableArray *dataList;       /**< 数据 */

@property (nonatomic, weak)   UITextField *inputCashField;    /**< 提现的金额输入框 */
@property (nonatomic, assign) NSInteger currentSelectIndex;

@property (nonatomic, assign) NSUInteger pageNum;
@property (nonatomic, assign) double cash;
@property(nonatomic,copy) NSString *withdrawalDescribe;

@end

@implementation DSYAccountCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageNum = 1;
    self.titleNavigationBarLabel.text = @"提现";
    self.view.backgroundColor = rgba(230, 230, 230, 1);
    
    [self creatUI];
    // 默认选择一下第一个
    [self tableView:self.contentTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self availaBlance];
    [self loadMyCashData];
}


- (void)creatUI {
    [self contentTableView];
    [self headerBGView];
    [self cashValueLabel];
    [self tableViewFooter];
    [self noticeLabel];
    [self confireBtn];
    
    //
//    [self loadData];
}

#pragma mark 加载我的可提现余额中
- (void)loadMyCashData {
    NSString *url = [NSString stringWithFormat:@"%@/account/withdrawalAmount", APIPREFIX];
    NSDictionary *para = [self getMyPara];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        // 加载银行卡
        [self loadData];
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        // 错误处理方法
        [self errorDealWithOperation:operation];
        // 加载银行卡
        [self loadData];
    }];
}

- (NSDictionary *)getMyPara {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        // 更新余额
        self.cash = [data[@"withdrawalAmount"] doubleValue];
        self.withdrawalDescribe=data[@"withdrawalDescribe"];
        
        

        
        CGFloat commentH = [Helper heightOfString:self.withdrawalDescribe font:[UIFont systemFontOfSize:KHeight(15)] width:self.tableViewFooter.width - W(40)];
        _noticeLabel.frame = CGRectMake(X(20), Y(44), self.tableViewFooter.width - W(40), commentH);
        _noticeLabel.text = self.withdrawalDescribe;

        _confireBtn.frame = CGRectMake(X(12), self.noticeLabel.maxY + Y(44), self.tableViewFooter.width - X(24), H(50));
        
//        _noticeLabel.text = self.withdrawalDescribe;
        [self availaBlance];
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
    }
}

#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger errorData = operation.response.statusCode;
    NSLog(@"%zi",operation.response.statusCode);
    if (errorData == 401) {
        // 401错误处理
        [DSYUtils showResponseError_401_ForViewController:self];
    } else if (errorData == 404) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
            [self pushToLoginController];
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}


#pragma mark 加载所有的银行卡
- (void)loadData {
    // 先进行默认设置
    [self availaBlance];
    
    [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
        // 更新完毕后再进行设置
        [self availaBlance];
        
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.pageNum],@"pageSize":[NSNumber numberWithInteger:100]};
        
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.pageNum],@"pageSize":[NSNumber numberWithInteger:100],@"sign":sign};
        
        [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/bankAccounts",APIPREFIX] parameters:para success:^(id data) {
            [MBProgressHUD hideHUDForView:self.view];
            
            // 如果为初始请求数据
            if (self.pageNum == 1) {
                [self.dataList removeAllObjects];
            }
            
            id backData = LYDJSONSerialization(data);
            NSLog(@"%@",backData);
            NSInteger statusCode = [backData[@"code"] integerValue];
            if (statusCode == 200) {
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
                    [self initSelectIndex];
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
            NSInteger code = [[response valueForKey:@"code"] integerValue];
            NSLog(@"%@",response);
            if (code == 401) {
                [DSYUtils showResponseError_401_ForViewController:self];
            } else if (code == 404) {
                [DSYUtils showResponseError_404_ForViewController:self message:@"您未曾添加银行卡，请添加" okHandler:^(UIAlertAction *action) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } cancelHandler:^(UIAlertAction *action) {
                    
                }];
            } else {
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
            }
        }];
    }];
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataList;
}

/**
 * 显示可用余额
 */
- (void)availaBlance {
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] init];
    NSAttributedString *firstStr = [[NSAttributedString alloc] initWithString:@"￥" attributes:@{NSForegroundColorAttributeName:ORANGECOLOR, NSFontAttributeName:DSY_NORMALFONT_18}];
    
//    NSString *showAllInvest = [NSString stringWithFormat:@"%.2f", [DSYAccount sharedDSYAccount].availableBalance];
    
    CGFloat cash = self.cash;
    if (cash < 0) {
        cash = 0;
    }
    
    NSString *showAllInvest = [NSString stringWithFormat:@"%.2f", cash];
    NSAttributedString *secondStr = [[NSAttributedString alloc] initWithString:showAllInvest attributes:@{NSForegroundColorAttributeName:ORANGECOLOR, NSFontAttributeName:[UIFont systemFontOfSize:W(36.0f) weight:UIFontWeightSemibold]}];
    [attributeText appendAttributedString:firstStr];
    [attributeText appendAttributedString:secondStr];
    self.cashValueLabel.attributedText = attributeText;
}


#pragma mark - property的getter方法(懒加载)
#pragma mark headerBGView的创建
- (UIView *)headerBGView {
    if (!_headerBGView) {
        _headerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, H(110))];
//        [self.view addSubview:_headerBGView];
        self.contentTableView.tableHeaderView = _headerBGView;
        _headerBGView.backgroundColor = [UIColor whiteColor];
    }
    return _headerBGView;
}

#pragma mark cashValueLabel的创建
- (UILabel *)cashValueLabel {
    if (!_cashValueLabel) {
        
        UILabel *cashShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Y(15), self.headerBGView.width, H(20))];
        [self.headerBGView addSubview:cashShowLabel];
        cashShowLabel.text = @"可提现金额";
        cashShowLabel.textColor = rgba(67, 67, 67, 1);
        cashShowLabel.font = [UIFont systemFontOfSize:W(15.0f)];
        cashShowLabel.textAlignment = NSTextAlignmentCenter;
        
        _cashValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cashShowLabel.maxY, self.headerBGView.width, self.headerBGView.height - cashShowLabel.maxY)];
        [self.headerBGView addSubview:_cashValueLabel];
        _cashValueLabel.text = @"￥00.00";
        
        _cashValueLabel.textColor = ORANGECOLOR;
        _cashValueLabel.font = [UIFont systemFontOfSize:W(36.0f) weight:UIFontWeightBold];
        _cashValueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cashValueLabel;
}

#pragma mark contentTableView的创建
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Y(0), kSCREENW, self.view.height) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_contentTableView];
        _contentTableView.rowHeight = H(44);
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        
        _contentTableView.backgroundColor = rgba(235, 235, 234, 1);
        
        _contentTableView.bounces = NO;
        //        _contentTableView.numberOfSections = 1;
//        _contentTableView.separatorColor = [UIColor grayColor];
        _contentTableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0); // 设置端距，这里表示separator离左边和右边均0像素
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _contentTableView;
}
#pragma mark tableViewfooter的创建
- (UIView *)tableViewFooter {
    if (!_tableViewFooter) {
        _tableViewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(350))];
        self.contentTableView.tableFooterView = _tableViewFooter;
//        _tableViewFooter.backgroundColor = [UIColor redColor];
        // 友情提示
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X(20), 0, _tableViewFooter.width - X(40), H(23))];
        label.text = @"手续费: 1.0元/笔";
        label.textColor = rgba(211, 48, 36, 1);
        label.font = DSY_NORMALFONT_13;
        label.textAlignment = NSTextAlignmentRight;
        [_tableViewFooter addSubview:label];
    }
    return _tableViewFooter;
}

#pragma mark noticeLabel的创建
- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        
        

        
        
        
       //_noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(20), Y(44), self.tableViewFooter.width - W(40), H(50))];
        _noticeLabel = [[UILabel alloc] init];
        
        
        
//        NSString *strtttt=@"温馨提示:1. 零用贷提现规则为T+1个工作日到账，周末及节假日顺延,\n即工作日24:00前申请提现,下一个工作日到账,具体到账时间以银行为准,不同银行到账时间不一致;\n2. 用户当天通过网银方式或快捷方式充值，当天均不支持提现,需次日才可以进行提现(注:当天可提现金额=账户可用余额-当天充值金额).";
//        
        CGFloat commentH = [Helper heightOfString:self.withdrawalDescribe font:[UIFont systemFontOfSize:KHeight(15)] width:self.tableViewFooter.width - W(40)];
        _noticeLabel.frame = CGRectMake(X(20), Y(44), self.tableViewFooter.width - W(40), commentH);
        _noticeLabel.text = self.withdrawalDescribe;
        
        
        
        [self.tableViewFooter addSubview:_noticeLabel];

        NSUInteger tempInterval = [NSDate date].timeIntervalSince1970 + 2 * 60 * 60;
        NSString *dateStr = [[NSDate dateWithTimeIntervalSince1970:tempInterval] getDateStringWithFormatterStr:@"yyyy-MM-dd hh:mm"];
        
//        _noticeLabel.text = [NSString stringWithFormat:@"实际到账: 0.00元，预计%@点钱到账（因银行限制，双休日及法定节假日的提现到账日期顺延）", dateStr];
       // _noticeLabel.text = self.withdrawalDescribe;
        
        
        _noticeLabel.textColor = rgba(194, 183, 176, 1);
        _noticeLabel.font = [UIFont systemFontOfSize:KHeight(15)];
        _noticeLabel.numberOfLines = 0;
        //_noticeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noticeLabel;
}

#pragma mark confireBtn的创建
- (UIButton *)confireBtn {
    if (!_confireBtn) {
        
        _confireBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.tableViewFooter addSubview:_confireBtn];
        _confireBtn.frame = CGRectMake(X(12), self.noticeLabel.maxY + Y(44), self.tableViewFooter.width - X(24), H(50));
        [_confireBtn setTitle:@"确认提现" forState:(UIControlStateNormal)];
        [_confireBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _confireBtn.layer.cornerRadius = X(3);
        _confireBtn.backgroundColor = ORANGECOLOR;
        
        [_confireBtn addTarget:self action:@selector(rechargeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _confireBtn;
}




#pragma mark - contentTableView的Datasource和Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        static NSString *ID = @"defaultTableViewValue1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
            cell.textLabel.font = DSY_NORMALFONT_14;
            cell.detailTextLabel.font = DSY_NORMALFONT_14;
            cell.detailTextLabel.textColor = kTextColorGray_153;
        }
        
        DSYBankModel *bank = self.dataList[indexPath.row];

        cell.textLabel.text = [NSString stringWithFormat:@"%@  尾号%@", bank.bankCode, [bank.account substringFromIndex:bank.account.length - 4]];

        if (self.currentSelectIndex == indexPath.row) {
            cell.imageView.image = DSYImage(@"account_bank_card_activite.png");
        } else {
            cell.imageView.image = DSYImage(@"account_bank_card_icon.png");
        }
        
        if (bank.isDefault == YES) {
            cell.detailTextLabel.text = @"默认";
        } else {
            cell.detailTextLabel.text = nil;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else {
        
        static NSString *ID = @"staticField";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X(18), 0, W(0), cell.contentView.height)];
            [cell.contentView addSubview:label];
            label.text = @"提现金额: ";
            label.font = DSY_NORMALFONT_14;
            [label fixSingleWidth];
            
            UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(label.maxX + W(5), 0, cell.contentView.width - label.maxX - W(10), cell.contentView.height)];
            [cell.contentView addSubview:inputField];
            self.inputCashField = inputField;
            inputField.placeholder = @"￥100.00";
            inputField.font = DSY_NORMALFONT_14;
            inputField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            inputField.delegate=self;
//            [cell layoutSubviews];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            if([textField.text length] == 0){
                if(single == '.') {
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataList.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return Y(7);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", self.inputCashField.text);
    if (indexPath.section == 0) {
        self.currentSelectIndex = indexPath.row;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.imageView.image = DSYImage(@"account_bank_card_activite.png");
        [self.contentTableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.imageView.image = DSYImage(@"account_bank_card_icon.png");
    }
}

#pragma mark - 查找到默认卡
- (void)initSelectIndex {
    NSInteger i = 0;
    for (DSYBankModel *bank in self.dataList) {
        if (bank.isDefault == YES) {
            self.currentSelectIndex = i;
            break;
        }
        i++;
    }
    if (i >= self.dataList.count) {
        self.currentSelectIndex = 0;
    }
}

#pragma mark - 确认提现按钮的点击方法
- (void)rechargeAction:(UIButton *)sender {
    // 如果输入过多(充值金额大于可用余额)
//    [DSYAccount sharedDSYAccount].availableBalance = 10000.0;
    self.inputCashField.text = [self.inputCashField.text stringDeleteBlank];
    NSLog(@"%@", self.inputCashField.text);
    
    if (self.inputCashField.text.length <= 0) {
        [MBProgressHUD showError:@"请输入提现金额" toView:self.view];
        return;
    }
    
    if ([self.inputCashField.text doubleValue] < 100) {
        [MBProgressHUD showError:@"至少提现100" toView:self.view];
        return;
    }
    
    if ([self.inputCashField.text doubleValue] > self.cash) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"您现在最高能提现%.2f元", self.cash] toView:self.view];
        return;
    }
    if (self.dataList.count <= 0) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"您未曾添加银行卡，请添加" okHandler:^(UIAlertAction *action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } cancelHandler:^(UIAlertAction *action) {
        }];
        return;
    }
    
    // 如若没有开户，进行开户
    if ([DSYAccount sharedDSYAccount].ipsAccount.length <= 0) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"用户未开户，请进行开户" okHandler:^(UIAlertAction *action) {
            DSYOpenAccountController *openAccountVC = [[DSYOpenAccountController alloc] init];
            [self.navigationController pushViewController:openAccountVC animated:YES];
        } cancelHandler:^(UIAlertAction *action) {
        }];
        return;
    }
    
    DSYBankModel *bank = self.dataList[self.currentSelectIndex];
    
    NSInteger countId = [bank.cardId integerValue];
    
    DSYCashViewController *cashVC = [[DSYCashViewController alloc] init];
    cashVC.amount = [self.inputCashField.text doubleValue];
    cashVC.bankAccountId = countId;
    [self.navigationController pushViewController:cashVC animated:YES];
    
//    NSString *timestamp = [LYDTool createTimeStamp];
//    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"bankAccountId": @(countId), @"amount": @([self.inputCashField.text integerValue])};
//    
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"bankAccountId": @(countId), @"amount": @([self.inputCashField.text integerValue]), @"sign":sign};
//    
//    [MBProgressHUD showMessage:@"正在提现..." toView:self.view];
//    
//    [LYDTool sendPostWithUrl:[NSString stringWithFormat:@"%@/account/withdrawal", APIPREFIX] parameters:para success:^(id data) {
//        [MBProgressHUD hideHUDForView:self.view];
//        id backData = LYDJSONSerialization(data);
//        NSLog(@"%@", backData);
////        // 提现成功后
////        [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
////            [MBProgressHUD hideHUDForView:self.view];
////            [self availaBlance];
////            [MBProgressHUD showSuccess:@"成功充值" toView:self.view];
////        }];
//        
//        if ([backData[@"code"] integerValue] == 200) {
//            [MBProgressHUD showSuccess:@"提现成功..." toView:self.view];
//            
//            NSUInteger tempInterval = [NSDate date].timeIntervalSince1970 + 2 * 60 * 60;
//            NSString *dateStr = [[NSDate dateWithTimeIntervalSince1970:tempInterval] getDateStringWithFormatterStr:@"yyyy-MM-dd hh:mm"];
//            
//            self.noticeLabel.text = [NSString stringWithFormat:@"实际到账: %.2f元，预计%@点钱到账（因银行限制，双休日及法定节假日的提现到账日期顺延）", [self.inputCashField.text integerValue] - 1.0, dateStr];
//            
//            // 提现成功后
//            [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
//                [MBProgressHUD hideHUDForView:self.view];
//                [self availaBlance];
//                [MBProgressHUD showSuccess:@"成功充值" toView:self.view];
//            }];
//            
//        } else {
//            [MBProgressHUD showError:@"提现失败..." toView:self.view];
//        }
//     
//    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//        [MBProgressHUD hideHUDForView:self.view];
//        id errorObject = LYDJSONSerialization(operation.responseObject);
//        NSLog(@"%@", errorObject);
//        
//        NSInteger statusCode = [errorObject[@"code"] integerValue];
//        
//        if (statusCode == 401) {
//            [DSYUtils showResponseError_401_ForViewController:self];
//        } else if (statusCode == 404) {
//            [DSYUtils showResponseError_404_ForViewController:self message:@"您未曾添加银行卡，请添加" okHandler:^(UIAlertAction *action) {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            } cancelHandler:^(UIAlertAction *action) {
//                
//            }];
//        } else if (statusCode == 201) {
//            
//        } else {
//            XYErrorHud *hud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//            [self.view.window addSubview:hud];
//        }
//        
//    }];
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
