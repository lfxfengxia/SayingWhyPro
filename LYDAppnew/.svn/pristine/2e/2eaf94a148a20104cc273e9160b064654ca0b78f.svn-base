//
//  RBModifyPasswordViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBModifyPasswordViewController.h"

@interface RBModifyPasswordViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UITextField *oldPasswordTF;
@property (nonatomic, strong) UITextField *changePasswordTF;
@property (nonatomic, strong) UITextField *confirmNewPasswordTF;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation RBModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"修改登录密码";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createUI];
}

- (void)createUI {
    _bgScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _bgScrollView.showsVerticalScrollIndicator = NO;
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgScrollView];
    
    _oldPasswordTF = [RYFactoryMethod initWithTextFieldFrame:CGRectMake(KWidth(20), NavMaxY, kSCREENW-2*KWidth(10), KHeight(40)) andTextColor:rgba(102, 102, 102, 1) placeHoder:@"请输入当前密码" fontOfSystemSize:KWidth(14)];
    [_oldPasswordTF setValue:rgba(102, 102, 102, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [_oldPasswordTF setValue:[UIFont systemFontOfSize:KWidth(14)] forKeyPath:@"_placeholderLabel.font"];
    _oldPasswordTF.returnKeyType = UIReturnKeyDone;
    _oldPasswordTF.secureTextEntry = YES;
    _oldPasswordTF.keyboardType = UIKeyboardTypeASCIICapable;
    _oldPasswordTF.delegate = self;
    [_bgScrollView addSubview:_oldPasswordTF];
    
    UIView *lineView1 = [RYFactoryMethod initWithLineViewFrame:CGRectMake(0, _oldPasswordTF.maxY, kSCREENW, 1)];
    [_bgScrollView addSubview:lineView1];
    
    _changePasswordTF = [RYFactoryMethod initWithTextFieldFrame:CGRectMake(_oldPasswordTF.x, lineView1.maxY, _oldPasswordTF.width, _oldPasswordTF.height) andTextColor:rgba(102, 102, 102, 1) placeHoder:@"请输入您的新密码，6-20位字母+数字组合" fontOfSystemSize:KWidth(14)];
    [_changePasswordTF setValue:rgba(102, 102, 102, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [_changePasswordTF setValue:[UIFont systemFontOfSize:KWidth(14)] forKeyPath:@"_placeholderLabel.font"];
    _changePasswordTF.returnKeyType = UIReturnKeyDone;
    _changePasswordTF.secureTextEntry = YES;
    _changePasswordTF.keyboardType = UIKeyboardTypeASCIICapable;
    _changePasswordTF.delegate = self;
    [_bgScrollView addSubview:_changePasswordTF];
    
    UIView *lineView2 = [RYFactoryMethod initWithLineViewFrame:CGRectMake(0, _changePasswordTF.maxY, kSCREENW, 1)];
    [_bgScrollView addSubview:lineView2];

    _confirmNewPasswordTF = [RYFactoryMethod initWithTextFieldFrame:CGRectMake(_oldPasswordTF.x, lineView2.maxY, _oldPasswordTF.width, _oldPasswordTF.height) andTextColor:rgba(102, 102, 102, 1) placeHoder:@"请再次输入您的新密码，6-20位字母+数字组合" fontOfSystemSize:KWidth(14)];
    [_confirmNewPasswordTF setValue:rgba(102, 102, 102, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [_confirmNewPasswordTF setValue:[UIFont systemFontOfSize:KWidth(14)] forKeyPath:@"_placeholderLabel.font"];
    _confirmNewPasswordTF.returnKeyType = UIReturnKeyDone;
    _confirmNewPasswordTF.secureTextEntry = YES;
    _confirmNewPasswordTF.keyboardType = UIKeyboardTypeASCIICapable;
    _confirmNewPasswordTF.delegate = self;
    [_bgScrollView addSubview:_confirmNewPasswordTF];
    
    UIView *lineView3 = [RYFactoryMethod initWithLineViewFrame:CGRectMake(0, _confirmNewPasswordTF.maxY, kSCREENW, 1)];
    [_bgScrollView addSubview:lineView3];

    _confirmButton = [RYFactoryMethod initWithButtonFrame:CGRectMake(KWidth(50), lineView3.maxY + 20, kSCREENW-2*KWidth(50), 44) title:@"确认" titleColor:[UIColor whiteColor] fontOfSystemSize:16];
    _confirmButton.backgroundColor = rgba(252, 120, 35, 1);
    [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:_confirmButton];
    
    _bgScrollView.contentSize = CGSizeMake(0, _confirmButton.maxY + 10);
}

- (void)confirmButtonClick:(UIButton *)confirmButton {
    [self.view endEditing:YES];
    
    if (self.oldPasswordTF.text.length == 0) {
        [RYFactoryMethod alertViewOrControllerShow:@"请输入当前密码" viewController:self];
        return;
    } 
    [self startRequestOfModifyPassword];
}

- (void)startRequestOfModifyPassword {
   // NSString *url = [NSString stringWithFormat:@"%@/account/changePassword", APIPREFIX];
    
    NSString *url = [NSString stringWithFormat:@"%@/account/changePassword?%@", APIPREFIX, [self getUrl]];
    
    
    
    
    NSDictionary *para = [self getMyPara];
    [LYDTool sendPutWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        // 错误处理方法
        [self errorDealWithOperation:operation];
    }];
}


- (NSString *)getUrl {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"oldPassword": self.oldPasswordTF.text, @"newPassword":self.changePasswordTF.text, @"confirmPassword":self.confirmNewPasswordTF.text};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    
    return [NSString stringWithFormat:@"appKey=%@&timestamp=%@&deviceId=%@&token=%@&oldPassword=%@&newPassword=%@&confirmPassword=%@&sign=%@", APPKEY, timestamp, DEVICEID, TOKEN, self.oldPasswordTF.text, self.changePasswordTF.text, self.confirmNewPasswordTF.text, sign];
}





- (NSDictionary *)getMyPara {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"oldPassword": self.oldPasswordTF.text, @"newPassword":self.changePasswordTF.text, @"confirmPassword":self.confirmNewPasswordTF.text};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"oldPassword": self.oldPasswordTF.text, @"newPassword":self.changePasswordTF.text, @"confirmPassword":self.confirmNewPasswordTF.text, @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        [MBProgressHUD showSuccess:@"设置成功!" toView:self.view];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 清空Token
//            [self pushToLoginController];
//        });
        [self pushToLoginController];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        if ([data[@"message"] isEqualToString:@"旧密码不对"]) {
            [MBProgressHUD showError:@"当前密码有误" toView:self.view];
        } else {
            [MBProgressHUD showError:data[@"message"] toView:self.view];
        }
    }
}

#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger errorData = operation.response.statusCode;
    NSLog(@"%zi: %@",operation.response.statusCode, operation.responseString);
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 判断输入的是否只有数字和字母
- (BOOL)checkPasswordForPassword:(NSString *)password {
    NSString *mystring = password;
    NSString *regex = @"^[0-9A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:mystring];
}


@end
