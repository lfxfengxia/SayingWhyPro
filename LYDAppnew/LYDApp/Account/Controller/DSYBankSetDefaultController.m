//
//  DSYBankSetDefaultController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/30.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBankSetDefaultController.h"

@interface DSYBankSetDefaultController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation DSYBankSetDefaultController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"设置银行卡";
//    [self addUserAgen];
    [self contentWibView];
    
    //    [self loadData];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    [self loadData];
//}
//
//- (void)loadData {
//    NSInteger userId = [DSYUser sharedDSYUser].userId;
//    if (userId <= 0) {
//        [DSYUtils showResponseError_404_ForViewController:self message:@"用户信息有误，请重新登录" okHandler:^(UIAlertAction *action) {
//            [self pushToLoginController];
//        } cancelHandler:^(UIAlertAction *action) {
//        }];
//    }
//    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://lyd-invest.doolab.cn/chinapnr/request/userRegisterApp?userId=%ld", [DSYUser sharedDSYUser].userId]]]];
//}
//
//- (UIWebView *)contentWibView {
//    if (!_contentWibView) {
//        _contentWibView = [[UIWebView alloc] init];
//        [self.view addSubview:_contentWibView];
//        [_contentWibView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
//        }];
//        _contentWibView.delegate = self;
//    }
//    return _contentWibView;
//}
//
//- (void)addUserAgen {
//    NSString *oldAgent = [_contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//    NSLog(@"old agent :%@", oldAgent);
//    NSString *newAgent;
//    if ([oldAgent hasSuffix:@"lyd-app"]) {
//        newAgent = oldAgent;
//    } else {
//        newAgent = [oldAgent stringByAppendingString:@"lyd-app"];
//    }
//    NSLog(@"new agent :%@", newAgent);
//    //regist the new agent
//    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
//    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
//}
//
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSLog(@"shouldStartLoadWithRequest");
//    NSLog(@"%@", request.URL.absoluteString);
//    [self addUserAgen];
//    if ([request.URL.absoluteString containsString:kSucessHuiFuCallBackUrl]) {
//        self.isSuccess = YES;
//    }
//    return YES;
//}
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [self addUserAgen];
//    [MBProgressHUD showMessage:@"正在加载页面..." toView:self.view];
//    NSLog(@"webViewDidStartLoad");
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [MBProgressHUD hideHUDForView:self.view];
//    NSLog(@"webViewDidFinishLoad");
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    NSLog(@"didFailLoadWithError");
//    [MBProgressHUD hideHUDForView:self.view];
//}

@end
