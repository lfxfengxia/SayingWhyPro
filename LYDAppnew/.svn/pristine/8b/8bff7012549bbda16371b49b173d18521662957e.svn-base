//
//  LDBDetailViewController.m
//  LYDApp
//零定宝项目详情
//  Created by fcl on 17/3/23.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "LDBDetailViewController.h"

@interface LDBDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */
@end

@implementation LDBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigaTitle = @"产品详情";
    [self contentWibView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES];
    //    [self loadData];
}

- (void)loadData {
   
//    标的详情页
//type:1零定宝 2专享标 3理财计划 4体验标
//    type：标的类型 bidId:标的id
//http://116.236.150.198:8490/product/selectBidInfo?type=4&bidId=7

    if ([self dx_isNullOrNilWithObject:self.model]) {
        NSString *strurl=[NSString stringWithFormat:@"%@/product/selectBidInfo?type=%@&bidId=%@",APIPREFIX,self.ZhuanXiangmodel.bidType,self.ZhuanXiangmodel.bidId];
         [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:strurl]]];
    }
    else
    {
        NSString *strurl=[NSString stringWithFormat:@"%@/product/selectBidInfo?type=%@&bidId=%@",APIPREFIX,self.model.bidType,self.model.planId];
         [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:strurl]]];
    }
    
    
   //[self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://116.236.150.198:8590/content/help/appTip?type=app"]]];

}

//判断对象是否为空

- (BOOL)dx_isNullOrNilWithObject:(id)object;
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
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
    }
    return _contentWibView;
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
}@end
