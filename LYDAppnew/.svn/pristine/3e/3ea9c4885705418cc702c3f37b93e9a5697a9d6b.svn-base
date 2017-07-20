//
//  DSYBindCardViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/16.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBindCardViewController.h"

@interface DSYBindCardViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */
@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation DSYBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"绑定银行卡";
    
    [self contentWibView];
    [self addUserAgen];
    
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
    
    // 如若没有开户，进行开户
    if ([DSYAccount sharedDSYAccount].ipsAccount.length <= 0) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"用户未开户，请进行开户" okHandler:^(UIAlertAction *action) {
            DSYOpenAccountController *openAccountVC = [[DSYOpenAccountController alloc] init];
            [self.navigationController pushViewController:openAccountVC animated:YES];
        } cancelHandler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return;
    } else {
        [self addUserAgen];
        [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/chinapnr/request/userBindCardApp?userId=%ld", HFAPIREFIX, [DSYUser sharedDSYUser].userId]]]];
        
        
        
        
    }
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
    
//    if ([request.URL.absoluteString isEqualToString:@"http://lyd-invest.doolab.cn/chinapnr/response/userRegister"]) {
//        [self.navigationController popViewControllerAnimated:YES];
//        return NO;
//    }
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
    NSLog(@"didFailLoadWithError");
    if (self.isSuccess) {
        return;
    }
    [MBProgressHUD showError:@"网络繁忙" toView:self.view];
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
