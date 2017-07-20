//
//  DSYAssignServiceController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAssignServiceController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface DSYAssignServiceController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */

@end

@implementation DSYAssignServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"转让协议";
    [self addUserAgen];
    [self contentWibView];
    
    //    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData {

    
    [self addUserAgen];
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://lyd-invest-weixin.doolab.cn/content/help/detail/230"]]]];
    
}

- (void)addUserAgen {
    NSString *oldAgent = [_contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
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
    [self addUserAgen];
//    // 成功回调地址   http://mertest.chinapnr.com/muser/bankcard/addCard
//    if ([request.URL.absoluteString containsString:kSucessHuiFuCallBackUrl] || [request.URL.absoluteString isEqualToString:@"http://lyd-invest.doolab.cn/chinapnr/response/cash"]) {
//        self.isSuccess = YES;
//    }
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
    // 修改方法
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *alertJS=@"var back = document.getElementsByClassName('top-bar return bk-ff')[0];"
    "back.href=\"javascript:(void)\""
    "back.onClick=backPreController;"
    ""; //准备执行的js代码
    context[@"backPreController"] = ^() {
        [self.navigationController popViewControllerAnimated:YES];
        return false;
    };
    
    [context evaluateScript:alertJS];//通过oc方法调用js的alert
    
}


//- (void)backPreController {
//    [self.navigationController popViewControllerAnimated:YES];
//}


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
