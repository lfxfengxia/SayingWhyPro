//
//  TiYanJingLoginViewController.m
//  LYDApp
//
//  Created by fcl on 2017/6/26.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "TiYanJingLoginViewController.h"
#import "FWXYViewController.h"
#import "XYRegisterSuccessController.h"

@interface TiYanJingLoginViewController ()
@property (nonatomic, strong) UITextField   *textPhoneNumber;
@property (nonatomic, strong) UITextField   *codeTF;
@property (nonatomic, strong) UITextField   *txtpassword;
@property (nonatomic, strong) UIButton      *sendCodeBtn;
@property (nonatomic, strong) UITextField   *inviteTF;
@property (nonatomic, strong) UIButton      *registerbtn;
@property(nonatomic,strong)  UIView  *tankuangView;
@property(nonatomic,strong)UITextField *txtConfirmpassword;
@end

@implementation TiYanJingLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigaTitle = @"领取体验金";
   [self CreatUI];
   
}


-(void)dismissTankuang
{

    [self.navigationController popToRootViewControllerAnimated:YES];
    [_tankuangView removeFromSuperview];
}





-(void)CreatUI
{
    UIImageView *imgBg=[[UIImageView alloc] init];
    imgBg.frame=CGRectMake(0, 64, kSCREENW, kSCREENH-64);
    imgBg.image=[UIImage imageNamed:@"bg-zc"];
    [self.view addSubview:imgBg];
    
    CGFloat JianGe=KHeight(15);
    
    
//    UITextField *textField = [[UITextField alloc]init];
//    textField.frame = CGRectMake(10, 30, 8, KHeight(31));
//    [self.view addSubview:textField];
//    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, KHeight(31))];
//    //设置显示模式为永远显示(默认不显示)
//    textField.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    _textPhoneNumber=[[UITextField alloc] init];
    _textPhoneNumber.frame=CGRectMake((kSCREENW-KWidth(230))/2, KHeight(166), KWidth(230), KHeight(31));
    _textPhoneNumber.placeholder=@"请输入11位手机号";
    _textPhoneNumber.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    _textPhoneNumber.layer.cornerRadius=5;
    _textPhoneNumber.font = [UIFont systemFontOfSize:10];
    _textPhoneNumber.textColor = [UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    _textPhoneNumber.leftViewMode = UITextFieldViewModeAlways;
    _textPhoneNumber.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, KHeight(31))];
    [imgBg addSubview:_textPhoneNumber];
    
    
    
    _txtpassword=[[UITextField alloc] init];
    _txtpassword.frame=CGRectMake((kSCREENW-KWidth(230))/2, _textPhoneNumber.maxY+JianGe, KWidth(230), KHeight(31));
    _txtpassword.placeholder=@"密码：6～20位英文+数字组合 区分大小写";
    _txtpassword.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    _txtpassword.layer.cornerRadius=5;
    _txtpassword.secureTextEntry=YES;
    _txtpassword.font = [UIFont systemFontOfSize:10];
    _txtpassword.textColor = [UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    _txtpassword.leftViewMode = UITextFieldViewModeAlways;
    _txtpassword.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, KHeight(31))];
    [imgBg addSubview:_txtpassword];
    
    
    _txtConfirmpassword=[[UITextField alloc] init];
    _txtConfirmpassword.frame=CGRectMake((kSCREENW-KWidth(230))/2, _txtpassword.maxY+JianGe, KWidth(230), KHeight(31));
    _txtConfirmpassword.placeholder=@"确认密码";
    _txtConfirmpassword.secureTextEntry=YES;
    _txtConfirmpassword.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    _txtConfirmpassword.layer.cornerRadius=5;
    _txtConfirmpassword.font = [UIFont systemFontOfSize:10];
    _txtConfirmpassword.textColor = [UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    _txtConfirmpassword.leftViewMode = UITextFieldViewModeAlways;
    _txtConfirmpassword.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, KHeight(31))];
    [imgBg addSubview:_txtConfirmpassword];
    
    
   _codeTF=[[UITextField alloc] init];
    _codeTF.frame=CGRectMake((kSCREENW-KWidth(230))/2, _txtConfirmpassword.maxY+JianGe, KWidth(230)/2, KHeight(31));
    _codeTF.placeholder=@"手机验证码";
    _codeTF.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    _codeTF.layer.cornerRadius=5;
    _codeTF.font = [UIFont systemFontOfSize:10];
    _codeTF.textColor = [UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    _codeTF.leftViewMode = UITextFieldViewModeAlways;
    _codeTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, KHeight(31))];
    [imgBg addSubview:_codeTF];
    
    
    
    _sendCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _sendCodeBtn.frame=CGRectMake(_codeTF.maxX+KWidth(5), _txtConfirmpassword.maxY+JianGe, KWidth(230)/2-KWidth(5), KHeight(31));
    [_sendCodeBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    _sendCodeBtn.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    [_sendCodeBtn addTarget:self action:@selector(sendCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _sendCodeBtn.layer.cornerRadius=5;
   
    [_sendCodeBtn setTitleColor:[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    
    _sendCodeBtn.titleLabel.font= [UIFont systemFontOfSize:10];
    [imgBg addSubview:_sendCodeBtn];
    
    
    
    _inviteTF=[[UITextField alloc] init];
    _inviteTF.frame=CGRectMake((kSCREENW-KWidth(230))/2, _codeTF.maxY+JianGe, 2*KWidth(230)/3, KHeight(31));
    _inviteTF.placeholder=@"邀请码";
    _inviteTF.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    _inviteTF.layer.cornerRadius=5;
    _inviteTF.font = [UIFont systemFontOfSize:10];
    _inviteTF.textColor = [UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    
    _inviteTF.leftViewMode = UITextFieldViewModeAlways;
    _inviteTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, KHeight(31))];
    [imgBg addSubview:_inviteTF];
    
    
    UILabel *invitelabel=[[UILabel alloc] init];
    invitelabel.frame=CGRectMake(_inviteTF.maxX+KWidth(8), _codeTF.maxY+JianGe, KWidth(230)/3, KHeight(31));
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"非必填" attributes:attribtDic];

    invitelabel.backgroundColor = [UIColor clearColor];
    invitelabel.textColor=[UIColor whiteColor];
    invitelabel.attributedText=attribtStr;
    invitelabel.font = [UIFont systemFontOfSize:KWidth(12)];
    [imgBg addSubview:invitelabel];
    
    
    
    
    
    CGFloat protocalLableH = [Helper heightOfString:@"我已阅读并同意《零用贷安全网贷平台用户注册协议》" font:[UIFont systemFontOfSize:KWidth(10)] width:KWidth(215)];
    UIButton   *protocalLabel = [[UIButton alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(215))/ 2, _inviteTF.maxY + JianGe, KWidth(215), protocalLableH)];
    [protocalLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    protocalLabel.titleLabel.font = [UIFont systemFontOfSize:KWidth(10)];
    [protocalLabel setTitle:@"我已阅读并同意《零用贷安全网贷平台用户注册协议》" forState:UIControlStateNormal];
    [protocalLabel addTarget:self action:@selector(protocalClicked:) forControlEvents:UIControlEventTouchUpInside];
    [protocalLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    protocalLabel.titleLabel.numberOfLines=0;
    imgBg.userInteractionEnabled=YES;
    [imgBg addSubview:protocalLabel];
    
    
    _registerbtn=[[UIButton alloc] init];
    _registerbtn.frame=CGRectMake((kSCREENW-KWidth(230))/2, protocalLabel.maxY+JianGe, KWidth(230), KHeight(31));
    _registerbtn.backgroundColor = [UIColor colorWithRed:253/255.0 green:220/255.0 blue:67/255.0 alpha:1/1.0];

    [_registerbtn setTitle:@"立即注册" forState:UIControlStateNormal];
    _registerbtn.layer.cornerRadius=5;
    _registerbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_registerbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [self.registerbtn addTarget:self action:@selector(registerbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imgBg addSubview:_registerbtn];
    

    


}








#pragma mark - 按钮方法

- (void)sendCodeBtnClicked:(UIButton *)button
{
    if (self.textPhoneNumber.text.length == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:@"请输入手机号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:alertAC];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else if (![Helper justMobile:self.textPhoneNumber.text]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注意" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:alertAC];
        [self presentViewController:alertVC animated:YES completion:nil];
    }   else{
        __block int timeout=60; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.sendCodeBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];
                    self.sendCodeBtn.userInteractionEnabled = YES;
                    [_sendCodeBtn setTitleColor:[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0] forState:UIControlStateNormal];
                    
                    _sendCodeBtn.titleLabel.font= [UIFont systemFontOfSize:10];
                 _sendCodeBtn.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
                    
                });
            }else{
                int seconds = timeout % 120;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1];
                    [self.sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                    self.sendCodeBtn.titleLabel.adjustsFontSizeToFitWidth = NO;
                    [UIView commitAnimations];
                    self.sendCodeBtn.userInteractionEnabled = NO;
                    _sendCodeBtn.backgroundColor =  [UIColor whiteColor];
                    [_sendCodeBtn setTitleColor:[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0] forState:UIControlStateNormal];
                    
                    _sendCodeBtn.titleLabel.font= [UIFont systemFontOfSize:10];
                    _sendCodeBtn.backgroundColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
                });
                timeout--;
            }
        });
        //        dispatch_resume(_timer);
        
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.textPhoneNumber.text};
        
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.textPhoneNumber.text,@"sign":sign};
        
        [MBProgressHUD showMessage:@"正在发送验证码" toView:self.view];
        [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/common/sendVerifyCode",APIPREFIX] parameters:para success:^(id data) {
            [MBProgressHUD hideHUDForView:self.view];
            
            id backData = LYDJSONSerialization(data);
            NSLog(@"%@",backData);
            
            if ([[backData valueForKey:@"success"] boolValue] == YES) {
                dispatch_resume(_timer);
                [self.sendCodeBtn setBackgroundColor:[UIColor colorWithRed:0.76 green:0.71 blue:0.69 alpha:1.00]];
                self.sendCodeBtn.userInteractionEnabled=NO;
                
            } else {
                [MBProgressHUD showError:[backData valueForKey:@"message"]];
            }
            
        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
            [MBProgressHUD hideHUDForView:self.view];
            
            id response = LYDJSONSerialization(operation.responseObject);
            NSLog(@"%@",response);
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            
            //            dispatch_source_cancel(_timer);
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                //设置界面的按钮显示 根据自己需求设置
            //                [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            //                self.sendCodeBtn.userInteractionEnabled = YES;
            //            });
        }];
        
    }
    
    
}



- (void)registerbtnClicked:(UIButton *)button
{
    self.textPhoneNumber.text = [self.textPhoneNumber.text stringDeleteBlank];
    self.txtpassword.text = [self.txtpassword.text stringDeleteBlank];
    
    if (self.textPhoneNumber.text.length == 0) {
        [self alertWithMessage:@"请输入手机号"];
        return;
    } else if (![Helper justMobile:self.textPhoneNumber.text]) {
        [self alertWithMessage:@"请输入正确的手机号"];
        return;
    } else if (self.codeTF.text.length == 0) {
        [self alertWithMessage:@"请输入验证码"];
        return;
    } else if (![self checkCode]) {
        [self alertWithMessage:@"请输入6位正确的验证码"];
        return;
    } else if (self.txtpassword.text.length == 0) {
        [self alertWithMessage:@"请输入密码"];
        return;
    } else if (self.txtpassword.text.length < 6 || self.txtpassword.text.length >= 16) {
        [self alertWithMessage:@"请输入包含数字和字母的6-20位密码"];
        return;
    } else if (![self checkPassword]) {
        [self alertWithMessage:@"请输入包含数字和字母的6-20位密码"];
        return;
    }else  if(![_txtpassword.text isEqualToString:_txtConfirmpassword.text]){
        [self alertWithMessage:@"两次密码不一致"];
    }else {
        NSString *tt=[[NSUserDefaults standardUserDefaults] stringForKey:@"strDeviceToken"];
        
        
        if (tt.length == 0)
        {
            tt=@"";
        }
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.textPhoneNumber.text,@"verifyCode":self.codeTF.text,@"inviteCode":self.inviteTF.text,@"password":self.txtpassword.text,@"deviceToken":tt};
        
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"mobile":self.textPhoneNumber.text,@"verifyCode":self.codeTF.text,@"inviteCode":self.inviteTF.text,@"password":self.txtpassword.text,@"deviceToken":tt,@"sign":sign};
        
        NSString *url = [NSString stringWithFormat:@"%@/passport/register",APIPREFIX];
//        if ([self.comeFrom isEqualToString:@"weixin"]) {
//            url = [NSString stringWithFormat:@"%@/passport/weixinLoginReg", APIPREFIX];
//            para = [self getParameterWithOpenId:self.resp.openid unionId:self.resp.uid];
//        }
        [MBProgressHUD showMessage:@"正在注册" toView:self.view];
        [LYDTool sendPostWithUrl:url parameters:para success:^(id data) {
            [MBProgressHUD hideHUDForView:self.view];
            
            id backData = LYDJSONSerialization(data);
            NSLog(@"%@",backData);
            
            if ([[backData valueForKey:@"code"] integerValue] == 200) {
                UserDefaultsWriteObj([backData valueForKey:@"token"], @"access-token");
                UserDefaultsWriteObj([backData valueForKey:@"userId"], @"userId");
                
                [[DSYUser sharedDSYUser] setValuesForKeysWithDictionary:backData[@"user"]];
                [[DSYUser sharedDSYUser] saveUserUserToSanbox];
                UserDefaultsSynchronize;
                
//                XYRegisterSuccessController *successVC = [[XYRegisterSuccessController alloc] init];
//                successVC.code = backData[@"inviteCode"];
//                [self.navigationController pushViewController:successVC animated:YES];
                
                // 1.获得最上面的窗口
                UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
                _tankuangView=[[UIView alloc] init];
                _tankuangView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
                
                
                _tankuangView.frame = window.bounds;
                
                _tankuangView.userInteractionEnabled=YES;
                
                
                UIImageView *imgtankuang=[[UIImageView alloc] initWithFrame:CGRectMake((kSCREENW-KWidth(200))/2, (kSCREENH-KHeight(145))/2, KWidth(200), KHeight(145))];
                imgtankuang.userInteractionEnabled=YES;
                imgtankuang.image=[UIImage imageNamed:@"弹窗tt"];
                
                UIButton *btnxx=[UIButton buttonWithType:UIButtonTypeCustom];
                
                btnxx.frame=CGRectMake(0, KHeight(145-30), KWidth(200), KHeight(30));
                [btnxx addTarget:self action:@selector(dismissTankuang) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                [imgtankuang addSubview:btnxx];
                
                
                
                
                [_tankuangView addSubview:imgtankuang];
                // 2.添加自己到窗口上
                [window addSubview:_tankuangView];

            } else {
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
            }
            
        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
            NSLog(@"%@-----%ld", operation.responseString, operation.response.statusCode);
            [MBProgressHUD hideHUDForView:self.view];
            
            id response = LYDJSONSerialization(operation.responseObject);
            NSLog(@"%@",response);
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }];
    }
}

- (BOOL)checkCode {
    NSString *mystring = self.codeTF.text;
    NSString *regext = @"^\\d{6}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regext];
    return [predicate evaluateWithObject:mystring];
}


#pragma mark - 判断输入的是否只有数字和字母
- (BOOL)checkPassword {
    NSString *mystring = self.txtpassword.text;
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


- (void)protocalClicked:(UIButton *)button
{
    FWXYViewController *vc=[[FWXYViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
