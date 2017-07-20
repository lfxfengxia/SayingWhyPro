//
//  DSYOpenAccountController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/16.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYOpenAccountController.h"
#import "XYAccountController.h"

@interface DSYOpenAccountController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation DSYOpenAccountController

- (instancetype)initWithType:(DSYOpenAccountControllerFromType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"开户";
    [self addUserAgen];
    [self contentWibView];
    
//    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self loadData];
}


- (void)loadData {
    NSInteger userId = [DSYUser sharedDSYUser].userId;
    if (userId <= 0) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"用户信息有误，请重新登录" okHandler:^(UIAlertAction *action) {
            [self pushToLoginController];
        } cancelHandler:^(UIAlertAction *action) {
            
        }];
    }
    [self addUserAgen];
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/chinapnr/request/userRegisterApp?userId=%ld", HFAPIREFIX, [DSYUser sharedDSYUser].userId]]]];
}

- (UIWebView *)contentWibView {
    if (!_contentWibView) {
        _contentWibView = [[UIWebView alloc] init];
        [self.view addSubview:_contentWibView];
        [_contentWibView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        _contentWibView.delegate = self;
        
        [self addUserAgen];
    }
    return _contentWibView;
}

- (void)addUserAgen {
    NSString *oldAgent = [self.contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"old agent :%@", oldAgent);
    NSString *newAgent;
    if ([oldAgent hasSuffix:@"lyd-app"]) {
        newAgent = oldAgent;
    } else {
        newAgent = [oldAgent stringByAppendingString:@"lyd-app"];
    }
    NSLog(@"new agent :%@", newAgent);
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}





- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    NSLog(@"%@", request.URL.absoluteString);
    [self addUserAgen];
    if ([request.URL.absoluteString containsString:kSucessHuiFuCallBackUrl] || [request.URL.absoluteString isEqualToString:kSuccessOpenAcountCallBackUrl]) {
        self.isSuccess = YES;
    }
    if ([request.URL.absoluteString containsString:@"flag="]) {//判断是不是触发了投资成功或者投资失败的确定按钮,通过是否包含flag=来确定
        //http://116.236.150.198:8090/chinapnr/flag=4
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
            if ([controller isKindOfClass:[XYAccountController class]]) {//如果从账户的充值入口过来,返回到用户界面,其他情况返回到上一级界面
                
                
                [self.navigationController popToViewController:controller animated:YES];
                return NO;
                
            }
            
            
        }
        
        
                [self.navigationController popViewControllerAnimated:YES];
                return NO;
        
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self addUserAgen];
    [MBProgressHUD showMessage:@"正在加载页面..." toView:self.view];
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view];
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
    [MBProgressHUD hideHUDForView:self.view];

}

- (void)back {
    NSLog(@"自动返回");
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        if (self.isSuccess) {
            if (self.type == DSYOpenAccountControllerFromTypeNone) { // 否者返回上一页
                [self.navigationController popViewControllerAnimated:YES];
            } else {  // 如果是注册后开户，就到首页
                [UIApplication sharedApplication].keyWindow.rootViewController = [[XYMainTabBarController alloc] init];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


@end
