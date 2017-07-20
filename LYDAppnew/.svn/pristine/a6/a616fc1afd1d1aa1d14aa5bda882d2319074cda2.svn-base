//
//  FenxiaoHuoDongViewController.m
//  LYDApp
//
//  Created by fcl on 2017/4/25.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "FenxiaoHuoDongViewController.h"
#import "XYBannerModel.h"


#import "DSYAskFriendsViewController.h"
#import "ZWVerticalAlignLabel.h"
#import "DSYSocityCollectionViewCell.h"
#import "DSYAccountQRCodeController.h"
#import "DSYTipViewController.h"
#import "DSYInviteRuleViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "DSYInviteDetailViewController.h"
#import "DSYInviteInvestController.h"
#import "UMSocialQQHandler.h"
#import <objc/runtime.h>
//#import "PictureViewCtr.h"
#import "AlertFenXiangGuoDongVC.h"
@interface FenxiaoHuoDongViewController ()<UIWebViewDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIWebView *contentWibView;
@property (nonatomic,strong) AlertFenXiangGuoDongVC *pictureVC;
@end

@implementation FenxiaoHuoDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(225, 225, 225);
    [self contentWibView];
    
    self.navigaTitle =[self isBlankString:_gongxiangDic[@"title"]]?@"":_gongxiangDic[@"title"];
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

- (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}



- (void)loadData {
    
    
       [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?token=%@&appKey=%@",_gongxiangDic[@"activityUrl"],TOKEN,APPKEY]]]];
    
//    [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_gongxiangDic[@"activityUrl"]]]];
}

- (UIWebView *)contentWibView {
    if (!_contentWibView) {
        _contentWibView = [[UIWebView alloc] init];
        [self.view addSubview:_contentWibView];
        _contentWibView.backgroundColor = self.view.backgroundColor;
        [_contentWibView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        _contentWibView.delegate = self;
        
    }
    return _contentWibView;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    NSLog(@"%@", request.URL.absoluteString);
    // 成功回调地址   http://mertest.chinapnr.com/muser/bankcard/addCard
    
    
    
    NSString *urlStr = request.URL.absoluteString;
    NSString *b = [urlStr substringFromIndex:urlStr.length-1];
    if ([urlStr rangeOfString:@"flag"].location!=NSNotFound)
    {
        if ([b isEqualToString:@"4"])
        {
            
            [self fenxiangUI];
            return NO;
        }
        else if([b isEqualToString:@"1"])//未登录跳转到登录页面
        {
            
            [self pushToLoginController];
            [self.navigationController popViewControllerAnimated:NO];
            return NO;
        }
        
        
    }
    
    
    
    return YES;
}





-(void)fenxiangUI
{
    
    _fugaiview=[[UIView alloc] init];
    _fugaiview.frame=self.view.bounds;
    _fugaiview.backgroundColor=[UIColor clearColor];
    //    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    //
    //    btn.frame=CGRectMake(20, 200, 80, 40);
    //    btn.backgroundColor=[UIColor redColor];
    //    [btn addTarget:self action:@selector(btnbtn) forControlEvents:UIControlEventTouchUpInside];
    //    [_fugaiview addSubview:btn];
    
    
    // 单击的 Recognizer
    
    
    
    UIView * imageView   = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2,200,160, 100)];
    imageView.backgroundColor=[UIColor whiteColor];
    imageView.layer.cornerRadius=5;
    NSMutableArray   *PicArr=[[NSMutableArray alloc]initWithObjects:@"微信",@"朋友圈",@"腾讯QQ", nil];
    UIButton *shareImage1=[[UIButton alloc]initWithFrame:CGRectMake(5+10,10,40,40)];
    [shareImage1 setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    shareImage1.tag=101;
    [shareImage1 addTarget: self action:@selector(fenxiang:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareImage1];
    //标题
    UILabel *titelabel1=[[UILabel alloc]initWithFrame:CGRectMake(5+10,50,40,30)];
    titelabel1.textAlignment=NSTextAlignmentCenter;
    titelabel1.font=[UIFont systemFontOfSize:10];
    titelabel1.text=PicArr[0];
    [imageView addSubview:titelabel1];
    
    
    
    
    
    UIButton *shareImage2=[[UIButton alloc]initWithFrame:CGRectMake(5+45+10,10,40,40)];
    [shareImage2 setBackgroundImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
    shareImage2.tag=102;
    [shareImage2 addTarget: self action:@selector(fenxiang:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareImage2];
    //标题
    UILabel *titelabel2=[[UILabel alloc]initWithFrame:CGRectMake(5+45+10,50,40,30)];
    titelabel2.textAlignment=NSTextAlignmentCenter;
    titelabel2.font=[UIFont systemFontOfSize:10];
    titelabel2.text=PicArr[1];
    [imageView addSubview:titelabel2];
    
    
    
    UIButton *shareImage3=[[UIButton alloc]initWithFrame:CGRectMake(5+45+45+10,10,40,40)];
    [shareImage3 setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    shareImage3.tag=103;
    [shareImage3 addTarget: self action:@selector(fenxiang:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareImage3];
    //标题
    UILabel *titelabel3=[[UILabel alloc]initWithFrame:CGRectMake(5+45+45+10,50,40,30)];
    titelabel3.textAlignment=NSTextAlignmentCenter;
    titelabel3.font=[UIFont systemFontOfSize:10];
    titelabel3.text=PicArr[2];
    [imageView addSubview:titelabel3];
    
    
    
    
    
    //  [self addSubview:imageView];
    
    
    
    
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    
    
    //给self.view添加一个手势监测；
    
    [_fugaiview addGestureRecognizer:singleRecognizer];
    [_fugaiview addSubview:imageView];
    
    
    UIWindow *w=[[UIApplication sharedApplication].windows lastObject];
    
    [w addSubview:_fugaiview];
    
}


-(void)fenxiang:(UIButton*)btn
{
    
    NSString *getNum=[NSString stringWithFormat:@"%ld",(long)btn.tag];
    [self shareClick:getNum];
    
}

-(void)shareClick:(NSString*)fenxiangtype
{
    
    
    [self fenxiangdata:fenxiangtype];
    
}


-(void)fenxiangdata:(NSString*)fenxiangtype
{
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign};
    NSString *URL_strLogin=[NSString stringWithFormat:@"%@%@",APIPREFIX,@"/activity/responsePartookParameterBox"];
    [LYDTool sendGetWithUrl:URL_strLogin parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            
            //                @property (nonatomic,copy)NSString *describe;
            //                @property (nonatomic,copy)NSString *imgStr;
            //                @property (nonatomic,copy)NSString *partookStr;
            //                @property (nonatomic,copy)NSString *partookUrl;
            //                @property (nonatomic,copy)NSString *title;
            _describe=backData[@"describe"];
            _imgStr=backData[@"imgStr"];
            _partookStr=backData[@"partookStr"];
            _partookUrl=backData[@"partookUrl"];
            _strtitle=backData[@"title"];
            
            if ([fenxiangtype isEqualToString:@"101"]) {
                
                // 微信好友分享
                [self shareToPlatFormWithType:UMSocialPlatformType_WechatSession];
                
                
            }
            if ([fenxiangtype isEqualToString:@"102"]) {
                // 微信朋友圈
                [self shareToPlatFormWithType:UMSocialPlatformType_WechatTimeLine];
                
            }
            
            if ([fenxiangtype isEqualToString:@"103"]) {
                // QQ好友
                [self shareToPlatFormWithType:UMSocialPlatformType_QQ];
                
                
                
            }
            
            
            
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
    
}



-(void)GetShowData
{
    [self dismiss];
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"partookStr":_partookStr};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"partookStr":_partookStr,@"sign":sign};
    NSString *URL_strLogin=[NSString stringWithFormat:@"%@%@",APIPREFIX,@"/content/partookSuccessCallbacksBox"];
    [LYDTool sendPostWithUrl:URL_strLogin parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        
        if ([[backData valueForKey:@"code"] integerValue] == 200)
        {
            
            

            NSString      *msg=[backData objectForKey:@"message"];
            if ([msg integerValue]==1) {
                _pictureVC = [[AlertFenXiangGuoDongVC alloc] initWithImageName:@"bgFenXianghuodong" ButtonName:@"HuoDongconSurefigUI1" Amount:@"" JumpBlock:^{
                    
                    
                    NSLog(@"tt11");
                    
                    //                                                        _pictureVC = [[PictureViewCtr alloc] initWithImageName:@"20元现金抵用券" ButtonName:@"确定" Amount:@"0" JumpBlock:^{
                    //
                    //
                    //                                                            NSLog(@"tt1111");
                    //
                    // 
                    //
                    //
                    //                                                        }];
                    //
                    //                                                        _pictureVC.transitioningDelegate = self;
                    //                                                        _pictureVC.modalPresentationStyle = UIModalPresentationCustom;
                    //
                    //                                                        [self presentViewController:_pictureVC animated:NO completion:nil];
                    
                    
                    
                }];
                
                _pictureVC.transitioningDelegate = self;
                _pictureVC.modalPresentationStyle = UIModalPresentationCustom; 
                
                [self presentViewController:_pictureVC animated:NO completion:nil];

            }
            
        }
        else
        {
            
        }
        
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
    
}







#pragma mark - 分享各个平台
- (void)shareToPlatFormWithType:(UMSocialPlatformType)type {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_imgStr]];
    UIImage *img=[UIImage imageWithData:data];
    
    
    
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    // NSString* thumbURL = _imgStr;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_strtitle descr:_describe thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = _partookUrl;//分享链接
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = @"";
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
            [self GetShowData];
        } else {
            message = [NSString stringWithFormat:@"分享成功"];
            
        }
    }];
    
}



/**
 *  销毁
 */
- (void)dismiss
{
    [_fugaiview removeFromSuperview];
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
    //    [MBProgressHUD hideHUDForView:self.view];
    //    [MBProgressHUD showError:@"网络繁忙" toView:self.view];
    //    NSLog(@"didFailLoadWithError");
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
