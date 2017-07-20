//
//  DSYInvestHFViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/20.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYInvestHFViewController.h"
#import "XYSuccessController.h"
#import "XYPlanDetailController.h"
#import "LYDPlanDetailController.h"
#import "NewBidDetailController.h"
#import "BuyFenshuMarkVC.h"
#import "YiYueBiaoGouMaiViewController.h"

@interface DSYInvestHFViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */
@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation DSYInvestHFViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"购买";
    [self addUserAgen];
    [self contentWibView];
    [self loadData];
    [self backui];
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
    if ([self.discount isEqualToString:@"没有使用优惠券"]==YES) {
        //未使用优惠券
        [self.navigationController popViewControllerAnimated:YES];
        //self.navigationItem.leftBarButtonItems = @[self.returnButton, self.closeItem];
    } else {
        //使用优惠劵
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3] animated:YES];
    }
}


- (void)loadData {
    [self addUserAgen];
    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@", self.payUrl]]]];
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
    NSLog(@"shouldStartLoadWithRequest");
    NSLog(@"%@", request.URL.absoluteString);
    [self addUserAgen];
    // 成功回调地址   http://mertest.chinapnr.com/muser/bankcard/addCard
    if ([request.URL.absoluteString containsString:kSucessHuiFuCallBackUrl] || [request.URL.absoluteString isEqualToString:kSuccessHFCallBackUrl]) {
        self.isSuccess = YES;
//        [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
//            [self.navigationController pushViewController:[[XYSuccessController alloc] init] animated:YES];
//        }];
//        
//        return NO;
    }
    if ([request.URL.absoluteString containsString:@"flag="]) {//判断是不是触发了投资成功或者投资失败的确定按钮,通过是否包含flag=来确定
//        //http://116.236.150.198:8090/chinapnr/flag=4
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            
//            if ([controller isKindOfClass:[XYPlanDetailController class]]||[controller isKindOfClass:[LYDPlanDetailController class]]||[controller isKindOfClass:[NewBidDetailController class]]) {
//                
//                [self.navigationController popToViewController:controller animated:YES];
//                
//            }
//            
//        }
        //http://116.236.150.198:8090/chinapnr/flag=4
        //BuyFenshuMarkVC  份数标    YiYueBiaoGouMaiViewController  一月标
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
            if ([controller isKindOfClass:[BuyFenshuMarkVC class]]||[controller isKindOfClass:[YiYueBiaoGouMaiViewController class]]||[controller isKindOfClass:[NewBidDetailController class]]) {
                
                [self.navigationController popToViewController:controller animated:YES];
                
            }
            
        }
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
}

//- (void)back {
//    NSLog(@"自动返回");
//    if (self.isSuccess) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

@end
