//
//  XYExperienceController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/15.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYExperienceController.h"
#import "XYExperienceConfirmController.h"
#import "XYExperiencePlanDetailController.h"
#import "XYJoinRecordController.h"
#import "XYCommentController.h"
#import "XYQuestionController.h"

#import "XYExperienceDetailCell.h"

#import "XYJoinRecordModel.h"
#import "XYRecordCell.h"

#import "XYQACell.h"
#import "XYQAModel.h"

#import "XYCustomCommentCell.h"
#import "XYCustomCommentModel.h"
#import "DSYCouponModel.h"
#import "LDBDetailViewController.h"
#import "DSYHelpWebViewController.h"
#import "ChangJianWenTiViewController.h"

@interface XYExperienceController ()

@property (nonatomic, strong) UIView        *mainHeadView;
@property (nonatomic, strong) UIView        *infoHeadView;
@property (nonatomic, strong) UILabel       *rateTextLabel;
@property (nonatomic, strong) UILabel       *rateLabel;
@property (nonatomic, strong) UILabel       *timeTextLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UILabel       *moneyTextLabel;
@property (nonatomic, strong) UILabel       *moneyLabel;

@property (nonatomic, strong) UIView        *payView;
@property (nonatomic, strong) UIImageView   *pointIV;
@property (nonatomic, strong) UILabel       *balanceTextLabel;
@property (nonatomic, strong) UILabel       *balanceLabel;
@property (nonatomic, strong) UILabel       *discountLabel;
@property (nonatomic, strong) UIImageView   *nextIV;
@property (nonatomic, strong) UIImageView   *preBenifitIV;
@property (nonatomic, strong) UILabel       *preBenifitTextLabel;
@property (nonatomic, strong) UILabel       *preBenifitLabel;

@property (nonatomic, strong) UIScrollView  *btnView;
@property (nonatomic, strong) UIButton      *planDetailBtn;
@property (nonatomic, strong) UIButton      *recordBtn;
@property (nonatomic, strong) UIButton      *questionBtn;
@property (nonatomic, strong) UIButton      *commentBtn;

@property (nonatomic, strong) UIScrollView  *mainSV;
@property (nonatomic, strong) UIButton      *doneBtn;

@property (nonatomic, strong) DSYCouponModel *coupon;

@end

@implementation XYExperienceController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.titleNavigationBarLabel.text = @"新手体验标";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    [self createUI];
    [self createPayUI];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([DSYAccount sharedDSYAccount].canInvestNew == 0) {
        self.doneBtn.enabled = NO;
        self.doneBtn.backgroundColor = [UIColor colorWithRed:0.73 green:0.68 blue:0.65 alpha:1.00];
        self.balanceLabel.text = @"仅限新用户购买";
        self.balanceLabel.textColor = [UIColor colorWithRed:0.73 green:0.68 blue:0.65 alpha:1.00];
    }
    if ([DSYAccount sharedDSYAccount].canInvestNew == 1) {
        self.doneBtn.enabled = YES;
        self.doneBtn.backgroundColor = ORANGECOLOR;
        self.balanceLabel.textColor = ORANGECOLOR;
    }
}

- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@/user/coupons/experience", APIPREFIX];
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            NSMutableArray *tempArr = [DSYCouponModel baseModelByArr:backData[@"couponModelList"]];
            if (tempArr.count > 0) {
                self.coupon = [tempArr firstObject];
                
                [self setupMyUI];
            } else {
                
            }
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorDealWithOperation:operation];
    }];
}


- (void)setupMyUI {
    self.balanceLabel.text = [NSString stringWithFormat:@"￥%.2f", self.coupon.amount];
    NSInteger periods = [self.model.periods integerValue];
    CGFloat rate = [self.model.apr floatValue] / 100  / 12;
    // 如果是日
    if ([self.model.periodUnit integerValue] == 1) {
        // 日
        rate = [self.model.apr floatValue] / 365 / 100;
    } else if ([self.model.periodUnit integerValue] == -1) {
        // 年
        rate = [self.model.apr floatValue] / 100;
    } else if ([self.model.periodUnit integerValue] == 2) {
        // 周
        rate = [self.model.apr floatValue] * 7 / 365 / 100;
    }
    
//    self.preBenifitLabel.text = [NSString stringWithFormat:@"￥%.2f", self.coupon.amount *  periods * rate];
    self.preBenifitLabel.text = @"￥5.00";
}


#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger errorData = operation.response.statusCode;
    NSLog(@"%zi",operation.response.statusCode);
    if (errorData == 401) {
        // 401错误处理
        [DSYUtils showResponseError_401_ForViewController:self];
    } else if (errorData == 404) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"未知错误" okHandler:^(UIAlertAction *action) {
            //            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}

- (void)createUI
{
    self.mainHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, KHeight(1210/2))];
    self.mainHeadView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    [self.view addSubview:self.mainHeadView];
    
    self.infoHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(110))];
    self.infoHeadView.backgroundColor = [UIColor whiteColor];
    [self.mainHeadView addSubview:self.infoHeadView];
    
    CGFloat hMargin = (kSCREENW - (KWidth(58/2) * 2) - (KWidth(150/2) * 3)) / 2;
    CGFloat labelW  = KWidth(150/2);
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(58/2), KHeight(30), labelW, KHeight(11))];
    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.rateTextLabel.textColor = TEXTGARY;
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.text = @"预期年化利率";
    [self.infoHeadView addSubview:self.rateTextLabel];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateTextLabel.x, self.rateTextLabel.maxY + KHeight(12), self.rateTextLabel.width, KHeight(22))];
    self.rateLabel.textColor = ORANGECOLOR;
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(28)];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *rateAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f%%",[self.model.apr floatValue]]];
    [rateAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(rateAttr.length - 1, 1)];
    self.rateLabel.attributedText = rateAttr;
    [self.infoHeadView addSubview:self.rateLabel];
    
    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateTextLabel.maxX + hMargin, self.rateTextLabel.y, labelW, KHeight(11))];
    self.timeTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.timeTextLabel.textColor = TEXTGARY;
    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.timeTextLabel.text = @"投资期限";
    [self.infoHeadView addSubview:self.timeTextLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeTextLabel.x, self.timeTextLabel.maxY + KHeight(12), self.timeTextLabel.width, KHeight(22))];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(28)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    
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
    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(timeAttr.length - 1, 1)];
    [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(timeAttr.length - 1, 1)];
    self.timeLabel.attributedText = timeAttr;
    [self.infoHeadView addSubview:self.timeLabel];
    
    self.moneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeTextLabel.maxX + hMargin - 10, self.timeTextLabel.y, labelW + 10, KHeight(11))];
    self.moneyTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.moneyTextLabel.textColor = TEXTGARY;
    self.moneyTextLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyTextLabel.text = @"单份金额";
    [self.infoHeadView addSubview:self.moneyTextLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyTextLabel.x, self.moneyTextLabel.maxY + KHeight(12), self.moneyTextLabel.width, KHeight(22))];
    self.moneyLabel.textColor = [UIColor blackColor];
    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(28)];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",self.model.minAmount]];
    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(moneyAttr.length - 1, 1)];
    [moneyAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(moneyAttr.length - 1, 1)];
    self.moneyLabel.attributedText = moneyAttr;
    [self.infoHeadView addSubview:self.moneyLabel];
    
    self.mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.mainHeadView.maxY, kSCREENW, kSCREENH - 64 - KHeight(44) - self.mainHeadView.height)];
    self.mainSV.backgroundColor = [UIColor whiteColor];
    self.mainSV.contentSize = CGSizeMake(kSCREENW * 6, 0);
    self.mainSV.scrollEnabled = NO;
    [self.view addSubview:self.mainSV];
    

    self.doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSCREENH - KHeight(44), kSCREENW, KHeight(44))];
    [self.doneBtn setBackgroundColor:ORANGECOLOR];
    [self.doneBtn setTitle:@"立即投资" forState:UIControlStateNormal];
    [self.doneBtn addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
}

- (void)createPayUI
{
    self.payView = [[UIView alloc] initWithFrame:CGRectMake(0, self.infoHeadView.maxY + KHeight(10), kSCREENW, KHeight(283/2))];
    self.payView.backgroundColor = [UIColor whiteColor];
    [self.mainHeadView addSubview:self.payView];
    
    self.pointIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth(70/2), KHeight(197/2))];
    self.pointIV.image = [UIImage imageNamed:@"transportLinePic"];
    [self.payView addSubview:self.pointIV];
    
    self.balanceTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.pointIV.maxX + KWidth(6), KHeight(37/2), KWidth(150/2), KHeight(13))];
    self.balanceTextLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.balanceTextLabel.textColor = TEXTBLACK;
    self.balanceTextLabel.text = @"投资金额：";
    [self.payView addSubview:self.balanceTextLabel];
    
    self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.balanceTextLabel.maxX, self.balanceTextLabel.y, kSCREENW - self.balanceTextLabel.maxX - KWidth(60) - KWidth(40), KHeight(13))];
    self.balanceLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.balanceLabel.textColor = ORANGECOLOR;
    self.balanceLabel.adjustsFontSizeToFitWidth = YES;
    self.balanceLabel.text = [NSString stringWithFormat:@"￥%@", self.model.minAmount];
    [self.payView addSubview:self.balanceLabel];
    
    UIView  *line1 = [[UIView alloc] initWithFrame:CGRectMake(self.balanceTextLabel.x, self.balanceTextLabel.maxY + KWidth(17) - 1, kSCREENW - self.balanceTextLabel.x, 1)];
    line1.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    [self.payView addSubview:line1];
    
    self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.balanceTextLabel.x, line1.maxY + KHeight(20), kSCREENW - self.balanceTextLabel.x - KWidth(28) - KWidth(40), KHeight(12))];
    self.discountLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.discountLabel.textColor = TEXTGARY;
    self.discountLabel.text = @"新手标不允许使用优惠券";
    [self.payView addSubview:self.discountLabel];

    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(self.discountLabel.x, self.discountLabel.maxY + KHeight(17) - 1, kSCREENW - self.discountLabel.x, 1)];
    line3.backgroundColor = line1.backgroundColor;
    [self.payView addSubview:line3];
    
    self.preBenifitIV = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(12), line3.maxY + KWidth(12), KWidth(22), KWidth(22))];
    self.preBenifitIV.image = [UIImage imageNamed:@"money"];
    [self.payView addSubview:self.preBenifitIV];
    
    self.preBenifitTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.preBenifitIV.maxX + KWidth(7), line3.maxY + KHeight(16), self.balanceTextLabel.width, self.balanceTextLabel.height)];
    self.preBenifitTextLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.preBenifitTextLabel.textColor = TEXTBLACK;
    self.preBenifitTextLabel.text = @"预计收益：";
    [self.payView addSubview:self.preBenifitTextLabel];
    
    self.preBenifitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.preBenifitTextLabel.maxX, self.preBenifitTextLabel.y - 1, kSCREENW - self.preBenifitTextLabel.maxY - KWidth(20), KHeight(15))];
    //self.preBenifitLabel.text = [NSString stringWithFormat:@"%.2f", [self.model.minAmount floatValue] * ([self.model.apr floatValue] / 100) / 365];
    self.preBenifitLabel.text = @"￥5.00";
    self.preBenifitLabel.textColor = [UIColor colorWithRed:0.89 green:0.00 blue:0.07 alpha:1.00];
    self.preBenifitLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    [self.payView addSubview:self.preBenifitLabel];
    
    [self createButtonView];
    
}

- (void)createButtonView
{
    self.btnView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.payView.maxY + KHeight(10), kSCREENW, KHeight(438/2))];
    self.btnView.showsHorizontalScrollIndicator = NO;
    [self.mainHeadView addSubview:self.btnView];
    
    CGFloat btnW = KWidth(376/2);
    CGFloat btnH = KHeight(220/2);
    
    self.planDetailBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnW, btnH)];
    [self.planDetailBtn setBackgroundImage:[UIImage imageNamed:@"detailBtn"] forState:UIControlStateNormal];
    [self.planDetailBtn addTarget:self action:@selector(planDetailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.planDetailBtn.adjustsImageWhenHighlighted = NO;
    [self.btnView addSubview:self.planDetailBtn];
    
    self.recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnW, 0, btnW, btnH)];
    [self.recordBtn setBackgroundImage:[UIImage imageNamed:@"joinBtn"] forState:UIControlStateNormal];
    [self.recordBtn addTarget:self action:@selector(recordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.recordBtn.adjustsImageWhenHighlighted = NO;
    [self.btnView addSubview:self.recordBtn];
    
    self.questionBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnW, btnH, btnW, btnH)];
    [self.questionBtn setBackgroundImage:[UIImage imageNamed:@"questionBtn"] forState:UIControlStateNormal];
    [self.questionBtn addTarget:self action:@selector(questionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.questionBtn.adjustsImageWhenHighlighted = NO;
    [self.btnView addSubview:self.questionBtn];
    
    self.commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, btnH, btnW, btnH)];
    [self.commentBtn setBackgroundImage:[UIImage imageNamed:@"commentBtn"] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.commentBtn.adjustsImageWhenHighlighted = NO;
    [self.btnView addSubview:self.commentBtn];
    
    self.btnView.contentSize = CGSizeMake(self.commentBtn.maxX, 0);
    self.btnView.bounces = NO;
    
}

- (void)doneBtnClicked:(UIButton *)button
{
    
    
    
    
    if ([DSYAccount sharedDSYAccount].ipsAccount.length <= 0) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"用户未开户，请进行开户" okHandler:^(UIAlertAction *action) {
            DSYOpenAccountController *oppenAccountVC = [[DSYOpenAccountController alloc] initWithType:DSYOpenAccountControllerFromTypeNone];
            oppenAccountVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:oppenAccountVC animated:YES];
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        
        XYExperienceConfirmController *confirmVC = [[XYExperienceConfirmController alloc] init];
        confirmVC.model = self.model;
        //    confirmVC.coupon = self.coupon;
        [self.navigationController pushViewController:confirmVC animated:YES];
    }

    
    
    
    
//    XYExperienceConfirmController *confirmVC = [[XYExperienceConfirmController alloc] init];
//    confirmVC.model = self.model;
////    confirmVC.coupon = self.coupon;
//    [self.navigationController pushViewController:confirmVC animated:YES];
}


- (void)planDetailBtnClicked:(UIButton *)button
{
    LDBDetailViewController *planDetailVC = [[LDBDetailViewController alloc] init];
    planDetailVC.ZhuanXiangmodel = self.model;
    [self.navigationController pushViewController:planDetailVC animated:YES];
    
}

- (void)recordBtnClicked:(UIButton *)button 
{
    XYJoinRecordController *planDetailVC = [[XYJoinRecordController alloc] init];
    planDetailVC.planId = self.model.bidId;
    planDetailVC.type = @"新手体验标";
    [self.navigationController pushViewController:planDetailVC animated:YES];
}

- (void)questionBtnClicked:(UIButton *)button
{
    ChangJianWenTiViewController *helpVC = [[ChangJianWenTiViewController alloc] init];
    helpVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:helpVC animated:YES];
    
}

- (void)commentBtnClicked:(UIButton *)button
{
    XYCommentController *planDetailVC = [[XYCommentController alloc] init];
    planDetailVC.planId = self.model.bidId;
    planDetailVC.productType = [self.model.bidType  integerValue];
    [self.navigationController pushViewController:planDetailVC animated:YES];
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
