//
//  XYForgotController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/22.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYForgotController.h"

@interface XYForgotController ()

@property (nonatomic, strong) XYMainScrollView  *mainSV;
@property (nonatomic, strong) UIImageView   *bgIV;
@property (nonatomic, strong) UIButton      *backBtn;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIImageView   *logoIV;
@property (nonatomic, strong) UITextField   *mobileTF;
@property (nonatomic, strong) UITextField   *codeTF;
@property (nonatomic, strong) UIButton      *sendCodeBtn;
@property (nonatomic, strong) UITextField   *passwordTF;
@property (nonatomic, strong) UIButton      *eyeBtn;
@property (nonatomic, strong) UIButton      *registerbtn;


@end

@implementation XYForgotController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createUI];
    
    self.mobileTF.text = self.userName;
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
    self.backBtn.frame = CGRectMake(X(12), KHeight(31), W(25), H(22));
    [self.backBtn setImage:DSYImage(@"back_icon.png") forState:(UIControlStateNormal)];
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, W(12.5));
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self.mainSV addSubview:self.backBtn];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KHeight(69/2), KWidth(150), KHeight(15))];
    self.titleLabel.center = CGPointMake(self.view.center.x, self.titleLabel.center.y);
    self.titleLabel.textColor = TEXTBLACK;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:KHeight(16)];
    self.titleLabel.text = @"忘记密码";
    [self.mainSV addSubview:self.titleLabel];
    
    self.logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(130), KHeight(85), KWidth(116), KHeight(75))];
    self.logoIV.image = [UIImage imageNamed:@"Logo"];
    [self.mainSV addSubview:self.logoIV];
    
    self.mobileTF = [[UITextField alloc] initWithFrame:CGRectMake(KWidth(40), self.logoIV.maxY + KHeight(80), kSCREENW - (KWidth(40) * 2), KHeight(40))];
    self.mobileTF.font = [UIFont systemFontOfSize:KHeight(16)];
    NSMutableAttributedString *mobilePH = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号"];
    [mobilePH addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(0, mobilePH.length)];
    [mobilePH addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(0, mobilePH.length)];
    self.mobileTF.attributedPlaceholder = mobilePH;
    [self.mainSV addSubview:self.mobileTF];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(self.mobileTF.x, self.mobileTF.maxY - 1, self.mobileTF.width, 1)];
    line1.backgroundColor = [UIColor colorWithRed:0.78 green:0.74 blue:0.71 alpha:1.00];
    [self.mainSV addSubview:line1];
    
    self.codeTF = [[UITextField alloc] initWithFrame:CGRectMake(self.mobileTF.x, self.mobileTF.maxY + KHeight(10), self.mobileTF.width, self.mobileTF.height)];
    self.codeTF.font = [UIFont systemFontOfSize:KHeight(14)];
    NSMutableAttributedString *codePH = [[NSMutableAttributedString alloc] initWithString:@"请输入收到的验证码"];
    [codePH addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(0, codePH.length)];
    [codePH addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(14)] range:NSMakeRange(0, codePH.length)];
    self.codeTF.attributedPlaceholder = codePH;
    [self.mainSV addSubview:self.codeTF];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.codeTF.x, self.codeTF.maxY - 1, self.codeTF.width, 1)];
    line2.backgroundColor = [UIColor colorWithRed:0.78 green:0.74 blue:0.71 alpha:1.00];
    [self.mainSV addSubview:line2];
    
    self.sendCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.mobileTF.maxX - KWidth(90), line1.maxY + KHeight(11), KWidth(90), KHeight(30))];
    [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.sendCodeBtn setBackgroundColor:[UIColor orangeColor]];
    [self.sendCodeBtn addTarget:self action:@selector(sendCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:KHeight(15.0f)];
    self.sendCodeBtn.layer.cornerRadius = 2.0f;
    self.sendCodeBtn.layer.masksToBounds = YES;
    [self.mainSV addSubview:self.sendCodeBtn];
    
    self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(self.codeTF.x, self.codeTF.maxY + KHeight(10), self.codeTF.width, self.codeTF.height)];
    self.passwordTF.font = [UIFont systemFontOfSize:KHeight(14)];
    NSMutableAttributedString *pswdPH = [[NSMutableAttributedString alloc] initWithString:@"请输入您的密码(6-20位字母+数字组合)"];
    [pswdPH addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(0, pswdPH.length)];
    [pswdPH addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(14)] range:NSMakeRange(0, pswdPH.length)];
    self.passwordTF.attributedPlaceholder = pswdPH;
    self.passwordTF.secureTextEntry = YES;
    [self.mainSV addSubview:self.passwordTF];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(self.passwordTF.x, self.passwordTF.maxY - 1, self.passwordTF.width, 1)];
    line4.backgroundColor = [UIColor colorWithRed:0.78 green:0.74 blue:0.71 alpha:1.00];
    [self.mainSV addSubview:line4];
    
    self.eyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.passwordTF.maxX - KWidth(23), self.passwordTF.y + (self.passwordTF.height - KHeight(18)) / 2, KWidth(23), KHeight(18))];
    [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"closeEye"] forState:UIControlStateNormal];
    [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateSelected];
    [self.eyeBtn addTarget:self action:@selector(eyeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainSV addSubview:self.eyeBtn];
    
    self.registerbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.passwordTF.x, self.passwordTF.maxY + KHeight(22), self.passwordTF.width, KHeight(44))];
    [self.registerbtn setBackgroundColor:ORANGECOLOR];
    [self.registerbtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.registerbtn addTarget:self action:@selector(registerbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.registerbtn.layer.cornerRadius = 2.0f;
    self.registerbtn.layer.masksToBounds = YES;
    [self.mainSV addSubview:self.registerbtn];
    
    self.mainSV.contentSize = CGSizeMake(0, self.registerbtn.maxY + 10);
}

#pragma mark - 按钮方法

- (void)sendCodeBtnClicked:(UIButton *)button
{
    self.mobileTF.text = [self.mobileTF.text stringDeleteBlank];
    self.passwordTF.text = [self.passwordTF.text stringDeleteBlank];
    
    if (self.mobileTF.text.length == 0) {
        [self alertWithMessage:@"请输入手机号"];
        return;
    } else if (![Helper justMobile:self.mobileTF.text]) {
        [self alertWithMessage:@"请输入正确的手机号"];
        return;
    }
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.sendCodeBtn.userInteractionEnabled = YES;
                self.sendCodeBtn.backgroundColor=[UIColor orangeColor];
            });
        }else{
            int seconds = timeout % 120;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                self.sendCodeBtn.titleLabel.adjustsFontSizeToFitWidth = NO;
                [UIView commitAnimations];
                self.sendCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
//    dispatch_resume(_timer);
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.mobileTF.text};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.mobileTF.text,@"sign":sign};
    
    [MBProgressHUD showMessage:@"正在发送验证码" toView:self.view];
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/common/sendPasswordCode",APIPREFIX] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"success"] boolValue] == YES) {
            dispatch_resume(_timer);
            [self.sendCodeBtn setBackgroundColor:[UIColor colorWithRed:0.76 green:0.71 blue:0.69 alpha:1.00]];
            self.sendCodeBtn.userInteractionEnabled=NO;
            //self.codeTF.text = [NSString stringWithFormat:@"%@", [backData valueForKey:@"code"]];
            
        } else {
            [MBProgressHUD showError:[backData valueForKey:@"message"]];
        }
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
        
        dispatch_source_cancel(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置
            [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            self.sendCodeBtn.userInteractionEnabled = YES;
        });
    }];
}

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

- (void)registerbtnClicked:(UIButton *)button
{
    [self.view endEditing:YES];
    
    if (self.mobileTF.text.length == 0) {
        [self alertWithMessage:@"请输入手机号"];
        return;
    } else if (![Helper justMobile:self.mobileTF.text]) {
        [self alertWithMessage:@"请输入正确的手机号"];
        return;
    } else if (self.codeTF.text.length == 0) {
        [self alertWithMessage:@"请输入验证码"];
        return;
    } else if (![self checkCode]) {
        [self alertWithMessage:@"请输入6位验证码"];
        return;
    } else if (self.passwordTF.text.length == 0) {
        [self alertWithMessage:@"请输入密码"];
        return;
    } else if (![Helper justCorrentPassword:self.passwordTF.text]) {
        [self alertWithMessage:@"请输入包含数字和字母的6-20位密码"];
        return;
    } else {
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.mobileTF.text,@"verifyCode":self.codeTF.text,@"newPassword":self.passwordTF.text};
        
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.mobileTF.text,@"verifyCode":self.codeTF.text,@"newPassword":self.passwordTF.text,@"sign":sign};
        
        [MBProgressHUD showMessage:@"正在修改密码" toView:self.view];
        
        
        NSString *url = [NSString stringWithFormat:@"%@/passport/changePassword?%@", APIPREFIX, [self getUrl]];
        [LYDTool sendPutWithUrl:url parameters:para success:^(id data) {
            [MBProgressHUD hideHUDForView:self.view];
            
            id backData = LYDJSONSerialization(data);
            NSLog(@"%@",backData);
            
            if ([[backData valueForKey:@"code"] integerValue] == 200) {
                [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:1 animations:^{
                        [self.navigationController popViewControllerAnimated:NO];
                    }];
                });
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






- (NSString *)getUrl {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.mobileTF.text,@"verifyCode":self.codeTF.text,@"newPassword":self.passwordTF.text};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    
    return [NSString stringWithFormat:@"appKey=%@&timestamp=%@&deviceId=%@&mobile=%@&verifyCode=%@&newPassword=%@&sign=%@", APPKEY, timestamp, DEVICEID, self.mobileTF.text,self.codeTF.text, self.passwordTF.text,sign];
}







- (void)alertWithMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:alertAC];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (BOOL)checkCode {
    NSString *mystring = self.codeTF.text;
    NSString *regext = @"^\\d{6}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regext];
    return [predicate evaluateWithObject:mystring];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
