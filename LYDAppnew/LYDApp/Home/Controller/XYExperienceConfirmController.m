//
//  XYExperienceConfirmController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/15.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYExperienceConfirmController.h"
#import "XYSuccessController.h"

#import "DSYByExperienceViewController.h"
#import "DSYCouponModel.h"
#import "TiYanBiaoSeccessViewController.h"


@interface XYExperienceConfirmController ()

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



@end

@implementation XYExperienceConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"确认投资";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    [self createUI];
}

- (void)createUI
{
    self.infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + KHeight(10), kSCREENW, KHeight(600/2) - KHeight(20) - KHeight(13))];
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
    self.rateLabel.text = [NSString stringWithFormat:@"年化收益率：%.2f%%",[self.model.apr floatValue]];
    [self.infoView addSubview:self.rateLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.rateLabel.maxY + vMargin, labelW, labelH)];
    self.timeLabel.textColor = TEXTBLACK;
    self.timeLabel.font = textfont;
    NSMutableString *period = [NSMutableString string];
    if ([self.model.periodUnit integerValue] == 0) {
        period = [NSMutableString stringWithFormat:@"投资期限: %@个月",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 2, 2)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;

    } else if ([self.model.periodUnit integerValue] == 1) {
        period = [NSMutableString stringWithFormat:@"投资期限: %@天",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;

    } else if ([self.model.periodUnit integerValue] == -1) {
        period = [NSMutableString stringWithFormat:@"投资期限: %@年",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;

    } else if ([self.model.periodUnit integerValue] == 2) {
        period = [NSMutableString stringWithFormat:@"投资期限: %@周",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;

    }
    
//    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
//    [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
//    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
//    self.timeLabel.attributedText = timeAttr;
    [self.infoView addSubview:self.timeLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(hMargin, self.timeLabel.maxY + vMargin, labelW, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    [self.infoView addSubview:line];
    
    self.totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin,  line.maxY + vMargin, labelW, labelH)];
    self.totalMoneyLabel.font = textfont;
    self.totalMoneyLabel.textColor = TEXTBLACK;
    //    NSInteger totalMoney = [self.amount integerValue] * [self.model.money integerValue];
    
    CGFloat amount = 0;
    if (self.coupon != nil) {
        amount = self.coupon.amount;
    } else {
        amount = [self.model.minAmount floatValue];
    }
    
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"投标金额：%.2d元", 30000];
    [self.infoView addSubview:self.totalMoneyLabel];
    
    self.payMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.totalMoneyLabel.maxY + vMargin, labelW, labelH)];
    self.payMoneyLabel.font = textfont;
    self.payMoneyLabel.textColor = TEXTBLACK;
    
    self.payMoneyLabel.text = [NSString stringWithFormat:@"支付金额：%.2f元", 0.00];
    [self.infoView addSubview:self.payMoneyLabel];
    
    self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.payMoneyLabel.maxY + vMargin, labelW, labelH)];
    self.discountLabel.textColor = TEXTBLACK;
    self.discountLabel.font = textfont;
    self.discountLabel.text = [NSString stringWithFormat:@"体验金：￥30000"];
    [self.infoView addSubview:self.discountLabel];
    
    self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(300)) / 2, self.infoView.maxY + KHeight(25), KWidth(300), KHeight(44))];
    [self.confirmBtn setTitle:@"确认投资" forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:ORANGECOLOR];
    [self.confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
    
}

- (void)confirmBtnClicked:(UIButton *)button
{
    
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"bidsNewId":[NSString stringWithFormat:@"%@",self.model.bidId]};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"bidsNewId":[NSString stringWithFormat:@"%@",self.model.bidId],@"sign":sign};
    
    // 开始请求数据
    [MBProgressHUD showMessage:@"正在投资" toView:self.view];
    [LYDTool sendPostWithUrl:[NSString stringWithFormat:@"%@/trade/bidsNew/invest", APIPREFIX] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            
            // 如果是新手体验标就成功了
            if (self.model.type == 1) {
                [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
                    [MBProgressHUD showSuccess:backData[@"message"] toView:self.view];
                    // 确认体验后再后跳
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        //[self.navigationController popToRootViewControllerAnimated:YES];
                       // 体验标购买成功  跳转到新手标投资页面
                        
                        TiYanBiaoSeccessViewController *TiYanBiaoSeccess=[[TiYanBiaoSeccessViewController alloc] init];
                        TiYanBiaoSeccess.hidesBottomBarWhenPushed=YES;
                        [self.navigationController pushViewController:TiYanBiaoSeccess animated:YES];
                        
                        
                    });
                }];
            } else {
                // 否者就是购买的单彪
                //            XYSuccessController *suceessVC = [[XYSuccessController alloc] init];
                DSYByExperienceViewController *byVC = [[DSYByExperienceViewController alloc] init];
                NSString *url = backData[@"payUrl"];
                if (url.length > 0) {
                    byVC.payUrl = backData[@"payUrl"];
                    [self.navigationController pushViewController:byVC animated:YES];
                }
            }
            
            
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:backData[@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger errorData = operation.response.statusCode;
        
        NSLog(@"%zi",operation.response.statusCode);
        
        if (errorData == 401) {
            // 401错误处理
            [DSYUtils showResponseError_401_ForViewController:self];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    }];
    
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
