//
//  DSYInviteRuleViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/25.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYInviteRuleViewController.h"

@interface DSYInviteRuleViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */

@end

@implementation DSYInviteRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigaTitle = @"奖励机制";
    [self contentWibView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES];
    //    [self loadData];
}

- (void)loadData {
    
    
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/appReward?type=app", self.strurl]]]];
    //[self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://116.236.150.198:8190/content/about/public?type=serverAgreement"]]];
    
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
    //        }
    //    }
    
    return YES;
}






- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
