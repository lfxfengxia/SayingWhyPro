//
//  XYSanBidDetailController.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYSanBidDetailController.h"
#import "XYSanBidPlanDetailController.h"
#import "XYJoinRecordController.h"
#import "XYCommentController.h"
#import "XYQuestionController.h"

#import "XYSanBidDetailModel.h"
#import "XYSanBidDetailCell.h"

#import "XYJoinRecordModel.h"
#import "XYRecordCell.h"

#import "XYCustomCommentModel.h"
#import "XYCustomCommentCell.h"

#import "XYQACell.h"
#import "XYQAModel.h"
#import "DSYHelpWebViewController.h"
#import "ChangJianWenTiViewController.h"

@interface XYSanBidDetailController ()

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
@property (nonatomic, strong) UILabel       *lastMoneyTextLabel;
@property (nonatomic, strong) UILabel       *lastMoneyLabel;
@property (nonatomic, strong) UILabel       *balanceTextLabel;
@property (nonatomic, strong) UILabel       *balanceLabel;
@property (nonatomic, strong) UIButton      *topUpButton;
@property (nonatomic, strong) UILabel       *amountTextLabel;
@property (nonatomic, strong) UITextField   *amountTF;
@property (nonatomic, strong) UILabel       *discountLabel;
@property (nonatomic, strong) UIImageView   *preBenifitIV;
@property (nonatomic, strong) UILabel       *preBenifitTextLabel;
@property (nonatomic, strong) UILabel       *preBenifitLabel;

@property (nonatomic, strong) UIScrollView  *btnView;
@property (nonatomic, strong) UIButton      *planDetailBtn;
@property (nonatomic, strong) UIButton      *recordBtn;
@property (nonatomic, strong) UIButton      *questionBtn;
@property (nonatomic, strong) UIButton      *commentBtn;


@property (nonatomic, copy) NSString        *amount;
@property (nonatomic, copy) NSString        *myBalance;

@property (nonatomic, strong) UIScrollView  *mainSV;
@property (nonatomic, strong) UIButton      *doneBtn;

@end

@implementation XYSanBidDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = self.model.title;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    [self createPayUI];
    
    self.amount = @"100";
    self.myBalance = @"0";
    
    NSLog(@"%f",self.btnView.y);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadMyBalance];
}


/**
 * 获取当前用户的余额
 */
- (void)loadMyBalance {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    // 开始请求数据
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/balance", APIPREFIX] parameters:para success:^(id data) {
        
        id backData = LYDJSONSerialization(data);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            self.myBalance = [NSString stringWithFormat:@"%@",[backData valueForKey:@"balance"]];
            if (self.balanceLabel) {
                self.balanceLabel.text = [NSString stringWithFormat:@"¥%@元",self.myBalance];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
        }
        
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger errorData = operation.response.statusCode;
        
        NSLog(@"%zi",operation.response.statusCode);
        
        if (errorData == 401) {
            // 401错误处理
            [DSYUtils showResponseError_401_ForViewController:self];
        } else if (errorData == 404) {
            [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
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


- (void)createUI
{
    self.mainHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, KHeight(1210/2))];
    self.mainHeadView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    [self.view addSubview:self.mainHeadView];
    
    self.infoHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(90))];
    self.infoHeadView.backgroundColor = [UIColor whiteColor];
    [self.mainHeadView addSubview:self.infoHeadView];
    
    CGFloat hMargin = (kSCREENW - KWidth(10) * 2 - (KWidth(200/2) * 3)) / 2;
    CGFloat labelW  = KWidth(200/2);
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(40/2), KHeight(20), labelW, KHeight(11))];
    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.rateTextLabel.textColor = TEXTGARY;
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.text = @"借款总额";
    [self.infoHeadView addSubview:self.rateTextLabel];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateTextLabel.x, self.rateTextLabel.maxY + KHeight(12), self.rateTextLabel.width, KHeight(22))];
    self.rateLabel.textColor = [UIColor blackColor];
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(24)];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *rateAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",self.model.amount]];
    [rateAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(rateAttr.length - 1, 1)];
    [rateAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(rateAttr.length - 1, 1)];
    self.rateLabel.attributedText = rateAttr;
    [self.infoHeadView addSubview:self.rateLabel];
    
    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateTextLabel.maxX + hMargin, self.rateTextLabel.y, labelW, KHeight(11))];
    self.timeTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.timeTextLabel.textColor = TEXTGARY;
    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.timeTextLabel.text = @"预期年化利率";
    [self.infoHeadView addSubview:self.timeTextLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeTextLabel.x, self.timeTextLabel.maxY + KHeight(12), self.timeTextLabel.width, KHeight(22))];
    self.timeLabel.textColor = ORANGECOLOR;
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(28)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f%%",[self.model.apr floatValue] * 100]];
    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(timeAttr.length - 1, 1)];
    self.timeLabel.attributedText = timeAttr;
    [self.infoHeadView addSubview:self.timeLabel];
    
    self.moneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeTextLabel.maxX + hMargin - 10, self.timeTextLabel.y, labelW + 10, KHeight(11))];
    self.moneyTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.moneyTextLabel.textColor = TEXTGARY;
    self.moneyTextLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyTextLabel.text = @"投资期限";
    [self.infoHeadView addSubview:self.moneyTextLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyTextLabel.x, self.moneyTextLabel.maxY + KHeight(12), self.moneyTextLabel.width, KHeight(22))];
    self.moneyLabel.textColor = [UIColor blackColor];
    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(28)];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableString *period = [NSMutableString string];
    if ([self.model.periodUnit integerValue] == 0) {
        period = [NSMutableString stringWithFormat:@"%@月",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == 1) {
        period = [NSMutableString stringWithFormat:@"%@日",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == -1) {
        period = [NSMutableString stringWithFormat:@"%@年",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == 2) {
        period = [NSMutableString stringWithFormat:@"%@周",self.model.periods];
    }
    
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
    [moneyAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([moneyAttr length] - 1, 1)];
    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([moneyAttr length] - 1, 1)];
    self.moneyLabel.attributedText = moneyAttr;    [self.infoHeadView addSubview:self.moneyLabel];
    
    self.mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.mainHeadView.maxY, kSCREENW, kSCREENH - 64 - KHeight(44) - self.mainHeadView.height)];
    self.mainSV.backgroundColor = [UIColor whiteColor];
    self.mainSV.contentSize = CGSizeMake(kSCREENW * 7, 0);
    self.mainSV.scrollEnabled = NO;
    [self.view addSubview:self.mainSV];
    
    self.doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSCREENH - KHeight(44), kSCREENW, KHeight(44))];
    [self.doneBtn setBackgroundColor:[UIColor colorWithRed:0.73 green:0.68 blue:0.65 alpha:1.00]];
    [self.doneBtn setTitle:@"已售罄" forState:UIControlStateNormal];
    [self.doneBtn addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
}


- (void)createPayUI
{
    
    self.payView = [[UIView alloc] initWithFrame:CGRectMake(0, self.infoHeadView.maxY + KHeight(10), kSCREENW, KHeight(491/2))];
    self.payView.backgroundColor = [UIColor whiteColor];
    [self.mainHeadView addSubview:self.payView];
    
    self.lastMoneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(20), KWidth(60), KHeight(13))];
    self.lastMoneyTextLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    self.lastMoneyTextLabel.text = @"剩余金额";
    [self.payView addSubview:self.lastMoneyTextLabel];
    
    self.lastMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.lastMoneyTextLabel.maxX + KWidth(20), self.lastMoneyTextLabel.y, kSCREENW - self.lastMoneyTextLabel.maxX - KWidth(20) * 2, self.lastMoneyTextLabel.height)];
    self.lastMoneyLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    self.lastMoneyLabel.textColor = TEXTGARY;
    self.lastMoneyLabel.textAlignment = NSTextAlignmentRight;
    self.lastMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",self.model.leftAmount];
    [self.payView addSubview:self.lastMoneyLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.lastMoneyTextLabel.x, self.lastMoneyTextLabel.maxY + KHeight(17) - 1, kSCREENW - self.lastMoneyTextLabel.x, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.93 green:0.91 blue:0.89 alpha:1.00];
    [self.payView addSubview:line];
    
    self.pointIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, line.maxY, KWidth(70/2), KHeight(296/2))];
    self.pointIV.image = [UIImage imageNamed:@"pointLine"];
    [self.payView addSubview:self.pointIV];
    
    self.balanceTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.pointIV.maxX + KWidth(6), line.maxY + KHeight(37/2), KWidth(150/2), KHeight(13))];
    self.balanceTextLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.balanceTextLabel.textColor = TEXTBLACK;
    self.balanceTextLabel.text = @"账户余额：";
    [self.payView addSubview:self.balanceTextLabel];
    
    self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.balanceTextLabel.maxX, self.balanceTextLabel.y, kSCREENW - self.balanceTextLabel.maxX - KWidth(60) - KWidth(40), KHeight(13))];
    self.balanceLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.balanceLabel.textColor = ORANGECOLOR;
    self.balanceLabel.adjustsFontSizeToFitWidth = YES;
    self.balanceLabel.text = [NSString stringWithFormat:@"¥%@元",self.myBalance];
    [self.payView addSubview:self.balanceLabel];
    
    self.topUpButton = [[UIButton alloc] initWithFrame:CGRectMake(self.balanceLabel.maxX + KWidth(20), line.maxY + KHeight(10), KWidth(60), KHeight(30))];
    [self.topUpButton setBackgroundColor:[UIColor colorWithRed:0.12 green:0.47 blue:0.98 alpha:1.00]];
    [self.topUpButton setTitle:@"充值" forState:UIControlStateNormal];
    [self.topUpButton addTarget:self action:@selector(topUpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.topUpButton.titleLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    self.topUpButton.layer.cornerRadius = 2.0f;
    self.topUpButton.layer.masksToBounds = YES;
    [self.payView addSubview:self.topUpButton];
    
    UIView  *line1 = [[UIView alloc] initWithFrame:CGRectMake(self.balanceTextLabel.x, self.topUpButton.maxY + KWidth(10) - 1, kSCREENW - self.balanceTextLabel.x, 1)];
    line1.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    [self.payView addSubview:line1];
    
    self.amountTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.balanceTextLabel.x, line1.maxY + KHeight(18), self.balanceTextLabel.width, self.balanceTextLabel.height)];
    self.amountTextLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.amountTextLabel.textColor = TEXTBLACK;
    self.amountTextLabel.text = @"投资金额：";
    [self.payView addSubview:self.amountTextLabel];
    
    self.amountTF = [[UITextField alloc] initWithFrame:CGRectMake(self.amountTextLabel.maxX, self.amountTextLabel.y, kSCREENW - self.amountTextLabel.maxX - KWidth(20), KHeight(14))];
//    self.amountTF.center = CGPointMake(self.amountLabel.center.x, self.minusButton.center.y);
    self.amountTF.textColor = TEXTGARY;
    self.amountTF.font = [UIFont systemFontOfSize:KWidth(14)];
//    self.amountTF.textAlignment = NSTextAlignmentCenter;
    self.amountTF.placeholder = @"已售罄";
    self.amountTF.enabled = NO;
    [self.payView addSubview:self.amountTF];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.amountTextLabel.x, self.amountTextLabel.maxY + KHeight(15) - 1, line1.width, 1)];
    line2.backgroundColor = line1.backgroundColor;
    [self.payView addSubview:line2];
    
    self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.amountTextLabel.x, line2.maxY + KHeight(20), kSCREENW - self.amountTextLabel.x - KWidth(28) - KWidth(40), KHeight(12))];
    self.discountLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.discountLabel.textColor = TEXTGARY;
    self.discountLabel.text = @"散标不允许使用优惠券";
    [self.payView addSubview:self.discountLabel];
    
//    self.nextIV = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENW - KWidth(34), line2.maxY + ((KHeight(50) - KWidth(14)) / 2), KWidth(14), KWidth(14))];
//    self.nextIV.image = [UIImage imageNamed:@"next"];
//    [self.payView addSubview:self.nextIV];
//    
//    UITapGestureRecognizer *discountTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discountLabelTapped:)];
//    [self.discountLabel addGestureRecognizer:discountTap];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(self.discountLabel.x, self.discountLabel.maxY + KHeight(17) - 1, kSCREENW - self.discountLabel.x, 1)];
    line3.backgroundColor = line2.backgroundColor;
    [self.payView addSubview:line3];
    
    self.preBenifitIV = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(12), line3.maxY + KWidth(12), KWidth(22), KWidth(22))];
    self.preBenifitIV.image = [UIImage imageNamed:@"money"];
    [self.payView addSubview:self.preBenifitIV];
    
    self.preBenifitTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.preBenifitIV.maxX + KWidth(7), line3.maxY + KHeight(16), self.amountTextLabel.width, self.amountTextLabel.height)];
    self.preBenifitTextLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.preBenifitTextLabel.textColor = TEXTGARY;
    self.preBenifitTextLabel.text = @"预计收益：";
    [self.payView addSubview:self.preBenifitTextLabel];
    
    self.preBenifitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.preBenifitTextLabel.maxX, self.preBenifitTextLabel.y - 1, kSCREENW - self.preBenifitTextLabel.maxY - KWidth(20), KHeight(15))];
    self.preBenifitLabel.text = @"¥0.00";
    self.preBenifitLabel.textColor = TEXTGARY;
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

#pragma mark - button方法

- (void)topUpButtonClicked:(UIButton *)button
{
    DSYAccountRechargeController *rechargeVC = [[DSYAccountRechargeController alloc] init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

- (void)doneBtnClicked:(UIButton *)button
{
    
}

- (void)planDetailBtnClicked:(UIButton *)button
{
    XYSanBidPlanDetailController *planDetailVC = [[XYSanBidPlanDetailController alloc] init];
    planDetailVC.planId = self.model.bidId;
    [self.navigationController pushViewController:planDetailVC animated:YES];
    
}

- (void)recordBtnClicked:(UIButton *)button
{
    XYJoinRecordController *planDetailVC = [[XYJoinRecordController alloc] init];
    planDetailVC.type = @"散标";
    planDetailVC.planId = self.model.bidId;
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
