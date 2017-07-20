//
//  DSYBindMobileViewController.m
//  LYDApp
//
//  Created by dai yi on 2017/1/3.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "DSYBindMobileViewController.h"

@interface DSYBindMobileViewController ()

@property (nonatomic, strong) XYMainScrollView  *mainScrollView;    /**< 主要视图 */
@property (nonatomic, strong) UILabel *myNavigationTitle;           /**< 导航的title */

@property (nonatomic, strong) UIImageView   *bgImgView;             /**< 背景视图 */
@property (nonatomic, strong) UIImageView   *logoImgView;           /**< logo */

@property (nonatomic, strong) UIImageView *avatarImgView;    /**< 头像 */
@property (nonatomic, strong) UILabel     *nameLabel;        /**< 昵称 */

@property (nonatomic, strong) XYMainTextField *accountTF;
@property (nonatomic, strong) XYMainTextField *passwordTF;
@property (nonatomic, strong) UIButton *eyeBtn;

@property (nonatomic, strong) UIButton *bindBtn;             /**< 立即绑定按钮 */

@end

@implementation DSYBindMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"账户绑定";
    self.navigationItem.leftBarButtonItem = nil;
    
    
    [self mainScrollView];
    [self bgImgView];
    [self myNavigationTitle];
    [self logoImgView];
    
    [self avatarImgView];
    [self nameLabel];
    
    [self creatMYField];
    [self bindBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
    //    self.navigationController.navigationBar.shadowImage = self.oldNavigationShadowImg;
}


#pragma mark - 创建UI的控件-----------------------------
#pragma mark mainScrollView的创建------------
- (XYMainScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[XYMainScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}
#pragma mark titleNavigationBarLabel的创建------------
- (UILabel *)myNavigationTitle {
    if (!_myNavigationTitle) {
        _myNavigationTitle = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(51, 51, 51) fontOfSystemSize:W(17.0f) isBold:YES];
        [self.view addSubview:_myNavigationTitle];
        [_myNavigationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(20);
            make.height.mas_equalTo(44);
        }];
        _myNavigationTitle.text = @"账户绑定";
    }
    return _myNavigationTitle;
}

#pragma mark logoImgView的创建------------
- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:self.mainScrollView.bounds];
        [self.mainScrollView addSubview:_bgImgView];
        _bgImgView.image = DSYImage(@"LoginBG.png");
        _bgImgView.userInteractionEnabled = YES;
        self.mainScrollView.contentSize = CGSizeMake(0, _bgImgView.maxY);
    }
    return _bgImgView;
}

#pragma mark logoView的创建------------
- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithImage:DSYImage(@"Logo.png")];
        [self.mainScrollView addSubview:_logoImgView];
        _logoImgView.y  = Y(95);
        _logoImgView.centerX = self.bgImgView.width / 2;
    }
    return _logoImgView;
}

#pragma mark avatarImgView的创建------------
- (UIImageView *)avatarImgView {
    if (!_avatarImgView) {
        _avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.logoImgView.maxY + Y(29), W(72), W(72))];
        [self.mainScrollView addSubview:_avatarImgView];
        _avatarImgView.layer.cornerRadius = _avatarImgView.width / 2;
        _avatarImgView.layer.masksToBounds = YES;
        _avatarImgView.centerX = self.bgImgView.width / 2;
        _avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_avatarImgView setImageWithURL:[NSURL URLWithString:self.resp.iconurl] placeholderImage:kPlaceholderImg];
    }
    return _avatarImgView;
}

#pragma mark nameLabel的创建------------
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(X(37.5), self.avatarImgView.maxY, self.bgImgView.width - X(75), H(48)) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(14.0f)];
        [self.mainScrollView addSubview:_nameLabel];
        _nameLabel.text = [NSString stringWithFormat:@"Hi! %@", self.resp.name];
    }
    return _nameLabel;
}

#pragma mark bindBtn的创建------------
- (UIButton *)bindBtn {
    if (!_bindBtn) {
        _bindBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.mainScrollView addSubview:_bindBtn];
        [_bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.passwordTF.mas_left).with.offset(0);
            make.right.equalTo(self.passwordTF.mas_right).with.offset(0);
            make.top.equalTo(self.passwordTF.mas_bottom).with.offset(Y(60));
            make.height.mas_equalTo(kNormalCellHeight);
        }];
        _bindBtn.backgroundColor = ORANGECOLOR;
        [_bindBtn setTitle:@"立即绑定" forState:(UIControlStateNormal)];
        [_bindBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _bindBtn.layer.cornerRadius = X(3.0);
        
        [_bindBtn addTarget:self action:@selector(bindBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _bindBtn;
}

#pragma mark - 创建输入框架
- (void)creatMYField {
    self.accountTF = [[XYMainTextField alloc] initWithFrame:CGRectMake(KWidth(37), self.avatarImgView.maxY + KHeight(55), KWidth(300), KHeight(40)) andLeftTitle:@"账号" andLeftFrame:CGRectMake(0, 0, KWidth(50), KHeight(40)) andPlaceHolder:@"请输入手机号或用户名"];
    self.accountTF.font = [UIFont systemFontOfSize:KHeight(15)];
    [self.mainScrollView addSubview:self.accountTF];
    self.accountTF.text = [DSYAccount sharedDSYAccount].mobile;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(self.accountTF.x, self.accountTF.maxY - 1, self.accountTF.width, 1)];
    line1.backgroundColor = [UIColor colorWithRed:0.78 green:0.74 blue:0.71 alpha:1.00];
    [self.mainScrollView addSubview:line1];
    
    self.passwordTF = [[XYMainTextField alloc] initWithFrame:CGRectMake(self.accountTF.x, self.accountTF.maxY + KHeight(10), self.accountTF.width, self.accountTF.height) andLeftTitle:@"密码" andLeftFrame:CGRectMake(0, 0, KWidth(50), KHeight(40)) andPlaceHolder:@"请输入6-16位数字加字母"];
    self.passwordTF.font = [UIFont systemFontOfSize:KHeight(15)];
    self.passwordTF.secureTextEntry = YES;
    [self.mainScrollView addSubview:self.passwordTF];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.passwordTF.x, self.passwordTF.maxY - 1, self.passwordTF.width, 1)];
    line2.backgroundColor = [UIColor colorWithRed:0.78 green:0.74 blue:0.71 alpha:1.00];
    [self.mainScrollView addSubview:line2];
    
    self.eyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.passwordTF.maxX - KWidth(23), self.passwordTF.y + (self.passwordTF.height - KHeight(18)) / 2, KWidth(23), KHeight(18))];
    [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"closeEye"] forState:UIControlStateNormal];
    [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateSelected];
    [self.eyeBtn addTarget:self action:@selector(eyeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.eyeBtn];
}


#pragma mark - 自定义方法----------
- (void)eyeBtnClicked:(UIButton *)button
{
    button.selected = !button.selected;
    
    self.passwordTF.secureTextEntry = !self.passwordTF.secureTextEntry;
}

- (void)bindBtnClicked:(UIButton *)sender {
    self.accountTF.text =  [self.accountTF.text stringDeleteBlank];
    self.passwordTF.text = [self.passwordTF.text stringDeleteBlank];
    if (self.accountTF.text.length == 0) {
        [self alertWithMessage:@"请输入手机号"];
        return;
    } else if (![Helper justMobile:self.accountTF.text]) {
        [self alertWithMessage:@"请输入正确的手机号"];
        return;
    } else if (self.passwordTF.text.length == 0) {
        [self alertWithMessage:@"请输入密码"];
        return;
    } else if (self.passwordTF.text.length < 6 || self.passwordTF.text.length > 16) {
        [self alertWithMessage:@"请输入6-16位密码"];
        return;
    } else if (![self checkPassword]) {
        [self alertWithMessage:@"请输入数字、字母或数字和字母的组合"];
        return;
    }

    NSLog(@"立即绑定");
    NSString *url = [NSString stringWithFormat:@"%@/passport/weixinLoginBind", APIPREFIX];
    [MBProgressHUD showMessage:@"正在登录..." toView:self.view];
    [LYDTool sendGetWithUrl:url parameters:[self getParameterWithOpenId:self.resp.openid unionId:self.resp.uid] success:^(id data) {
        //
        [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successHandleWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorHandleWithOperation:operation];
    }];
}


#pragma mark  三方登录的参数
- (NSDictionary *)getParameterWithOpenId:(NSString *)openId unionId:(NSString *)unionId  {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"openId":openId, @"unionId":unionId, @"mobile":self.accountTF.text, @"password":self.passwordTF.text};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"openId":openId, @"unionId":unionId, @"mobile":self.accountTF.text, @"password":self.passwordTF.text, @"sign":sign};
    return para;
}

#pragma mark 成功处理
- (void)successHandleWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    if ([[data valueForKey:@"code"] integerValue] == 200) {
        UserDefaultsWriteObj([data valueForKey:@"token"], @"access-token");
        // 如果登录成功的话就必须将account信息制空
        [[DSYAccount sharedDSYAccount] clean];
        
        [[DSYUser sharedDSYUser] setValuesForKeysWithDictionary:data[@"user"]];
        [[DSYUser sharedDSYUser] saveUserUserToSanbox];
        UserDefaultsSynchronize;
        // 登录成功后更新账户信息
        [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
            [UIApplication sharedApplication].keyWindow.rootViewController = [[XYMainTabBarController alloc] init];
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[data valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}

#pragma mark 错误处理
- (void)errorHandleWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    id response = LYDJSONSerialization(operation.responseObject);
    NSLog(@"%@",response);
    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
    [self.view.window addSubview:errorHud];
}

#pragma mark - 判断输入的是否只有数字和字母
- (BOOL)checkPassword {
    NSString *mystring = self.passwordTF.text;
    NSString *regex = @"^[0-9A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:mystring];
}

- (void)alertWithMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:alertAC];
    [self presentViewController:alertVC animated:YES completion:nil];
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
