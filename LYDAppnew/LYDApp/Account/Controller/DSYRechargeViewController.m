//
//  DSYRechargeViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/16.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYRechargeViewController.h"
#import "XYPlanDetailController.h"
#import "DSYSanbidDetailViewController.h"
#import "XYTransportDetailController.h"
#import "XYAccountController.h"

@interface DSYRechargeViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */
@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation DSYRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"充值";
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
    
    
    [self addUserAgen];
    
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/chinapnr/request/netSaveApp?amount=%f&userId=%ld", HFAPIREFIX, self.amount, [DSYUser sharedDSYUser].userId]]]];
    
}

- (void)addUserAgen {
    NSString *oldAgent = [self.contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//    NSLog(@"old agent :%@", oldAgent);
    NSString *newAgent;
    if ([oldAgent hasSuffix:@"lyd-app"]) {
        newAgent = oldAgent;
    } else {
        newAgent = [NSString stringWithFormat:@"%@lyd-app", oldAgent];
    }
//    NSLog(@"new agent :%@", newAgent);
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
    NSLog(@"%@", [self.contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]);
    NSLog(@"%@", request.URL.absoluteString);
    // 成功回调地址   http://mertest.chinapnr.com/muser/bankcard/addCard
    if ([request.URL.absoluteString containsString:kSucessHuiFuCallBackUrl] || [request.URL.absoluteString isEqualToString:kSuccessRechargeCallBackUrl]) {
        self.isSuccess = YES;
    }
    if ([request.URL.absoluteString containsString:@"flag="]) {//判断是不是触发了投资成功或者投资失败的确定按钮,通过是否包含flag=来确定
        //http://116.236.150.198:8090/chinapnr/flag=4
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            
//            if ([controller isKindOfClass:[XYAccountController class]]) {//如果从账户的充值入口过来,返回到用户界面,其他情况返回到上一级界面
//                
//                
//                [self.navigationController popToViewController:controller animated:YES];
//                return NO;
//                
//            }
//
//            
//        }

            
        self.tabBarController.selectedIndex = 2;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
       
        return NO;
        
    }
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
    if (self.contentWibView.isLoading) {
        NSLog(@"loading");
    } else {
        NSLog(@"not loading");
    }
}

- (void)back {
    NSLog(@"自动返回");
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        if (self.isSuccess) {
            // 如果充值页面来自于投资
            // 当前投资
            if (self.comeFrom == 1) {
                UIViewController *vc = [self haveRechargeVC];
                if (vc) {
                    [self.navigationController popToViewController:vc animated:YES];
                } else {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            } else {
                // 来自充值界面
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (UIViewController *)haveRechargeVC {
    NSArray *vces = self.navigationController.childViewControllers;
    for (UIViewController *vc in vces) {
        if ([vc isKindOfClass:[XYPlanDetailController class]] || [vc isKindOfClass:[DSYSanbidDetailViewController class]] || [vc isKindOfClass:[XYTransportDetailController class]]) {
            return vc;
        }
    }
    return nil;
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
