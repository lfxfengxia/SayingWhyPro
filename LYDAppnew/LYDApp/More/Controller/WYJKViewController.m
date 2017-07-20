//
//  WYJKViewController.m
//  LYDApp
//
//  Created by fcl on 17/3/28.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "WYJKViewController.h"

@interface WYJKViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */


@end

@implementation WYJKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigaTitle = @"我要借款";
    [self contentWibView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES];
    //    [self loadData];
}

- (void)loadData {
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/help/getLoanUrl", APIPREFIX] parameters:nil success:^(id data) {
        id backData = LYDJSONSerialization(data);
        
        
        [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:backData[@"url"]]]];
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD showError:@"网络繁忙" toView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/help/about", APIPREFIX]]]];
    
    
}

- (UIWebView *)contentWibView {
    if (!_contentWibView) {
        _contentWibView = [[UIWebView alloc] init];
        [self.view addSubview:_contentWibView];
        [_contentWibView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        
        _contentWibView.delegate = self;
        _contentWibView.backgroundColor = RGB(249, 249, 249);
        
        
        
        
        NSString *oldAgent = [_contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        
        NSLog(@"old agent :%@", oldAgent);
        
        NSString *newAgent = @"";
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
    return _contentWibView;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    NSLog(@"%@", request.URL.absoluteString);
    NSLog(@"%ld", navigationType);
    // 成功回调地址   http://mertest.chinapnr.com/muser/bankcard/addCard
    //    if ([request.URL.absoluteString isEqualToString:@"http://lyd-invest-weixin.doolab.cn/content/about"]) {
    //        if (navigationType == UIWebViewNavigationTypeBackForward) {
    //
    //            [self.navigationController popViewControllerAnimated:YES];
    //
    //    }
    
    return YES;
}


//控制导航条是否可以显示
-(void)ShowNavigation:(UIWebView *)webView
{
    if (webView.canGoBack) {
        self.navigationController.navigationBar.hidden=YES;
        _contentWibView.frame=CGRectMake(0,-64, self.view.frame.size.width, self.view.frame.size.height+64);
    }
    else{
        
        self.navigationController.navigationBar.hidden=NO;
        _contentWibView.frame=self.view.bounds;
    }
}



- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    [self ShowNavigation:webView];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
