//
//  XYTransportDetailController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYTransportDetailController.h"
#import "XYTranportConfirmController.h"
#import "XYTransportPlanDetailController.h"
#import "XYJoinRecordController.h"
#import "XYCommentController.h"
#import "XYQuestionController.h"

#import "XYTransportDetailCell.h"
#import "XYTransportDetailModel.h"

#import "XYJoinRecordModel.h"
#import "XYRecordCell.h"

#import "XYQACell.h"
#import "XYQAModel.h"

#import "XYCustomCommentCell.h"
#import "XYCustomCommentModel.h"
#import "DSYHelpWebViewController.h"
#import "ChangJianWenTiViewController.h"

@interface XYTransportDetailController () <XYErrorHudDelegate>

@property (nonatomic, strong) UIView        *mainHeadView;
@property (nonatomic, strong) UIView        *infoHeadView;
@property (nonatomic, strong) UILabel       *transMoneyTextLabel;
@property (nonatomic, strong) UILabel       *transMoneyLabel;
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
@property (nonatomic, strong) UIButton      *topUpButton;
@property (nonatomic, strong) UILabel       *amountTextLabel;
@property (nonatomic, strong) UILabel       *amountTF;

@property (nonatomic, strong) UIScrollView  *btnView;
@property (nonatomic, strong) UIButton      *planDetailBtn;
@property (nonatomic, strong) UIButton      *recordBtn;
@property (nonatomic, strong) UIButton      *questionBtn;
@property (nonatomic, strong) UIButton      *commentBtn;

@property (nonatomic, copy) NSString        *myBalance;

@property (nonatomic, strong) UIScrollView  *mainSV;
@property (nonatomic, strong) UIButton      *doneBtn;

@end

@implementation XYTransportDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = self.model.title;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myBalance = @"0";
    
    [self loadMyBalance];
    [self createUI];
    [self createPayUI];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self loadMyBalance];
    [self setupMyUI];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 更新数据
    [self loadMyBalance];
    [self setupMyUI];
}

- (void)setupMyUI {
    if ([self.model.status integerValue] == 3) {
        self.doneBtn.enabled = NO;
        self.doneBtn.backgroundColor = [UIColor colorWithRed:0.73 green:0.68 blue:0.65 alpha:1.00];
    }
    if ([self.model.status integerValue] == 2) {
        self.doneBtn.enabled = YES;
        self.doneBtn.backgroundColor = ORANGECOLOR;
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元", self.model.debtAmount];
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
        }  else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    
    self.infoHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(110))];
    self.infoHeadView.backgroundColor = [UIColor whiteColor];
    [self.mainHeadView addSubview:self.infoHeadView];
    
    CGFloat hMargin = (kSCREENW - KWidth(20) * 2 - (KWidth(134/2) * 4)) / 3;
    CGFloat labelW  = KWidth(134/2);
    
    self.transMoneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(40/2), KHeight(30), labelW, KHeight(11))];
    self.transMoneyTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.transMoneyTextLabel.textColor = TEXTGARY;
    self.transMoneyTextLabel.textAlignment = NSTextAlignmentCenter;
    self.transMoneyTextLabel.text = @"转让价";
    [self.infoHeadView addSubview:self.transMoneyTextLabel];
    
    self.transMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.transMoneyTextLabel.x, self.transMoneyTextLabel.maxY + KHeight(12), self.transMoneyTextLabel.width, KHeight(22))];
    self.transMoneyLabel.textColor = ORANGECOLOR;
    self.transMoneyLabel.font = [UIFont systemFontOfSize:KHeight(17)];
    self.transMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.transMoneyLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *transAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",self.model.transferPrice]];
    [transAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(17)] range:NSMakeRange(transAttr.length - 1, 1)];
    self.transMoneyLabel.attributedText = transAttr;
    [self.infoHeadView addSubview:self.transMoneyLabel];
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.transMoneyTextLabel.maxX + hMargin, KHeight(30), labelW, KHeight(11))];
    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.rateTextLabel.textColor = TEXTGARY;
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.text = @"原始利率";
    [self.infoHeadView addSubview:self.rateTextLabel];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateTextLabel.x, self.rateTextLabel.maxY + KHeight(12), self.rateTextLabel.width, KHeight(22))];
    self.rateLabel.textColor = [UIColor blackColor];
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(17)];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *rateAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",self.model.oldApr]];
    [rateAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(17)] range:NSMakeRange(rateAttr.length - 1, 1)];
    [rateAttr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(rateAttr.length - 1, 1)];
    self.rateLabel.attributedText = rateAttr;
    [self.infoHeadView addSubview:self.rateLabel];
    
    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateTextLabel.maxX + hMargin, self.rateTextLabel.y, labelW, KHeight(11))];
    self.timeTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.timeTextLabel.textColor = TEXTGARY;
    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.timeTextLabel.text = @"剩余期限";
    [self.infoHeadView addSubview:self.timeTextLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeTextLabel.x, self.timeTextLabel.maxY + KHeight(12), self.timeTextLabel.width, KHeight(22))];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(17)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.model.leftPeriods]];
    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(17)] range:NSMakeRange(timeAttr.length - 1, 1)];
    self.timeLabel.attributedText = timeAttr;
    [self.infoHeadView addSubview:self.timeLabel];
    
    self.moneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeTextLabel.maxX + hMargin - 10, self.timeTextLabel.y, labelW + 10, KHeight(11))];
    self.moneyTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.moneyTextLabel.textColor = TEXTGARY;
    self.moneyTextLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyTextLabel.text = @"待收本息";
    [self.infoHeadView addSubview:self.moneyTextLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyTextLabel.x, self.moneyTextLabel.maxY + KHeight(12), self.moneyTextLabel.width, KHeight(22))];
    self.moneyLabel.textColor = [UIColor blackColor];
    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(17)];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",self.model.receivingAmount]];
    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(17)] range:NSMakeRange(moneyAttr.length - 1, 1)];
    [moneyAttr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(moneyAttr.length - 1, 1)];
    self.moneyLabel.attributedText = moneyAttr;
    [self.infoHeadView addSubview:self.moneyLabel];
    
    self.mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.mainHeadView.maxY, kSCREENW, kSCREENH - 64 - KHeight(44) - self.mainHeadView.height)];
    self.mainSV.backgroundColor = [UIColor whiteColor];
    self.mainSV.contentSize = CGSizeMake(kSCREENW * 5, 0);
    self.mainSV.scrollEnabled = NO;
    [self.view addSubview:self.mainSV];
    
    self.doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSCREENH - KHeight(44), kSCREENW, KHeight(44))];
    if ([self.model.status integerValue] == 2) {
        
    } else {
        
    }
    
    [self.doneBtn setBackgroundColor:ORANGECOLOR];
    [self.doneBtn setTitle:@"立即投资" forState:UIControlStateNormal];
    [self.doneBtn addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
}

- (void)createPayUI
{
    
    self.payView = [[UIView alloc] initWithFrame:CGRectMake(0, self.infoHeadView.maxY + KHeight(10), kSCREENW, KHeight(197/2))];
    self.payView.backgroundColor = [UIColor whiteColor];
    [self.mainHeadView addSubview:self.payView];
    
    self.pointIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth(70/2), KHeight(197/2))];
    self.pointIV.image = [UIImage imageNamed:@"transportLinePic"];
    [self.payView addSubview:self.pointIV];
    
    self.balanceTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.pointIV.maxX + KWidth(6), KHeight(37/2), KWidth(150/2), KHeight(13))];
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
    
    self.topUpButton = [[UIButton alloc] initWithFrame:CGRectMake(self.balanceLabel.maxX + KWidth(20), KHeight(10), KWidth(60), KHeight(30))];
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
    self.amountTextLabel.text = @"转让价：";
    [self.payView addSubview:self.amountTextLabel];
    
    self.amountTF = [[UILabel alloc] initWithFrame:CGRectMake(self.amountTextLabel.maxX, self.amountTextLabel.y, kSCREENW - self.amountTextLabel.maxX - KWidth(20), KHeight(14))];
    //    self.amountTF.center = CGPointMake(self.amountLabel.center.x, self.minusButton.center.y);
    self.amountTF.textColor = ORANGECOLOR;
    self.amountTF.font = [UIFont systemFontOfSize:KWidth(14)];
    self.amountTF.text = [NSString stringWithFormat:@"¥ %@",self.model.transferPrice];
    [self.payView addSubview:self.amountTF];

    
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
    rechargeVC.comeFrom = 1;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

- (void)doneBtnClicked:(UIButton *)button
{
    if ([self.myBalance integerValue] < [self.model.transferPrice integerValue]) {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"余额不足" andDoneBtnTitle:@"去充值" andDoneBtnHidden:NO];
        errorHud.delegate = self;
        [self.view.window addSubview:errorHud];
    } else {
        XYTranportConfirmController *confirmVC = [[XYTranportConfirmController alloc] init];
        confirmVC.model = self.model;
        [self.navigationController pushViewController:confirmVC animated:YES];
    }
    
    
}


- (void)planDetailBtnClicked:(UIButton *)button
{
    XYTransportPlanDetailController *planDetailVC = [[XYTransportPlanDetailController alloc] init];
    planDetailVC.planId = self.model.transportId;
    planDetailVC.model = self.model;
    [self.navigationController pushViewController:planDetailVC animated:YES];
    
}

- (void)recordBtnClicked:(UIButton *)button
{
    if ([self.model.status integerValue] == 2) {
        [MBProgressHUD showError:@"此债权无购买记录" toView:self.view];
        return;
    }
    
    XYJoinRecordController *planDetailVC = [[XYJoinRecordController alloc] init];
    planDetailVC.planId = self.model.transportId;
    planDetailVC.type = @"债权转让";
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
    planDetailVC.planId = self.model.transportId;
    planDetailVC.productType = 3;
    [self.navigationController pushViewController:planDetailVC animated:YES];
}

- (void)errorHud:(XYErrorHud *)hud doneBtnClicked:(UIButton *)button
{
    [hud removeFromSuperview];
    
    DSYAccountRechargeController *rechargeVC = [[DSYAccountRechargeController alloc] init];
    rechargeVC.comeFrom = 1;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
