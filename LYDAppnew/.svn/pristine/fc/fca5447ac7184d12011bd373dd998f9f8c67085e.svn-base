//
//  GonggaoWebViewController.m
//  LYDApp
//
//  Created by fcl on 17/4/1.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "GonggaoWebViewController.h"

@interface GonggaoWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */
@end

@implementation GonggaoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigaTitle = @"公告";
//    [self contentWibView];
    [self backui];
    [self loadData];
}

-(void)backui
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 20, 20);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[btn setTitle:@"上一页" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
}



-(void)backAction
{
    if ([_contentWibView canGoBack]) {//判断当前的H5页面是否可以返回
        //如果可以返回，则返回到上一个H5页面，并在左上角添加一个关闭按钮
        [_contentWibView goBack];
        //self.navigationItem.leftBarButtonItems = @[self.returnButton, self.closeItem];
    } else {
        //如果不可以返回，则直接:
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        //[self.navigationController setNavigationBarHidden:YES];
        [self loadData];
}

- (void)loadData {
    
    
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/content/getCategory", APIPREFIX]]]];
    //  [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://116.236.150.198:8190/content/about/public?type=serverAgreement"]]];
    
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
    //[self ShowNavigation:webView];
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
