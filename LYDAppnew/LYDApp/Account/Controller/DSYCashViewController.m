//
//  DSYCashViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/16.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYCashViewController.h"
#import "XYAccountController.h"
#import "ShouYiViewController.h"

@interface DSYCashViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */
@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation DSYCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"提现";
    [self addUserAgen];
    [self contentWibView];
    
//    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/chinapnr/request/cashApp?amount=%f&bankAccountId=%ld&userId=%ld", HFAPIREFIX, self.amount, self.bankAccountId, [DSYUser sharedDSYUser].userId]]]];
    
}

- (void)addUserAgen {
    NSString *oldAgent = [self.contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newAgent;
    if ([oldAgent hasSuffix:@"lyd-app"]) {
        newAgent = oldAgent;
    } else {
        newAgent = [oldAgent stringByAppendingString:@"lyd-app"];
    }
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
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


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    NSLog(@"%@", request.URL.absoluteString);
    [self addUserAgen];
    // 成功回调地址   http://mertest.chinapnr.com/muser/bankcard/addCard
    if ([request.URL.absoluteString containsString:kSucessHuiFuCallBackUrl] || [request.URL.absoluteString isEqualToString:kSucessCashCallBackUrl]) {
        self.isSuccess = YES;
    }
    
    
    if ([request.URL.absoluteString containsString:@"flag="]) {//判断是不是触发了投资成功或者投资失败的确定按钮,通过是否包含flag=来确定
        //http://116.236.150.198:8090/chinapnr/flag=4
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
//            if ([controller isKindOfClass:[XYAccountController class]]) {//如果从账户的充值入口过来,返回到用户界面,其他情况返回到上一级界面
//                
//                
//                [self.navigationController popToViewController:controller animated:YES];
//                return NO;
//                
//            }
            
            if ([controller isKindOfClass:[ShouYiViewController class]]) {//如果从账户的充值入口过来,返回到用户界面,其他情况返回到上一级界面
                
                
                [self.navigationController popToViewController:controller animated:YES];
                return NO;
                
            }
            
            
        }
        
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        return NO;
        
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
    [MBProgressHUD hideHUDForView:self.view];
}

- (void)back {
    NSLog(@"自动返回");
    if (self.isSuccess) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
