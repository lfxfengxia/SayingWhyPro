//
//  DSYAccountRechargeController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountRechargeController.h"
#import "DSYAccountBankController.h"    
#import "DSYRechargeViewController.h"
#import "DSYBankLimitModel.h"
#import "DSYBankQuotaCell.h"
#define kMaxAmount 99999999
#define kTextColorGray_102 rgba(102, 102, 102, 1)

@interface DSYAccountRechargeController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *contentTableView; /**< 最底层的视图 */

@property (nonatomic, strong) UIView *rechargeBGView;        /**< 充值的背景视图 */
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UITextField *rechargeField;    /**< 充值的金额 */
@property (nonatomic, strong) UIButton *rechargeBtn;         /**< 立即充值按钮 */

@property (nonatomic, strong) UIImageView *bankMaxChargeImgView; /**< 最下面的图片 */

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation DSYAccountRechargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    
    //
    [self creatUI];
    [self loadData];
}

- (void)creatUI {
    [self contentTableView];
    [self rechargeBGView];
    [self footerView];
    
    [self rechargeField];
    [self rechargeBtn];
    
    [self bankMaxChargeImgView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 网络加载数据
- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@/common/bankQuota", APIPREFIX];
    NSDictionary *parameter = [self getParameter];
    [LYDTool sendGetWithUrl:url parameters:parameter success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorDealWithOperation:operation];
    }];
    
    
}

- (NSDictionary *)getParameter {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, };
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    [self.contentTableView.footer endRefreshing];
    [self.contentTableView.header endRefreshing];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        self.dataList = [DSYBankLimitModel baseModelByArr:data[@"bankQuotaList"]];

        [self.contentTableView reloadData];
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
        // 如果加载数据有问题就让page恢复
    }
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

#pragma mark - property的getter方法（懒加载）
#pragma mark contentTableView的创建---------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.rowHeight = kNormalCellHeight;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contentTableView;
}




#pragma mark rechargeBGView的创建
- (UIView *)rechargeBGView {
    if (!_rechargeBGView) {
        _rechargeBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, H(240))];
        self.contentTableView.tableHeaderView = _rechargeBGView;
    }
    return _rechargeBGView;
}

#pragma mark footerView的创建------------
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, H(58))];
        self.contentTableView.tableFooterView = _footerView;
        
        UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(255, 8, 12) fontOfSystemSize:W(14.0f)];
        [_footerView addSubview:showLabel];
        [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_footerView);
            make.left.equalTo(_footerView.mas_left).with.offset(X(12));
            make.right.equalTo(_footerView.mas_right).with.offset(X(-12));
            make.height.mas_equalTo(kNormalCellHeight);
        }];
        showLabel.textAlignment = NSTextAlignmentLeft;
        showLabel.numberOfLines = 0;
        showLabel.text = @"温馨提示: 如您已通过网银或者柜台在银行限额内自行设定支付额度，请以自行设定支付额度为准";
    }
    return _footerView;
}


#pragma mark rechargeField的创建
- (UITextField *)rechargeField {
    if (!_rechargeField) {
        _rechargeField = [[UITextField alloc] initWithFrame:CGRectMake(X(45), Y(60), self.rechargeBGView.width - X(90), H(44))];
        [self.rechargeBGView addSubview:_rechargeField];
        
        _rechargeField.placeholder = @" ￥100";
        _rechargeField.font = DSY_NORMALFONT_18;
        _rechargeField.layer.cornerRadius = X(2);
        _rechargeField.layer.borderColor = ORANGECOLOR.CGColor;
        _rechargeField.layer.borderWidth = 2;
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, W(87), H(44))];
        leftLabel.text = @"充值金额";
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.font = DSY_NORMALFONT_16;
        _rechargeField.leftViewMode = UITextFieldViewModeAlways;
        _rechargeField.leftView = leftLabel;
        _rechargeField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _rechargeField.delegate=self;
    }
    return _rechargeField;
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
#pragma mark recharBtn的创建
- (UIButton *)rechargeBtn {
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.rechargeBGView addSubview:_rechargeBtn];
        _rechargeBtn.frame = CGRectMake(self.rechargeField.x, self.rechargeField.maxY + Y(18), self.rechargeField.width, self.rechargeField.height);
        _rechargeBtn.backgroundColor = ORANGECOLOR;
        _rechargeBtn.titleLabel.font = DSY_NORMALFONT_18;
        _rechargeBtn.layer.cornerRadius = X(2);
        [_rechargeBtn setTitle:@"立即充值" forState:(UIControlStateNormal)];
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_rechargeBtn addTarget:self action:@selector(rechargeBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(194, 183, 176) fontOfSystemSize:W(18)];
        [self.rechargeBGView addSubview:showLabel];
        [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.rechargeBGView);
            make.height.mas_equalTo(H(34));
        }];
        showLabel.text = @"汇付天下支持银行快捷充值限额表";
    }
    return _rechargeBtn;
}


#pragma mark - contentTableView的DataSource和Delegate
#pragma mark contentTableView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYBankQuotaCell *cell = [DSYBankQuotaCell cellForTableView:tableView];
    
    cell.limit = self.dataList[indexPath.row];
    
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
    
    [self creatLabelsWithTitles:@[@"银行名称", @"卡性质", @"单笔限额", @"单卡单日限额"] forSuperView:labelView];
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

#pragma mark 立即冲值按钮的点击方法
- (void)rechargeBtnClicked:(UIButton *)sender {
    self.rechargeField.text = [self.rechargeField.text stringDeleteBlank];
    if (self.rechargeField.text.length <= 0) {
        [MBProgressHUD showError:@"请输入充值金额" toView:self.view];
        return;
    }
    if ([self.rechargeField.text floatValue] < 100.0) {
        [MBProgressHUD showError:@"至少充值100元" toView:self.view];
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
    
    DSYRechargeViewController *rechargeVC = [[DSYRechargeViewController alloc] init];
    rechargeVC.amount = [self.rechargeField.text floatValue];
    rechargeVC.comeFrom = self.comeFrom;
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
}

#pragma mark - 设置navigationBar的状态
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, 100, 20);
    self.navigationItem.titleView = titleLabel;
    titleLabel.text = @"充值";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[DSYImage(@"back_icon.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;

}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.rechargeField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
