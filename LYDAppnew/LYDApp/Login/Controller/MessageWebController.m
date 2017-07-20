//
//  MessageWebController.m
//  LYDApp
//
//  Created by fcl on 17/3/24.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "MessageWebController.h"

@interface MessageWebController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */
@end

@implementation MessageWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigaTitle = @"消息";
    [self contentWibView];
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
   
//     UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
//    [self.navigationItem setBackBarButtonItem:backItem];

    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 40, 40);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backAction) name:@"xiaohui" object:nil];//销毁之前的消息
    
}



-(void)backAction
{
  [self dismissViewControllerAnimated:YES completion:^{
      
  }];


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES];
    //    [self loadData];
}


- (void)setDic:(NSDictionary *)dic {
    if (_dic != dic) {
        _dic = dic;
    }
     [self loadData];
}


- (void)loadData {
    
    
    //   [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/content/about/public?type=serverAgreement", APIPREFIX]]]];
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.dic[@"key"]]]];
    
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
