//
//  XYTranportConfirmController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/11.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYTranportConfirmController.h"
#import "XYSuccessController.h"
#import "DSYTranferViewController.h"

@interface XYTranportConfirmController ()

@property (nonatomic, strong) UIView    *infoView;
@property (nonatomic, strong) UILabel   *mainTitleLabel;

@property (nonatomic, strong) UILabel   *rateLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UILabel   *amountLabel;
@property (nonatomic, strong) UILabel   *totalMoneyLabel;
@property (nonatomic, strong) UILabel   *payMoneyLabel;

@property (nonatomic, strong) UIButton  *confirmBtn;

@end

@implementation XYTranportConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleNavigationBarLabel.text = @"确认投资";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    [self createUI];
}

- (void)createUI
{
    self.infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + KHeight(10), kSCREENW, KHeight(400/2))];
    self.infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.infoView];
    
    CGFloat labelW = kSCREENW - KWidth(20) * 2;
    CGFloat hMargin = KWidth(20);
    CGFloat vMargin = KHeight(20);
    CGFloat labelH = KHeight(13);
    UIFont  *textfont = [UIFont systemFontOfSize:KHeight(13)];
    
    self.mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(20), kSCREENW, KHeight(15))];
    self.mainTitleLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    self.mainTitleLabel.text = self.model.title;
    [self.infoView addSubview:self.mainTitleLabel];
    
    self.totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.mainTitleLabel.maxY + vMargin, labelW, labelH)];
    self.totalMoneyLabel.font = textfont;
    self.totalMoneyLabel.textColor = TEXTBLACK;
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"转让价：%@",self.model.transferPrice];
    [self.infoView addSubview:self.totalMoneyLabel];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.totalMoneyLabel.maxY + vMargin, labelW, labelH)];
    self.rateLabel.textColor = TEXTBLACK;
    self.rateLabel.font = textfont;

    self.rateLabel.text = [NSString stringWithFormat:@"原始利率：%.2f%%",[self.model.oldApr floatValue]];

    [self.infoView addSubview:self.rateLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.rateLabel.maxY + vMargin, labelW, labelH)];
    self.timeLabel.textColor = TEXTBLACK;
    self.timeLabel.font = textfont;
    self.timeLabel.text = [NSString stringWithFormat:@"剩余期限：%@天",self.model.leftPeriods];
    [self.infoView addSubview:self.timeLabel];
    
    self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.timeLabel.maxY + vMargin, labelW, labelH)];
    self.amountLabel.font = textfont;
    self.amountLabel.textColor = TEXTBLACK;

    self.amountLabel.text = [NSString stringWithFormat:@"剩余本金：%.2f",self.model.debtAmount];

    [self.infoView addSubview:self.amountLabel];
    
    
    self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(300)) / 2, self.infoView.maxY + KHeight(25), KWidth(300), KHeight(44))];
    [self.confirmBtn setTitle:@"确认投资" forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:ORANGECOLOR];
    [self.confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
    
}

- (void)confirmBtnClicked:(UIButton *)button
{
//    XYSuccessController *suceessVC = [[XYSuccessController alloc] init];
//    [self.navigationController pushViewController:suceessVC animated:YES];
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"transferId":self.model.transportId};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN,@"transferId":self.model.transportId, @"sign":sign};
    NSString *url = [NSString stringWithFormat:@"%@/trade/transfer", APIPREFIX];
    
    [LYDTool sendPutWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        NSInteger statusCode = [[backData valueForKey:@"code"] integerValue];
        if (statusCode == 200) {
            
            //            XYSuccessController *suceessVC = [[XYSuccessController alloc] init];
            DSYTranferViewController *tranferVC = [[DSYTranferViewController alloc] init];
            tranferVC.payUrl = backData[@"payUrl"];
            [self.navigationController pushViewController:tranferVC animated:YES];
            
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:backData[@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
        NSInteger errorData = operation.response.statusCode;
        NSLog(@"%zi",operation.response.statusCode);
        if (errorData == 401) {
            // 401错误处理
            [DSYUtils showResponseError_401_ForViewController:self];
        } else if (errorData == 404) {
            [DSYUtils showResponseError_404_ForViewController:self message:@"未发现相关信息" okHandler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } cancelHandler:^(UIAlertAction *action) {
            }];
        } else if (errorData == 201) {
            [MBProgressHUD showError:@"您已经转让，无法再次转让当前债权" toView:self.view];
        } else {
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
