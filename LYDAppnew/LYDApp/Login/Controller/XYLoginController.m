//
//  XYLoginController.m
//  LYDApp
//
//  Created by dookay_73 on 16/10/31.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYLoginController.h"
#import "XYRegisterController.h"
#import "XYForgotController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "DSYBindAccountController.h"

@interface XYLoginController ()

@property (nonatomic, strong) XYMainScrollView  *mainSV;
@property (nonatomic, strong) UIImageView   *bgIV;
@property (nonatomic, strong) UIImageView   *logoIV;
@property (nonatomic, strong) XYMainTextField   *accountTF;
@property (nonatomic, strong) XYMainTextField   *passwordTF;
@property (nonatomic, strong) UIButton      *eyeBtn;
@property (nonatomic, strong) UIButton      *forgotBtn;
@property (nonatomic, strong) UIButton      *loginBtn;
@property (nonatomic, strong) UIButton      *registBtn;
@property (nonatomic, strong) UIView        *thirdLoginView;
@property (nonatomic, strong) UILabel       *thirdLabel;
@property (nonatomic, strong) UIButton      *qqBtn;
@property (nonatomic, strong) UIButton      *wechatBtn;
@property (nonatomic, strong) UIButton      *weiboBtn;


@end

@implementation XYLoginController



- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
     self.navigationItem.title=@"登录";
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
//    if ([TOKEN length] != 0) {
//        [self.navigationController popViewControllerAnimated:NO];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
//    self.hidesBottomBarWhenPushed = YES;
}

- (void)createUI
{
    self.mainSV = [[XYMainScrollView alloc] initWithFrame:self.view.bounds];
    self.mainSV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainSV];
    
    self.bgIV = [[UIImageView alloc] initWithFrame:self.mainSV.bounds];
    self.bgIV.image = [UIImage imageNamed:@"LoginBG"];
    [self.mainSV addSubview:self.bgIV];
    
    self.backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.backBtn.frame = CGRectMake(X(12), KHeight(31), W(50), H(22));
    [self.backBtn setImage:DSYImage(@"back_icon.png") forState:(UIControlStateNormal)];
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, W(12.5));
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    if (self.hiddenBackBtn == YES) {
        self.backBtn.hidden = YES;
    } else {
        self.backBtn.hidden = NO;
    }
    [self.mainSV addSubview:self.backBtn];
    
    self.logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(130), KHeight(111), KWidth(116), KHeight(75))];
    self.logoIV.image = [UIImage imageNamed:@"Logo"];
    [self.mainSV addSubview:self.logoIV];
    
    self.accountTF = [[XYMainTextField alloc] initWithFrame:CGRectMake(KWidth(37), self.logoIV.maxY + KHeight(47), KWidth(300), KHeight(40)) andLeftTitle:@"账号" andLeftFrame:CGRectMake(0, 0, KWidth(50), KHeight(40)) andPlaceHolder:@"请输入手机号或用户名"];
    self.accountTF.font = [UIFont systemFontOfSize:KHeight(12)];
    [self.mainSV addSubview:self.accountTF];
    self.accountTF.text = [DSYAccount sharedDSYAccount].mobile;
    NSString *accountString=[[NSUserDefaults standardUserDefaults] objectForKey:@"accountTF"];
    if (accountString.length!=0)
    {
        self.accountTF.text=accountString;
    }
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(self.accountTF.x, self.accountTF.maxY - 1, self.accountTF.width, 1)];
    line1.backgroundColor = [UIColor colorWithRed:0.78 green:0.74 blue:0.71 alpha:1.00];
    [self.mainSV addSubview:line1];
    
    self.passwordTF = [[XYMainTextField alloc] initWithFrame:CGRectMake(self.accountTF.x, self.accountTF.maxY + KHeight(10), self.accountTF.width, self.accountTF.height) andLeftTitle:@"密码" andLeftFrame:CGRectMake(0, 0, KWidth(50), KHeight(40)) andPlaceHolder:@"请输入您的密码"];
    self.passwordTF.font = [UIFont systemFontOfSize:KHeight(12)];
    self.passwordTF.secureTextEntry = YES;
    [self.mainSV addSubview:self.passwordTF];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.passwordTF.x, self.passwordTF.maxY - 1, self.passwordTF.width, 1)];
    line2.backgroundColor = [UIColor colorWithRed:0.78 green:0.74 blue:0.71 alpha:1.00];
    [self.mainSV addSubview:line2];
    
    self.eyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.passwordTF.maxX - KWidth(23), self.passwordTF.y + (self.passwordTF.height - KHeight(18)) / 2, KWidth(23), KHeight(18))];
    [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"closeEye"] forState:UIControlStateNormal];
    [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateSelected];
    [self.eyeBtn addTarget:self action:@selector(eyeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainSV addSubview:self.eyeBtn];
    
    self.forgotBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.passwordTF.maxX - KWidth(64), line2.maxY + KHeight(15), KWidth(64), KHeight(13))];
    [self.forgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.forgotBtn setTitleColor:TEXTGARY forState:UIControlStateNormal];
    self.forgotBtn.titleLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    [self.forgotBtn addTarget:self action:@selector(forgotBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainSV addSubview:self.forgotBtn];
    
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.passwordTF.x, self.forgotBtn.maxY + KHeight(28), KWidth(300), KHeight(44))];
    [self.loginBtn setBackgroundColor:ORANGECOLOR];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.layer.cornerRadius = 2.0f;
    self.loginBtn.layer.masksToBounds = YES;
    [self.mainSV addSubview:self.loginBtn];
    
    self.registBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWidth(145), self.loginBtn.maxY + KHeight(16), KWidth(86), KHeight(16))];
    [self.registBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    [self.registBtn setTitleColor:ORANGECOLOR forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:KHeight(16)];
    [self.mainSV addSubview:self.registBtn];
    
//    self.thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.registBtn.maxY + KHeight(42), kSCREENW - 20, KHeight(13))];
//    self.thirdLabel.textColor = TEXTBLACK;
//    self.thirdLabel.textAlignment = NSTextAlignmentCenter;
//    self.thirdLabel.text= @"使用第三方账号登录";
//    self.thirdLabel.font = [UIFont systemFontOfSize:KHeight(13.0)];
//    [self.mainSV addSubview:self.thirdLabel];
//    
//    self.qqBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWidth(186/2), self.thirdLabel.maxY + KHeight(22), KWidth(98/2), KHeight(98/2))];
//    [self.qqBtn setBackgroundImage:[UIImage imageNamed:@"qqLogin"] forState:UIControlStateNormal];
//    [self.qqBtn addTarget:self action:@selector(qqBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.mainSV addSubview:self.qqBtn];
//    
//    self.wechatBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.qqBtn.maxX + KWidth(21), self.qqBtn.y, KWidth(98/2), KHeight(98/2))];
//    [self.wechatBtn setBackgroundImage:[UIImage imageNamed:@"wechatLogin"] forState:UIControlStateNormal];
//    [self.wechatBtn addTarget:self action:@selector(wechatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.mainSV addSubview:self.wechatBtn];
//    
//    self.weiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.wechatBtn.maxX + KWidth(21), self.wechatBtn.y, KWidth(98/2), KHeight(98/2))];
//    [self.weiboBtn setBackgroundImage:[UIImage imageNamed:@"weiboLogin"] forState:UIControlStateNormal];
//    [self.weiboBtn addTarget:self action:@selector(weiboBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.mainSV addSubview:self.weiboBtn];
//    
//    self.mainSV.contentSize = CGSizeMake(0, self.weiboBtn.maxY + 10);
//    
//    self.qqBtn.hidden = YES;
//    self.weiboBtn.hidden = YES;
}
#pragma mark - 按钮点击事件

- (void)back
{
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)eyeBtnClicked:(UIButton *)button
{
    button.selected = !button.selected;
    
    self.passwordTF.secureTextEntry = !self.passwordTF.secureTextEntry;
}

- (void)forgotBtnClicked:(UIButton *)button
{
    XYForgotController *forgotVC = [[XYForgotController alloc] init];
    forgotVC.hidesBottomBarWhenPushed = YES;
    forgotVC.userName = self.accountTF.text;
    [self.navigationController pushViewController:forgotVC animated:YES];
}

- (void)loginBtnClicked:(UIButton *)button
{
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
    }
//    else if (![self checkPassword]) {
//        [self alertWithMessage:@"请输入包含数字和字母的6-16位密码"];
//        return;
//    }
    else {
        NSString *tt=[[NSUserDefaults standardUserDefaults] stringForKey:@"strDeviceToken"];
        
        if (tt.length == 0)
        {
            NSLog(@"tt:%@",tt);
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-通知中允许“零用贷理财”发送通知,以防错过重要提示!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
           
            tt=@"";
        }
        
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.accountTF.text,@"password":self.passwordTF.text,@"deviceToken":tt};
        
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.accountTF.text,@"password":self.passwordTF.text,@"deviceToken":tt,@"sign":sign};
        NSString *url = [NSString stringWithFormat:@"%@/passport/login",APIPREFIX];
        NSLog(@"%@", url);
        
        [MBProgressHUD showMessage:@"正在登录" toView:self.view];
        [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
            [MBProgressHUD hideHUDForView:self.view];
            
            id backData = LYDJSONSerialization(data);
            NSLog(@"%@",backData);
            
            if ([[backData valueForKey:@"code"] integerValue] == 200) {
                UserDefaultsWriteObj([backData valueForKey:@"token"], @"access-token");
                [[NSUserDefaults standardUserDefaults] setObject:self.accountTF.text forKey:@"accountTF"];
                // 如果登录成功的话就必须将account信息制空
                [[DSYAccount sharedDSYAccount] clean];
                
                [[DSYUser sharedDSYUser] setValuesForKeysWithDictionary:backData[@"user"]];
                [[DSYUser sharedDSYUser] saveUserUserToSanbox];
                UserDefaultsSynchronize;
                // 登录成功后更新账户信息
                [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
                    if ([self.comefromModifyPassword isEqualToString:@"modifyPassword"]) {
                        [UIApplication sharedApplication].keyWindow.rootViewController = [[XYMainTabBarController alloc] init];
                    }
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                
            } else {
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
            }
            
        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
            [MBProgressHUD hideHUDForView:self.view];
            
            id response = LYDJSONSerialization(operation.responseObject);
            NSLog(@"%@",response);
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }];
    }
    
    
   
}

- (NSDictionary *)getParameter {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.accountTF.text,@"password":self.passwordTF.text};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.accountTF.text,@"password":self.passwordTF.text,@"sign":sign};
    return para;
}

- (void)registBtnClicked:(UIButton *)button
{
    if([self.fromSource isEqualToString:@"register"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else 
    {
        XYRegisterController *registVC = [[XYRegisterController alloc] init];
        registVC.hidesBottomBarWhenPushed = YES;
        registVC.fromSource=@"login";
        [self.navigationController pushViewController:registVC animated:YES];
    }
}


#pragma mark - 三方登录平台-----------
#pragma mark QQ登录--------
- (void)qqBtnClicked:(UIButton *)button
{
    NSLog(@"开始QQ登录");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [MBProgressHUD showError:@"QQ授权失败" toView:self.view];
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);

            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            // 开始三方请求数据
            DSYBindAccountController *bindVC = [[DSYBindAccountController alloc] init];
            bindVC.hidesBottomBarWhenPushed = NO;
            bindVC.resp = resp;
            [self.navigationController pushViewController:bindVC animated:NO];
        }
    }];
}


#pragma mark 微信登录--------
- (void)wechatBtnClicked:(UIButton *)button
{
    NSLog(@"开始微信登录");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            [MBProgressHUD showError:@"微信授权失败" toView:self.view];
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            
            NSString *url = [NSString stringWithFormat:@"%@/passport/thirdBind", APIPREFIX];
            [MBProgressHUD showMessage:@"正在使用微信登录" toView:self.view];
            [LYDTool sendGetWithUrl:url parameters:[self getParameterWithOpenId:resp.openid] success:^(id data) {
                [MBProgressHUD hideHUDForView:self.view];
                id backData = LYDJSONSerialization(data);
                if ([backData[@"hasBind"] boolValue] == YES) {
                    // 登录
                    NSString *loginUrl = [NSString stringWithFormat:@"%@/passport/thirdLoginDirect", APIPREFIX];
                    [LYDTool sendGetWithUrl:loginUrl parameters:[self getParameterWithOpenId:resp.openid] success:^(id loginData) {
                        id loginBackData = LYDJSONSerialization(loginData);
                        NSInteger statuscode = [loginBackData[@"code"] integerValue];
                        if (statuscode == 200) {
                            UserDefaultsWriteObj([loginBackData valueForKey:@"token"], @"access-token");
                            // 如果登录成功的话就必须将account信息制空
                            [[DSYAccount sharedDSYAccount] clean];
                            
                            [[DSYUser sharedDSYUser] setValuesForKeysWithDictionary:loginBackData[@"user"]];
                            [[DSYUser sharedDSYUser] saveUserUserToSanbox];
                            UserDefaultsSynchronize;
                            // 登录成功后更新账户信息
                            [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
                                if ([self.comefromModifyPassword isEqualToString:@"modifyPassword"]) {
                                    [UIApplication sharedApplication].keyWindow.rootViewController = [[XYMainTabBarController alloc] init];
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            }];
                        } else {
                            [MBProgressHUD showError:loginBackData[@"message"] toView:self.view];
                        }
                    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
                        [self errorHandleWithOperation:operation];
                    }];
                    
                } else {
                    // 开始三方请求数据
                    [DSYUtils showResponseError_404_ForViewController:self message:@"当前微信需要绑定账号" okHandler:^(UIAlertAction *action) {
                        DSYBindAccountController *bindVC = [[DSYBindAccountController alloc] init];
                        bindVC.hidesBottomBarWhenPushed = NO;
                        bindVC.resp = resp;
                        [self.navigationController pushViewController:bindVC animated:NO];
                    } cancelHandler:^(UIAlertAction *action) {
                    }];
                }
            } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
                [self errorHandleWithOperation:operation];
            }];
        }
    }];
}

#pragma mark 微博登录---------
- (void)weiboBtnClicked:(UIButton *)button
{
    
}


#pragma mark  三方登录的参数
- (NSDictionary *)getParameterWithOpenId:(NSString *)openId  {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"openId":openId};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"openId":openId, @"sign":sign};
    return para;
}

#pragma mark 成功处理
- (void)successHandleWithData:(id)data {
    if ([[data valueForKey:@"code"] integerValue] == 200) {
        UserDefaultsWriteObj([data valueForKey:@"token"], @"access-token");
        // 如果登录成功的话就必须将account信息制空
        [[DSYAccount sharedDSYAccount] clean];
        
        [[DSYUser sharedDSYUser] setValuesForKeysWithDictionary:data[@"user"]];
        [[DSYUser sharedDSYUser] saveUserUserToSanbox];
        UserDefaultsSynchronize;
        // 登录成功后更新账户信息
        [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
            [self.navigationController popViewControllerAnimated:YES];
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
//    NSString *regex = @"^[0-9A-Za-z]+$";
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:mystring];
}

- (void)alertWithMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:alertAC];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
