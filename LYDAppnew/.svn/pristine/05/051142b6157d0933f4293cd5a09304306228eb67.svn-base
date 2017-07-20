//
//  WebViewVC.m
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/30.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "WebViewVC.h"
#import <WebKit/WebKit.h>

@interface WebViewVC ()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];
   WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
 WKUserContentController *userContentController =[[WKUserContentController alloc]init];
    configuration.userContentController = userContentController;
    configuration.preferences.javaScriptEnabled = YES;//打开JavaScript交互 默认为YES

    self.webView=[[WKWebView alloc]initWithFrame:CGRectZero configuration:configuration];
    self.webView.UIDelegate=self;
    self.webView.navigationDelegate=self;
    self.webView.clipsToBounds=YES;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    [self.webView setBackgroundColor:[UIColor whiteColor]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self backui];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    self.navigationItem.title=self.webView.title;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
}



-(void)backui
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[[UIImage imageNamed:@"ic_back"] imageWithRenderingMode:1] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    // 设置返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
   
}



-(void)back
{
    if ([self.webView canGoBack]) {//判断当前的H5页面是否可以返回
        //如果可以返回，则返回到上一个H5页面，并在左上角添加一个关闭按钮
        [self.webView goBack];
        //self.navigationItem.leftBarButtonItems = @[self.returnButton, self.closeItem];
    } else {
        //如果不可以返回，则直接:
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
