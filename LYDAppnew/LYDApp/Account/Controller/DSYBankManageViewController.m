//
//  DSYBankManageViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBankManageViewController.h"
#import "DSYAccountBankTableViewCell.h"
#import "DSYAlertViewController.h"

#import "DSYBankModel.h"

#define kDSYTextColorGray_102 rgba(102, 102, 102, 1)

@interface DSYBankManageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *switchBgView;
@property (nonatomic, strong) UIImageView *switchBtn;   /**< 开关控件 */
@property (nonatomic, strong) UILabel *noticeLabel;  /**< 提示 */
@property (nonatomic, strong) UIButton *deleteBtn;   /**< 删除按钮 */

@property (nonatomic, assign) BOOL successfull;

@property (nonatomic, strong) DSYAlertViewController *alertVC;

@end

@implementation DSYBankManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"银行卡管理";
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    
    [self contentTableView];
    
    [self footerView];
    [self switchBgView];
    [self noticeLabel];
    [self switchBtn];
    [self deleteBtn];
    
    
    [self alertVC];
    
    [self loadData];
}

- (void)loadData {
    if (self.myBank.isDefault == 1) {
        self.noticeLabel.text = @"此卡为默认提现卡";
        [UIView animateWithDuration:0.2 animations:^{
            self.switchBtn.image = DSYImage(@"account_bank_switch_on.png");
        }];
    } else {
        self.noticeLabel.text = @"将此卡设置为默认提现卡";
        [UIView animateWithDuration:0.2 animations:^{
            self.switchBtn.image = DSYImage(@"account_bank_switch_off.png");
        }];
    }
    
    [self.contentTableView reloadData];
}

#pragma mark - property的getter方法(属性控件的创建，懒加载方式)
#pragma mark contentTableView的创建------------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, self.view.height)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.rowHeight = H(125);
        _contentTableView.backgroundColor = rgba(249, 249, 249, 1);
    }
    return _contentTableView;
}

#pragma mark footerView的创建------------
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, H(150))];
        self.contentTableView.tableFooterView = _footerView;
        _footerView.backgroundColor = rgba(249, 249, 249, 1);
        
    }
    return _footerView;
}


#pragma mark switchBgView的创建------------
- (UIView *)switchBgView {
    if (!_switchBgView) {
        _switchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, Y(6), self.footerView.width, H(44))];
        [self.footerView addSubview:_switchBgView];
        _switchBgView.backgroundColor = [UIColor whiteColor];
        
        [self creatSolidLineWithFrame:CGRectMake(0, 0, _switchBgView.width, H(0.5)) toView:_switchBgView];
        [self creatSolidLineWithFrame:CGRectMake(0, _switchBgView.height - H(0.5), _switchBgView.width, H(0.5)) toView:_switchBgView];
    }
    return _switchBgView;
}

#pragma mark s的创建------------
- (UIImageView *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UIImageView alloc] initWithFrame:CGRectMake(self.switchBgView.width - W(55 + 12), 0, W(55), H(25))];
        [self.switchBgView addSubview:_switchBtn];
//        _switchBtn.transform = CGAffineTransformMakeScale(1.2, .75);
        _switchBtn.centerY = self.switchBgView.height / 2;
        _switchBtn.centerX = self.switchBgView.width - _switchBtn.width / 2 - X(12);
        _switchBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchBtnClicked:)];
        [_switchBtn addGestureRecognizer:tap];
    }
    return _switchBtn;
}

#pragma mark noticeLabel的创建------------
- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(12), 0, self.switchBtn.x - X(12), self.switchBgView.height)];
        [self.switchBgView addSubview:_noticeLabel];
        _noticeLabel.font = DSY_NORMALFONT_13;
        _noticeLabel.textColor = kDSYTextColorGray_102;
    }
    return _noticeLabel;
}

#pragma mark deleteBtn的创建------------
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.footerView addSubview:_deleteBtn];
        
        _deleteBtn.frame = CGRectMake(0, Y(23) + self.switchBgView.maxY, W(270), H(44));
        _deleteBtn.backgroundColor = ORANGECOLOR;
        _deleteBtn.centerX = self.switchBgView.width / 2;
        _deleteBtn.layer.cornerRadius = X(3);
        _deleteBtn.titleLabel.font = DSY_NORMALFONT_16;
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        
        [_deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}

- (DSYAlertViewController *)alertVC {
    if (!_alertVC) {
        _alertVC = [[DSYAlertViewController alloc] initWithMessage:@"确认删除吗?" oKBlock:^(UIViewController *vc) {
            [self startRequestOfDelete];
        } cancelBlock:^(UIViewController *vc) {
           
        } dismissBlock:^(UIViewController *vc) {
            [UIView animateWithDuration:0.1 animations:^{
                vc.view.y = kSCREENH;
            }];
        }];
//        [self addChildViewController:_alertVC];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_alertVC.view];
        _alertVC.view.frame = CGRectMake(0, kSCREENH, kSCREENW, kSCREENH);
    }
    return _alertVC;
}

- (void)startRequestOfDelete {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"bankAccountId":self.myBank.cardId};
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *paramDic = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN, @"sign":sign, @"bankAccountId":self.myBank.cardId};
    
    [LYDTool sendDeleteWithUrl:[NSString stringWithFormat:@"%@/account/bankAccounts/%ld", APIPREFIX, [self.myBank.cardId integerValue]] parameters:paramDic success:^(id data) {;
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            [MBProgressHUD showSuccess:@"删除成功!" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    }];
}

#pragma mark - 自定义方法
#pragma mark solidLine的创建
- (void)creatSolidLineWithFrame:(CGRect)frame toView:(UIView *)superView {
    UIView *solidLine = [[UIView alloc] initWithFrame:frame];
    solidLine.backgroundColor = rgba(235, 235, 235, 1);
    
    [superView addSubview:solidLine];
}

#pragma mark  开关按钮的点击事件
- (void)switchBtnClicked:(UITapGestureRecognizer *)tap {
    if (self.myBank.isDefault) {
        [self cacelDefaultBankCard];
    } else {
        [self setDefaultBankCard];
    }
}


- (NSDictionary *)getMyPara {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, };
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign,@"bankAccountId": self.myBank.cardId};
    
    return para;
}


 - (NSString *)getUrl
{
 NSString *timestamp = [LYDTool createTimeStamp];
 NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, };
 // 生成签名认证
 NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
 
 return [NSString stringWithFormat:@"appKey=%@&timestamp=%@&deviceId=%@&token=%@&sign=%@&bankAccountId=%@", APPKEY, timestamp, DEVICEID, TOKEN, sign,self.myBank.cardId];
 }

- (void)setDefaultBankCard {
//    NSString *timestamp = [LYDTool createTimeStamp];
//    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"bankAccountId":self.myBank.cardId};
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *paramDic = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN, @"sign":sign, @"bankAccountId":self.myBank.cardId};
    
    
//    NSString *url = [NSString stringWithFormat:@"%@/account/changePassword?%@", APIPREFIX, [self getUrl]];
    NSString *url = [NSString stringWithFormat:@"%@/account/bankAccounts/default?%@", APIPREFIX,[self getUrl]];
    
    NSDictionary *para = [self getMyPara];
    
    [LYDTool sendPutWithUrl:url parameters:para success:^(id data)
    {
        id backData = LYDJSONSerialization(data);
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            self.myBank.isDefault = YES;
            [self setupMyBank];
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation)
    {
        [MBProgressHUD hideHUDForView:self.view];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    }];
}

- (void)cacelDefaultBankCard {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"bankAccountId":self.myBank.cardId};
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *paramDic = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN, @"sign":sign, @"bankAccountId":self.myBank.cardId};
    NSLog(@"cacelDefaultBankCard:%@",paramDic);
    [LYDTool sendDeleteWithUrl:[NSString stringWithFormat:@"%@/account/bankAccounts/default", APIPREFIX] parameters:paramDic success:^(id data)
     {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            self.myBank.isDefault = NO;
            
            [self setupMyBank];
            
        } else if (statusCode == 600)
        {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else
        {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation)
    {
        [MBProgressHUD hideHUDForView:self.view];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401)
        {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else
        {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    }];
}

- (void)setupMyBank {
    if (self.myBank.isDefault == YES) {
        self.noticeLabel.text = @"此卡为默认提现卡";
        [UIView animateWithDuration:0.2 animations:^{
            self.switchBtn.image = DSYImage(@"account_bank_switch_on.png");
        } completion:^(BOOL finished) {
            [self.contentTableView reloadData];
        }];
    } else {
        self.noticeLabel.text = @"将此卡设置为默认提现卡";
        [UIView animateWithDuration:0.2 animations:^{
            self.switchBtn.image = DSYImage(@"account_bank_switch_off.png");
        } completion:^(BOOL finished) {
            [self.contentTableView reloadData];
        }];
    }
}

#pragma mark 删除按钮的点击事件
- (void)deleteBtnClicked:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.alertVC.view.y = 0;
    }];
}

#pragma mark - contentTableView的dataSource和delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYAccountBankTableViewCell *cell = [DSYAccountBankTableViewCell cellForTableView:tableView];
    if (self.myBank.isDefault == YES) {
        cell.defaultLabel.hidden = NO;
        cell.iconView.image = DSYImage(@"dsy_bank_default.png");
    } else {
        cell.defaultLabel.hidden = YES;
        cell.iconView.image = DSYImage(@"dsy_bank_normal.png");
    }
    
    cell.bankNameLabel.text = self.myBank.bankCode;
    cell.cardNumberLabel.text = [self.myBank.account substringWithRange:NSMakeRange(self.myBank.account.length-4, 4)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return H(2.5);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return H(2.5);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [self.alertVC.view removeFromSuperview];
    self.alertVC = nil;
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
