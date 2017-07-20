//
//  DSYHelpWebViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/24.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYHelpWebViewController.h"


@interface DSYHelpWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */

@end

@implementation DSYHelpWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES];
    //    [self loadData];
}

- (void)loadData {
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/help/help", APIPREFIX] parameters:nil success:^(id data) {
        id backData = LYDJSONSerialization(data);
        [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:backData[@"url"]]]];
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD showError:@"网络繁忙" toView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (UIWebView *)contentWibView {
    if (!_contentWibView) {
        _contentWibView = [[UIWebView alloc] init];
        [self.view addSubview:_contentWibView];
//        [_contentWibView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
//        }];
        
        
        
        _contentWibView.frame=self.view.bounds;
        _contentWibView.delegate = self;
        _contentWibView.backgroundColor = RGB(249, 249, 249);
    }
    return _contentWibView;
}



//控制导航条是否可以显示
//-(void)ShowNavigation:(UIWebView *)webView
//{
//    if (webView.canGoBack) {
//        self.navigationController.navigationBar.hidden=YES;
//        _contentWibView.frame=CGRectMake(0,-64, self.view.frame.size.width, self.view.frame.size.height+64);
//    }
//    else{
//        
//        self.navigationController.navigationBar.hidden=NO;
//        _contentWibView.frame=self.view.bounds;
//    }
//    
//}



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


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    NSLog(@"%@", request.URL.absoluteString);
    NSLog(@"%ld", navigationType);
//    // 成功回调地址   http://mertest.chinapnr.com/muser/bankcard/addCard
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
    [self ShowNavigation:webView];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
}

@end
