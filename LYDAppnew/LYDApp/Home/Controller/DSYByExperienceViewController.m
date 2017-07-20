//
//  DSYByExperienceViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/23.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYByExperienceViewController.h"

#import "XYSuccessController.h"

@interface DSYByExperienceViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */

@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation DSYByExperienceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"购买体验标";
    
    [self contentWibView];
    
    [self loadData];
}

- (void)loadData {
    
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@", self.payUrl]]]];
}

- (UIWebView *)contentWibView {
    if (!_contentWibView) {
        _contentWibView = [[UIWebView alloc] init];
        [self.view addSubview:_contentWibView];
        [_contentWibView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        _contentWibView.delegate = self;
        
        NSString *oldAgent = [_contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        NSLog(@"old agent :%@", oldAgent);
        NSString *newAgent = [oldAgent stringByAppendingString:@"lyd-app"];
        NSLog(@"new agent :%@", newAgent);
        //regist the new agent
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    }
    return _contentWibView;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    NSLog(@"%@", request.URL.absoluteString);
    // 成功回调地址   http://mertest.chinapnr.com/muser/bankcard/addCard
    if ([request.URL.absoluteString isEqualToString:kHUIFUCALLBACKURL]) {
        self.isSuccess = YES;
        [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
            [self.navigationController pushViewController:[[XYSuccessController alloc] init] animated:YES];
        }];
        
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"正在加载页面..." toView:self.view];
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view];
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view];
    if (self.isSuccess) {
        return;
    }
    [MBProgressHUD showError:@"网络繁忙" toView:self.view];
    NSLog(@"didFailLoadWithError");
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
