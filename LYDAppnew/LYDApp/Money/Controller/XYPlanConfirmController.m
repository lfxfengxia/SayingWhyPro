//
//  XYPlanConfirmController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/11.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYPlanConfirmController.h"
#import "XYSuccessController.h"
#import "DSYInvestHFViewController.h"
#import "DSYCouponModel.h"

@interface XYPlanConfirmController ()

@property (nonatomic, strong) UIView    *infoView;
@property (nonatomic, strong) UILabel   *mainTitleLabel;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *rateLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UILabel   *amountLabel;
@property (nonatomic, strong) UILabel   *totalMoneyLabel;
@property (nonatomic, strong) UILabel   *payMoneyLabel;
@property (nonatomic, strong) UILabel   *discountLabel;
@property (nonatomic, strong) UIButton  *confirmBtn;

@property (nonatomic, assign) CGFloat totalMoney;

@end

@implementation XYPlanConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"确认投资";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    self.totalMoney = [self.amount integerValue] * [self.model.perAmount integerValue];
    
    [self createUI];
}

- (void)createUI
{
    self.infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + KHeight(10), kSCREENW, KHeight(600/2))];
    self.infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.infoView];
    
    CGFloat labelW = kSCREENW - KWidth(20) * 2;
    CGFloat hMargin = KWidth(20);
    CGFloat vMargin = KHeight(20);
    CGFloat labelH = KHeight(13);
    UIFont  *textfont = [UIFont systemFontOfSize:KHeight(13)];
    
    self.mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(20), kSCREENW, KHeight(15))];
    self.mainTitleLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    self.mainTitleLabel.text = @"温馨提示";
    [self.infoView addSubview:self.mainTitleLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.mainTitleLabel.maxY + vMargin, labelW, labelH)];
    self.titleLabel.font = textfont;
    self.titleLabel.textColor = TEXTBLACK;
    self.titleLabel.text = [NSString stringWithFormat:@"投资标的：%@",self.model.title];
    [self.infoView addSubview:self.titleLabel];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.titleLabel.maxY + vMargin, labelW, labelH)];
    self.rateLabel.textColor = TEXTBLACK;
    self.rateLabel.font = textfont;
    
    CGFloat couponRate = 0;
    if (self.coupon.type == 3) {
        couponRate = self.coupon.amount;
    }
    
    self.rateLabel.text = [NSString stringWithFormat:@"年化收益率：%.2f%%",[self.model.apr floatValue]];
    [self.infoView addSubview:self.rateLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.rateLabel.maxY + vMargin, labelW, labelH)];
    self.timeLabel.textColor = TEXTBLACK;
    self.timeLabel.font = textfont;
    
    NSMutableString *period = [NSMutableString string];
    if ([self.model.periodUnit integerValue] == 0) {
        period = [NSMutableString stringWithFormat:@"%@个月",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == 1) {
        period = [NSMutableString stringWithFormat:@"%@天",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == -1) {
        period = [NSMutableString stringWithFormat:@"%@年",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == 2) {
        period = [NSMutableString stringWithFormat:@"%@周",self.model.periods];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"投资期限：%@",period];
    [self.infoView addSubview:self.timeLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(hMargin, self.timeLabel.maxY + vMargin, labelW, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    [self.infoView addSubview:line];
    
    self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, line.maxY + vMargin, labelW, labelH)];
    self.amountLabel.font = textfont;
    self.amountLabel.textColor = TEXTBLACK;
    self.amountLabel.text = [NSString stringWithFormat:@"投标份数：%@",self.amount];
    [self.infoView addSubview:self.amountLabel];
    
    self.totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.amountLabel.maxY + vMargin, labelW, labelH)];
    self.totalMoneyLabel.font = textfont;
    self.totalMoneyLabel.textColor = TEXTBLACK;
//    NSInteger totalMoney = [self.amount integerValue] * [self.model.money integerValue];
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"投标金额：%.2f元",self.totalMoney];
    [self.infoView addSubview:self.totalMoneyLabel];
    
    self.payMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.totalMoneyLabel.maxY + vMargin, labelW, labelH)];
    self.payMoneyLabel.font = textfont;
    self.payMoneyLabel.textColor = TEXTBLACK;
    NSInteger payMoney = ([self.amount integerValue] * [self.model.perAmount integerValue]);
    
    CGFloat couponAmount = 0;
    if (self.coupon.type == 2) {
        couponAmount = self.coupon.amount;
    }
    
    NSLog(@"%.2f", payMoney - couponAmount);
    self.payMoneyLabel.text = [NSString stringWithFormat:@"支付金额：%.2f元",payMoney - couponAmount];
    [self.infoView addSubview:self.payMoneyLabel];
    
    self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.payMoneyLabel.maxY + vMargin, labelW, labelH)];
    self.discountLabel.textColor = TEXTBLACK;
    self.discountLabel.font = textfont;
    self.discountLabel.text = [NSString stringWithFormat:@"使用优惠券：%@",self.discount];
    [self.infoView addSubview:self.discountLabel];
    
    self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(300)) / 2, self.infoView.maxY + KHeight(25), KWidth(300), KHeight(44))];
    [self.confirmBtn setTitle:@"确认投资" forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:ORANGECOLOR];
    [self.confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
    
//    if (self.totalMoney > 2000) {
//        
//        [self moneyNotEnough];
//        
//    }
}

- (void)confirmBtnClicked:(UIButton *)button
{
    [self doPay];
}

/**
 * 支付
 */
- (void)doPay {
    
    [MBProgressHUD showMessage:@"正在投资" toView:self.view];
    //investMoney  投资金额，bidType
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"investAmount":[NSNumber numberWithInteger:self.totalMoney],@"bidType":self.model.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"planId":[NSString stringWithFormat:@"%@",self.model.planId],@"num":[NSString stringWithFormat:@"%@",self.amount],@"couponId":self.couponId};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"investAmount":[NSNumber numberWithInteger:self.totalMoney],@"bidType":self.model.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"planId":[NSString stringWithFormat:@"%@",self.model.planId],@"num":[NSString stringWithFormat:@"%@",self.amount],@"couponId":self.couponId,@"sign":sign};
    
    
    NSString *strurl=[NSString stringWithFormat:@"%@/trade/plan/invest", APIPREFIX];
    
    // 开始请求数据
    [LYDTool sendPostWithUrl:strurl parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        NSString *msg=[backData valueForKey:@"message"];
        NSLog(@"%@", backData);
        if ([[backData valueForKey:@"code"] integerValue] == 200) {

            DSYInvestHFViewController *investVC = [[DSYInvestHFViewController alloc] init];
            investVC.payUrl = backData[@"payUrl"];
            [self.navigationController pushViewController:investVC animated:YES];
            
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"投资失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//            [self.view.window addSubview:errorHud];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger errorData = operation.response.statusCode;
        
        NSLog(@"%zi",operation.response.statusCode);
        
        if (errorData == 401) {
            // 401错误处理
            [DSYUtils showResponseError_401_ForViewController:self];
        } else if (errorData == 404) {
            [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该理财计划" okHandler:^(UIAlertAction *action) {
                [self pushToLoginController];
                
            } cancelHandler:^(UIAlertAction *action) {
            }];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    }];
    
}

- (void)moneyNotEnough
{
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + KHeight(10), kSCREENW, KHeight(44))];
    alertView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:alertView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KHeight(15), kSCREENW, KHeight(13))];
    textLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    textLabel.textColor = TEXTBLACK;
    textLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *upMoney = [[NSMutableAttributedString alloc] initWithString:@"抱歉！您的本次投资最高为7800元!"];
    [upMoney addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.89 green:0.02 blue:0.09 alpha:1.00] range:NSMakeRange(upMoney.length - 6, 4)];
    textLabel.attributedText = upMoney;
    [alertView addSubview:textLabel];
    
    self.infoView.y = alertView.maxY + KHeight(10);
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"投标金额：%zi",7800];
    NSInteger payMoney = (7800 - [self.discount integerValue]);
    self.payMoneyLabel.text = [NSString stringWithFormat:@"支付金额：%zi",payMoney];
    self.amountLabel.text = [NSString stringWithFormat:@"投标份数：%zi",7800/1000];
    self.confirmBtn.y = self.infoView.maxY + KHeight(25);
    
    UIButton *seeAgainBtn = [[UIButton alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(100)) / 2, self.confirmBtn.maxY + KHeight(20), KWidth(100), KHeight(15))];
    [seeAgainBtn setTitle:@"再看看" forState:UIControlStateNormal];
    [seeAgainBtn setTitleColor:ORANGECOLOR forState:UIControlStateNormal];
    seeAgainBtn.titleLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    [seeAgainBtn addTarget:self action:@selector(seeAgainClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seeAgainBtn];
    
    self.totalMoney = 7800;
}

- (void)seeAgainClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
