//
//  NewBidDetailController.m
//  LYDApp
//
//  Created by fcl on 17/3/3.
//  Copyright © 2017年 dookay_73. All rights reserved.
//新手专享标详情

#import "NewBidDetailController.h"
#import "XYPlanConfirmController.h"
#import "XYPlanPlanDetailController.h"
#import "XYJoinRecordController.h"
#import "XYCommentController.h"
#import "XYQuestionController.h"
#import "DSYAccountCouponController.h"

#import "XYPlanDetailCell.h"
#import "XYPlanDetailModel.h"

#import "XYJoinRecordModel.h"
#import "XYRecordCell.h"

#import "XYQACell.h"
#import "XYQAModel.h"

#import "XYCustomCommentCell.h"
#import "XYCustomCommentModel.h"

#import "DSYCouponModel.h"
#import "DSYCouponSelectViewCell.h"
#import "LDBDetailViewController.h"
#import "DSYHelpWebViewController.h"
#import "ChangJianWenTiViewController.h"
@interface NewBidDetailController () <XYErrorHudDelegate, UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>



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
@property (nonatomic, strong) UIButton      *topUpButton;
@property (nonatomic, strong) UILabel       *amountTextLabel;
@property (nonatomic, strong) UILabel       *amountLabel;
@property (nonatomic, strong) UIButton      *minusButton;
@property (nonatomic, strong) UIButton      *plusButton;
@property (nonatomic, strong) UIButton       *discountLabel;
@property (nonatomic, strong) UIImageView   *nextIV;
@property (nonatomic, strong) UIImageView   *preBenifitIV;
@property (nonatomic, strong) UILabel       *preBenifitTextLabel;
@property (nonatomic, strong) UILabel       *preBenifitLabel;

@property (nonatomic, strong) UIScrollView  *btnView;
@property (nonatomic, strong) UIButton      *planDetailBtn;
@property (nonatomic, strong) UIButton      *recordBtn;
@property (nonatomic, strong) UIButton      *questionBtn;
@property (nonatomic, strong) UIButton      *commentBtn;


@property (nonatomic, copy) NSString        *amount;

@property (nonatomic, strong) UIScrollView  *mainSV;
@property (nonatomic, strong) UIButton      *doneBtn;

@property (nonatomic, strong) NSString      *myBalance;

@property (nonatomic, strong) UITableView   *couponTableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UIView         *thirdLineView;     /**< 第三条线 */
@property (nonatomic, strong) UITextField   *investCountField;   /**< 份数输入框 */
@property (nonatomic, strong) UILabel       *countBgLabel;             /**< 背景 */
@property (nonatomic, strong) UILabel       *investLabel;

@property (nonatomic, strong) NSIndexPath   *currentIndex;
@property (nonatomic, assign) CGFloat        plusRate;            /**< 加息券的利率 */
@property (nonatomic, strong) DSYCouponModel *coupon;





@end

@implementation NewBidDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleNavigationBarLabel.text = self.model.title;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // [self loadPlanData];
    
    
    
    self.amount = @"1";
    self.myBalance = @"0";
    
    [self createUI];
    [self createPayUI];
    
    [self couponTableView];
    [self.view bringSubviewToFront:self.couponTableView];
    //    self.btnView.backgroundColor = [UIColor purpleColor];
    
    [self investCountField];
    
    self.amountLabel.hidden = YES;
    self.minusButton.hidden = YES;
    self.plusButton.hidden = YES;
    
    [self loadMyBalance];
    [self loadMyCoupon];
    [self setupMyUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showMessage:nil toView:self.view];
    // 更新数
    //    [self loadMyBalance];
    [self setupMyUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 更新数据
    [self loadMyBalance];
    [self loadMyCoupon];
    self.currentIndex = nil;
    self.coupon = nil;
    
    NSString *showStr = [NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count];
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:showStr attributes:nil];
    [self.discountLabel setAttributedTitle:attr forState:(UIControlStateNormal)];
    [self.couponTableView reloadData];
    [self setupMyUI];
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        
        _dataList = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataList;
}

#pragma mark 设置UI的显示内容
- (void)setupMyUI {
    CGFloat apr = 0;
    // 总投资金额
    CGFloat allInvestAmount =  [self.amount integerValue] * [self.model.perAmount floatValue] * 1.0;
    // 投资金额的显示
    self.investLabel.text = [NSString stringWithFormat:@"￥%.2f", allInvestAmount];
    
    if (self.coupon.type == 3) {  // 如果是加息券的时候
        apr = self.coupon.amount;
    } else { // 不是加息券的时候
        apr = 0;
    }
    
//    // 期数
//    NSInteger periods = [self.model.periods integerValue];
//    CGFloat actual = [self.model.apr floatValue] + apr;
//    CGFloat rate = actual / 100  / 12;
//    // 如果是日
//    if ([self.model.periodUnit integerValue] == 1) {
//        // 日
//        rate = actual / 365 / 100;
//    } else if ([self.model.periodUnit integerValue] == -1) {
//        // 年
//        rate = actual / 100;
//    } else if ([self.model.periodUnit integerValue] == 2) {
//        // 周
//        rate = actual * 7 / 365 / 100;
//    }
//    
//    self.preBenifitLabel.text = [NSString stringWithFormat:@"￥%.2f", allInvestAmount *  periods * rate];
    
    
    //金额*以前的利率+金额*贴息券的利率
    // 期数
    NSInteger periods = [self.model.periods integerValue];
    CGFloat actual = [self.model.apr floatValue];
    CGFloat rate = actual / 100  / 12;
    // 如果是日
    if ([self.model.periodUnit integerValue] == 1) {
        // 日
        rate = actual / 365 / 100;
    } else if ([self.model.periodUnit integerValue] == -1) {
        // 年
        rate = actual / 100;
    } else if ([self.model.periodUnit integerValue] == 2) {
        // 周
        rate = actual * 7 / 365 / 100;
    }
    
    
    //加息收益
    CGFloat actualAdd =apr;
    CGFloat rateAdd = actualAdd / 100  / 12;
    // 如果是日
    if ([self.model.periodUnit integerValue] == 1) {
        // 日
        rateAdd = actualAdd / 365 / 100;
    } else if ([self.model.periodUnit integerValue] == -1) {
        // 年
        rateAdd = actualAdd / 100;
    } else if ([self.model.periodUnit integerValue] == 2) {
        // 周
        rateAdd = actualAdd * 7 / 365 / 100;
    }
    
    
    
    
    
    
    
    //金额*以前的利率+金额*贴息券的利率
    self.preBenifitLabel.text = [NSString stringWithFormat:@"￥%.2f", allInvestAmount *  periods * rate+allInvestAmount *  periods * rateAdd];
    
    
}










#pragma mark  加载理财详情数据--------------
- (void)loadPlanData
{
    
    
    //planId   bidType
    
    
    NSString *timestamp = [LYDTool createTimeStamp];
    
    
    
    //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
    NSDictionary *secretDict = @{@"bidType":@"0",@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"bidType":@"0",@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    // 开始请求数据
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,self.model.planId] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        id backData = LYDJSONSerialization(data);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            //            self.myBalance = [NSString stringWithFormat:@"%@",[backData valueForKey:@"balance"]];
            //            if (self.balanceLabel) {
            //                self.balanceLabel.text = [NSString stringWithFormat:@"¥%.2f", [self.myBalance floatValue]];
            //            }
            
            
            //            for (NSDictionary *dict in [backData valueForKey:@"planModel"]) {
            //                XYPlanModel *model = [[XYPlanModel alloc] init];
            //                [model setValuesForKeysWithDictionary:dict];
            //                [self.plansArr addObject:model];
            //            }
            self.modelDetail=[XYPlanModel baseModelWithDic:backData[@"planModel"]];
            
            
            
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






#pragma mark 获取当前用户的余额
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        id backData = LYDJSONSerialization(data);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            self.myBalance = [NSString stringWithFormat:@"%@",[backData valueForKey:@"balance"]];
            if (self.balanceLabel) {
                self.balanceLabel.text = [NSString stringWithFormat:@"¥%.2f", [self.myBalance floatValue]];
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







////@ApiParam(value = "标的类型") @RequestParam() final Integer bidType,
////@ApiParam(value = "借款期限类型-1: 年;0:月;1:日;2:周;(默认日)") @RequestParam() final Integer periodUnit,
////@ApiParam(value = "借款周期") @RequestParam() final Integer periods
//#pragma mark 获取当前用户当前标的适用的优惠券
//- (void)loadMyCoupon {
//    NSString *url = [NSString stringWithFormat:@"%@/user/coupons/plan", APIPREFIX];
//    NSString *timestamp = [LYDTool createTimeStamp];
//
//
//    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"planId":self.model.planId};
//    // 生成签名认证
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"planId":self.model.planId, @"sign":sign};
//
//    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
//        id backData = LYDJSONSerialization(data);
//        NSInteger statusCode = [backData[@"code"] integerValue];
//        if (statusCode == 200) {
//            self.dataList = [DSYCouponModel baseModelByArr:backData[@"couponModelList"]];
//            [self.discountLabel setTitle:[NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count] forState:(UIControlStateNormal)];
//            [self.couponTableView reloadData];
//        } else if (statusCode == 600) {
//            [DSYUtils showSuccessForStatus_600_ForViewController:self];
//        } else {
//            [MBProgressHUD showError:backData[@"message"] toView:self.view];
//        }
//    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//        [self errorDealWithOperation:operation];
//    }];
//}





//@ApiParam(value = "标的类型") @RequestParam() final Integer bidType,
//@ApiParam(value = "借款期限类型-1: 年;0:月;1:日;2:周;(默认日)") @RequestParam() final Integer periodUnit,
//@ApiParam(value = "借款周期") @RequestParam() final Integer periods
#pragma mark 获取当前用户当前标的适用的优惠券
- (void)loadMyCoupon {
    NSString *url = [NSString stringWithFormat:@"%@/user/coupons/plan", APIPREFIX];
    NSString *timestamp = [LYDTool createTimeStamp];
    
    
    NSDictionary *secretDict = @{@"bidType":self.model.bidType,@"periodUnit":self.model.periodUnit,@"periods":self.model.periods,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"bidType":self.model.bidType,@"periodUnit":self.model.periodUnit,@"periods":self.model.periods,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            self.dataList = [DSYCouponModel baseModelByArr:backData[@"couponModelList"]];
            //[self.discountLabel setTitle:[NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count] forState:(UIControlStateNormal)];
            NSString *showStr = [NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count];
            NSAttributedString *attr = [[NSAttributedString alloc] initWithString:showStr attributes:nil];
            [self.discountLabel setAttributedTitle:attr forState:(UIControlStateNormal)];
            [self.couponTableView reloadData];
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorDealWithOperation:operation];
    }];
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
        [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户优惠券" okHandler:^(UIAlertAction *action) {
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
    
    CGFloat hMargin = (kSCREENW - (KWidth(58/2) * 2) - (KWidth(136/2) * 3)) / 2;
    CGFloat labelW  = KWidth(136/2);
    
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
    
    // 预期年化利率的显示
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
    if ([_model.periodUnit integerValue] == 0) {
        period = [NSMutableString stringWithFormat:@"%@个月",_model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(timeAttr.length - 2, 2)];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(timeAttr.length - 2, 2)];
        self.timeLabel.attributedText = timeAttr;
    } else if ([self.model.periodUnit integerValue] == 1) {
        period = [NSMutableString stringWithFormat:@"%@天",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(timeAttr.length - 1, 1)];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(timeAttr.length - 1, 1)];
        self.timeLabel.attributedText = timeAttr;
    } else if ([self.model.periodUnit integerValue] == -1) {
        period = [NSMutableString stringWithFormat:@"%@年",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(timeAttr.length - 1, 1)];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(timeAttr.length - 1, 1)];
        self.timeLabel.attributedText = timeAttr;
    } else if ([self.model.periodUnit integerValue] == 2) {
        period = [NSMutableString stringWithFormat:@"%@周",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(timeAttr.length - 1, 1)];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(timeAttr.length - 1, 1)];
        self.timeLabel.attributedText = timeAttr;
    }
    
//    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
//    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(timeAttr.length - 1, 1)];
//    [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(timeAttr.length - 1, 1)];
//    self.timeLabel.attributedText = timeAttr;
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
    
    
    
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",self.model.perAmount]];
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
    if ([self.model.hadInvestAct boolValue]) {
        self.doneBtn.userInteractionEnabled=YES;
        [self.doneBtn setBackgroundColor:ORANGECOLOR];
    }
    else
    {
        self.doneBtn.userInteractionEnabled=NO;
        self.doneBtn.backgroundColor=[UIColor grayColor];
    
    }
    [self.view addSubview:self.doneBtn];
}

- (void)createPayUI
{
    self.payView = [[UIView alloc] initWithFrame:CGRectMake(0, self.infoHeadView.maxY + KHeight(10), kSCREENW, KHeight(393/2))];
    self.payView.backgroundColor = [UIColor whiteColor];
    [self.mainHeadView addSubview:self.payView];
    
    self.pointIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth(70/2), KHeight(296/2))];
    self.pointIV.image = [UIImage imageNamed:@"pointLine"];
    [self.payView addSubview:self.pointIV];
    
    self.balanceTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.pointIV.maxX + KWidth(6), KHeight(37/2), KWidth(135/2), KHeight(13))];
    self.balanceTextLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.balanceTextLabel.textColor = TEXTBLACK;
    self.balanceTextLabel.text = @"账户余额:";
    //    [self.balanceTextLabel fixSingleWidth];
    //    self.balanceTextLabel.adjustsFontSizeToFitWidth = YES;
    [self.payView addSubview:self.balanceTextLabel];
    
    self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.balanceTextLabel.maxX, self.balanceTextLabel.y, kSCREENW - self.balanceTextLabel.maxX - KWidth(60) - KWidth(40), KHeight(13))];
    self.balanceLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.balanceLabel.textColor = ORANGECOLOR;
    self.balanceLabel.adjustsFontSizeToFitWidth = YES;
    self.balanceLabel.text = [NSString stringWithFormat:@"¥%@",self.myBalance];
    
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
    self.amountTextLabel.text = @"投资份数:";
    [self.payView addSubview:self.amountTextLabel];
    
    self.minusButton = [[UIButton alloc] initWithFrame:CGRectMake(self.balanceLabel.x, line1.maxY + KHeight(14), KWidth(20), KWidth(20))];
    [self.minusButton setBackgroundImage:[UIImage imageNamed:@"minusBtn"] forState:UIControlStateNormal];
    [self.minusButton addTarget:self action:@selector(minusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.payView addSubview:self.minusButton];
    
    self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.minusButton.maxX, self.minusButton.y - 3, KWidth(50), KHeight(14))];
    self.amountLabel.center = CGPointMake(self.amountLabel.center.x, self.minusButton.center.y);
    self.amountLabel.textColor = TEXTBLACK;
    self.amountLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.amountLabel.textAlignment = NSTextAlignmentCenter;
    self.amountLabel.text = [NSString stringWithFormat:@"%@份",self.amount];
    [self.payView addSubview:self.amountLabel];
    
    
    
    self.plusButton = [[UIButton alloc] initWithFrame:CGRectMake(self.amountLabel.maxX, self.minusButton.y, KWidth(20), KWidth(20))];
    [self.plusButton setBackgroundImage:[UIImage imageNamed:@"plusBtn"] forState:UIControlStateNormal];
    [self.plusButton addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.payView addSubview:self.plusButton];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.amountTextLabel.x, self.plusButton.maxY + KHeight(15) - 1, line1.width, 1)];
    line2.backgroundColor = line1.backgroundColor;
    [self.payView addSubview:line2];
    
    self.discountLabel = [[UIButton alloc] initWithFrame:CGRectMake(self.amountTextLabel.x, line2.maxY + KHeight(20), kSCREENW - self.amountTextLabel.x - KWidth(28) - KWidth(40), KHeight(20))];
    self.discountLabel.titleLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    [self.discountLabel setTitleColor:TEXTGARY forState:UIControlStateNormal];
    [self.discountLabel setTitle:[NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count] forState:UIControlStateNormal];
    [self.discountLabel addTarget:self action:@selector(discountLabelTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.discountLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.payView addSubview:self.discountLabel];
    
    //    self.payView.backgroundColor = [UIColor blueColor];
    
    self.nextIV = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENW - KWidth(34), line2.maxY + ((KHeight(50) - KHeight(8)) / 2), KWidth(14), KHeight(8))];
    self.nextIV.image = [UIImage imageNamed:@"arrow_down"];
    [self.payView addSubview:self.nextIV];
    self.nextIV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discountLabelTapped:)];
    [self.nextIV addGestureRecognizer:tap];
    self.nextIV.transform = CGAffineTransformRotate(self.nextIV.transform, -M_PI_2);
    
    UITapGestureRecognizer *discountTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discountLabelTapped:)];
    [self.discountLabel addGestureRecognizer:discountTap];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(self.discountLabel.x, self.discountLabel.maxY + KHeight(9) - 1, kSCREENW - self.discountLabel.x, 1)];
    line3.backgroundColor = line2.backgroundColor;
    [self.payView addSubview:line3];
    self.thirdLineView = line3;
    
    self.preBenifitIV = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(12), line3.maxY + KWidth(12), KWidth(22), KWidth(22))];
    self.preBenifitIV.image = [UIImage imageNamed:@"money"];
    [self.payView addSubview:self.preBenifitIV];
    
    self.preBenifitTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.preBenifitIV.maxX + KWidth(7), line3.maxY + KHeight(16), self.amountTextLabel.width, self.amountTextLabel.height)];
    self.preBenifitTextLabel.font = [UIFont systemFontOfSize:KWidth(14)];
    self.preBenifitTextLabel.textColor = TEXTBLACK;
    self.preBenifitTextLabel.text = @"预计收益:";
    [self.payView addSubview:self.preBenifitTextLabel];
    
    UILabel *investShow = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(14.0f)];
    [self.payView addSubview:investShow];
    investShow.textAlignment = NSTextAlignmentLeft;
    investShow.text = @"投资金额:";
    [investShow fixSingleWidth];
    [investShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payView.mas_centerX).with.offset(W(15));
        make.centerY.equalTo(self.preBenifitTextLabel.mas_centerY);
        make.height.equalTo(self.preBenifitTextLabel);
        make.width.mas_equalTo(investShow.width);
    }];
    
    self.investLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:ORANGECOLOR fontOfSystemSize:W(14.0f)];
    [self.payView addSubview:self.investLabel];
    [self.investLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(investShow.mas_right).with.offset(0);
        make.centerY.equalTo(investShow.mas_centerY);
        make.height.equalTo(investShow);
        make.right.equalTo(self.payView).with.offset(X(-12));
    }];
    self.investLabel.textAlignment = NSTextAlignmentLeft;
    
    
    self.preBenifitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.preBenifitTextLabel.maxX, self.preBenifitTextLabel.y - 1, kSCREENW - self.preBenifitTextLabel.maxY - KWidth(20), KHeight(15))];
    self.preBenifitLabel.text = @"¥0.00";
    self.preBenifitLabel.textColor = [UIColor colorWithRed:0.89 green:0.00 blue:0.07 alpha:1.00];
    self.preBenifitLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    [self.payView addSubview:self.preBenifitLabel];
    
    [self createButtonView];
    
}

- (void)createButtonView
{
    self.btnView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.payView.maxY + KHeight(10), kSCREENW, KHeight(440/2))];
    self.btnView.showsHorizontalScrollIndicator = NO;
    //self.btnView.backgroundColor=[UIColor redColor];
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


#pragma mark contentTableView的创建---------
- (UITableView *)couponTableView {
    if (!_couponTableView) {
        //  计算最大高度
        
        CGFloat tableViewY = self.thirdLineView.maxY + 64 + self.payView.y;
        CGFloat tableViewH = self.doneBtn.y - self.payView.y - self.thirdLineView.maxY - 64;
        
        _couponTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, self.view.width, 0) style:(UITableViewStylePlain)];
        [self.view addSubview:_couponTableView];
        [_couponTableView insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentTop)];
        
        _couponTableView.backgroundColor = [UIColor redColor];
        _couponTableView.rowHeight = H(92);
        _couponTableView.delegate = self;
        _couponTableView.dataSource = self;
        _couponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _couponTableView.backgroundColor = RGB(249, 249, 249);
        
    }
    return _couponTableView;
}

#pragma mark
- (UILabel *)countBgLabel {
    if (!_countBgLabel) {
        _countBgLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(self.amountTextLabel.maxX, self.amountTextLabel.y, W(105), H(40)) andTextColor:[UIColor whiteColor] fontOfSystemSize:W(14.0f)];
        _countBgLabel.text = @"1份";
        _countBgLabel.textColor = [UIColor clearColor];
        [self.payView addSubview:_countBgLabel];
        [self.countBgLabel fixSingleWidth];
        CGFloat countBGLabelW = self.countBgLabel.width + W(90);
        NSLog(@"%f", countBGLabelW);
        if (countBGLabelW >= W(220)) {
            self.countBgLabel.width = W(220);
        } else if (countBGLabelW > W(105)) {
            self.countBgLabel.width = countBGLabelW;
        } else {
            self.countBgLabel.width = W(105);
        }
        _countBgLabel.userInteractionEnabled = YES;
        _countBgLabel.centerY = self.amountTextLabel.centerY;
    }
    return _countBgLabel;
}

#pragma mark
- (UITextField *)investCountField {
    if (!_investCountField) {
        
        UIButton *subBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.countBgLabel addSubview:subBtn];
        [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.countBgLabel);
            make.width.mas_equalTo(W(20));
        }];
        [subBtn addTarget:self action:@selector(minusButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIButton *plusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.countBgLabel addSubview:plusBtn];
        [plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.countBgLabel);
            make.right.equalTo(self.countBgLabel.mas_right).with.offset(X(-5));
            make.width.mas_equalTo(W(20));
        }];
        [subBtn setImage:DSYImage(@"minusBtn") forState:(UIControlStateNormal)];
        [plusBtn setImage:DSYImage(@"plusBtn") forState:(UIControlStateNormal)];
        [plusBtn addTarget:self action:@selector(plusButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(14.0f)];
        [self.countBgLabel addSubview:showLabel];
        showLabel.text = @"份";
        showLabel.textAlignment = NSTextAlignmentLeft;
        [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.countBgLabel);
            make.right.equalTo(plusBtn.mas_left).with.offset(0);
            make.width.mas_equalTo(W(35));
        }];
        showLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLabelTapAction:)];
        [showLabel addGestureRecognizer:tap];
        
        _investCountField = [[UITextField alloc] init];
        [self.countBgLabel addSubview:_investCountField];
        [_investCountField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(subBtn.mas_right).with.offset(X(12));
            make.top.bottom.equalTo(self.countBgLabel);
            make.right.equalTo(showLabel.mas_left).with.offset(0);
        }];
        _investCountField.keyboardType = UIKeyboardTypeNumberPad;
        _investCountField.textAlignment = NSTextAlignmentRight;
        _investCountField.text = @"1";
        _investCountField.textColor = RGB(102, 102, 102);
        _investCountField.font = [UIFont systemFontOfSize:W(14.0f)];
        [_investCountField addTarget:self action:@selector(investCountFieldValuechanged:) forControlEvents:(UIControlEventEditingChanged)];
        [_investCountField addTarget:self action:@selector(investCountFieldEndEdit:) forControlEvents:(UIControlEventEditingDidEnd)];
        
        
        //_investCountField.backgroundColor=[UIColor redColor];
        
    }
    return _investCountField;
}



#pragma mark - contentTableView的DataSource和Delegate
#pragma mark contentTableView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYCouponSelectViewCell *cell = [DSYCouponSelectViewCell cellForTableView:tableView];
    DSYCouponModel *model = self.dataList[indexPath.row];
    cell.model = model;
    cell.backgroundColor = self.couponTableView.backgroundColor;
    cell.contentView.backgroundColor = RGB(249, 249, 249);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.currentIndex && indexPath.row == self.currentIndex.row) {
        cell.bgView.layer.borderColor = ORANGECOLOR.CGColor;
        cell.bgView.layer.borderWidth = H(0.5);
        cell.bgView.backgroundColor = [UIColor colorWithRed:0.9 green:0.4 blue:0.0 alpha:1.00];
    } else {
        cell.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.bgView.layer.borderWidth = H(0.5);
        cell.bgView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

#pragma mark contentTableView的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYCouponSelectViewCell *cell = [self.couponTableView cellForRowAtIndexPath:indexPath];
    //    [self.discountLabel setTitle: forState:(UIControlStateNormal)];
    NSLog(@"%ld", indexPath.row);
    
    // 优惠券中加息券的利率
    if (self.currentIndex == indexPath) {
        self.currentIndex = nil;
        self.coupon = nil;
        NSString *showStr = [NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count];
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:showStr attributes:nil];
        [self.discountLabel setAttributedTitle:attr forState:(UIControlStateNormal)];
        [self.couponTableView reloadData];
        
        [self setupMyUI];
        return;
    }
    
    
    self.currentIndex = indexPath;
    DSYCouponModel *coupon = self.dataList[self.currentIndex.row];
    self.coupon = coupon;
    
//    if (self.coupon.minInvestAmount > [self.amount integerValue] * [self.model.perAmount integerValue]) {
////        // 如果没有达到优惠券的最小投资金额
////        [MBProgressHUD showError:[NSString stringWithFormat:@"当前优惠券只用于%.2f的投资", self.coupon.minInvestAmount] toView:self.view];
////        self.currentIndex = nil;
////        self.coupon = nil;
////        NSString *showStr = [NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count];
////        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:showStr attributes:nil];
////        [self.discountLabel setAttributedTitle:attr forState:(UIControlStateNormal)];
////        [self.couponTableView reloadData];
////        
////        [self setupMyUI];
////        return;
//        
//        //最小份数
//        NSInteger  maxFenShu=self.coupon.minInvestAmount/[self.model.perAmount integerValue];
//        
//        if (maxFenShu*[self.model.perAmount integerValue]<self.coupon.minInvestAmount) {
//            ++maxFenShu;
//        }
//        
//        
//        self.amountLabel.text= [NSString stringWithFormat:@"%ld份",(long)maxFenShu];
//        self.investCountField.text=[NSString stringWithFormat:@"%ld",(long)maxFenShu];;
//        [self investCountFieldValuechanged:self.investCountField];
//    }
    
    
    
    
    //选择优惠券的时候直接回填优惠券的最小可用金额
    //最小份数
    NSInteger  maxFenShu=self.coupon.minInvestAmount/[self.model.perAmount integerValue];
    
    if (maxFenShu*[self.model.perAmount integerValue]<self.coupon.minInvestAmount) {
        ++maxFenShu;
    }
    
    
    self.amountLabel.text= [NSString stringWithFormat:@"%ld份",(long)maxFenShu];
    self.investCountField.text=[NSString stringWithFormat:@"%ld",(long)maxFenShu];;
    [self investCountFieldValuechanged:self.investCountField];
    
    
    
    [self setupMyUI];
    
    [self.discountLabel setAttributedTitle:cell.amoutNameLabel.attributedText forState:(UIControlStateNormal)];
    [self.couponTableView reloadData];
    
    //    [self discountLabelTapped:nil];
}

#pragma mark textField的监听方法
- (void)investCountFieldValuechanged:(UITextField *)textField {
    self.amount = self.investCountField.text;
    CGFloat investMoney = [self.amount integerValue] * [self.model.perAmount floatValue];
    if (investMoney  >= 200000.0) {
        NSInteger maxCount =  (NSInteger)(200000 / ([self.model.perAmount floatValue]));
        
        self.amount = [NSString stringWithFormat:@"%zi", maxCount];
        self.investCountField.text = self.amount;
    }
    
    self.investLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.amount integerValue] * [self.model.perAmount floatValue] * 1.0];
    CGFloat investAmout = [[self.investLabel.text substringFromIndex:1] floatValue];
    NSInteger months = [self.model.periods integerValue];
    CGFloat rate = [self.model.apr floatValue] / 100;
    self.preBenifitLabel.text = [NSString stringWithFormat:@"￥%.2f", investAmout * months * rate / 12];
    //    self.countBgLabel.text = [NSString stringWithFormat:@"%@份", self.investCountField.text];
    // 动态显示
    self.countBgLabel.text = [self getCountBgLabelShow];
    [self.countBgLabel fixSingleWidth];
    CGFloat countBGLabelW = self.countBgLabel.width + W(90);
    NSLog(@"%f", countBGLabelW);
    if (countBGLabelW >= W(220)) {
        self.countBgLabel.width = W(220);
    } else if (countBGLabelW > W(105)) {
        self.countBgLabel.width = countBGLabelW;
    } else {
        self.countBgLabel.width = W(105);
    }
    
//    if (self.coupon.minInvestAmount > [self.amount integerValue] * [self.model.perAmount integerValue]) {
//        
//        // 如果没有达到优惠券的最小投资金额
//        [MBProgressHUD showError:[NSString stringWithFormat:@"当前优惠券只用于%.2f的投资", self.coupon.minInvestAmount] toView:self.view];
//        self.currentIndex = nil;
//        self.coupon = nil;
//        NSString *showStr = [NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count];
//        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:showStr attributes:nil];
//        [self.discountLabel setAttributedTitle:attr forState:(UIControlStateNormal)];
//        [self.couponTableView reloadData];
//        
//        [self setupMyUI];
//        [self discountLabelTapped:nil];
//    }
    
}

#pragma mark 动态显示countBgLabel的宽度
- (NSString *)getCountBgLabelShow {
    NSString *str = @"1份";
    
    for (NSInteger i = 1; i < self.investCountField.text.length; i++) {
        str = [NSString stringWithFormat:@"%@8", str];
    }
    
    return str;
}

#pragma mark 结束编辑
- (void)investCountFieldEndEdit:(UITextField *)textField {
    self.amount = self.investCountField.text;
    if ([self.amount integerValue] <= 1) {
        self.amount = @"1";
        self.investCountField.text = @"1";
        // 更新主要的视图的内容
        [self investCountFieldValuechanged:self.investCountField];
    }
}

#pragma mark 点击输入
- (void)showLabelTapAction:(UITapGestureRecognizer *)tap {
    [self.investCountField becomeFirstResponder];
}

#pragma mark - 所有的button的点击方法
#pragma mark 立即投资按钮的点击的方法
- (void)doneBtnClicked:(UIButton *)button
{
    
    if (self.coupon.minInvestAmount > [self.amount integerValue] * [self.model.perAmount integerValue])
    {
        
        UIAlertView    *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前优惠券只用于不少于%.2f的投资", self.coupon.minInvestAmount] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    CGFloat youhuiquan=0.00;
    if (self.currentIndex == nil) {//没有使用优惠券
        
        youhuiquan=0.00;
        
    } else {
        DSYCouponModel *coupon = self.dataList[self.currentIndex.row];
        youhuiquan=coupon.amount;
        
        
    }
    
    if ([self.amount  integerValue] >10) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"信息" message:@"最多投资10000元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
        return;
    }

    
    if ([DSYAccount sharedDSYAccount].ipsAccount.length <= 0) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"用户未开户，请进行开户" okHandler:^(UIAlertAction *action) {
            DSYOpenAccountController *oppenAccountVC = [[DSYOpenAccountController alloc] initWithType:DSYOpenAccountControllerFromTypeNone];
            oppenAccountVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:oppenAccountVC animated:YES];
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else if ([self.amount integerValue] * [self.model.perAmount integerValue] > [self.myBalance integerValue]+youhuiquan) {
        
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"余额不足" andDoneBtnTitle:@"去充值" andDoneBtnHidden:NO];
        errorHud.delegate = self;
        [self.view.window addSubview:errorHud];
        
    } else {
        
        XYPlanConfirmController *confirmVC = [[XYPlanConfirmController alloc] init];
        confirmVC.model = self.model;
        confirmVC.amount = self.amount;
        
        if (self.currentIndex == nil) {
            confirmVC.discount = @"没有使用优惠券";
            confirmVC.couponId = @"0";
        } else {
            DSYCouponModel *coupon = self.dataList[self.currentIndex.row];
            confirmVC.couponId = [NSString stringWithFormat:@"%ld", coupon.couponId];
            //            DSYCouponSelectViewCell *cell = [self.couponTableView cellForRowAtIndexPath:self.currentIndex];
            confirmVC.discount = self.discountLabel.titleLabel.attributedText.string;
            confirmVC.coupon = coupon;
        }
        //        confirmVC.discount = @"500";
        [self.navigationController pushViewController:confirmVC animated:YES];
        
    }
    [self discountLabelTapped:nil];
    
}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//
//    
//}



- (void)topUpButtonClicked:(UIButton *)button
{
    [self discountLabelTapped:nil];
    DSYAccountRechargeController *rechargeVC = [[DSYAccountRechargeController alloc] init];
    rechargeVC.comeFrom = 1;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

- (void)minusButtonClicked:(UIButton *)button
{
    
    //    [self discountLabelTapped:nil];
    if ([self.amount integerValue] > 1) {
        NSInteger newAmount = [self.investCountField.text integerValue] - 1;
        self.amount = [NSString stringWithFormat:@"%zi",newAmount];
        self.amountLabel.text = [NSString stringWithFormat:@"%@份",self.amount];
        self.investCountField.text = [NSString stringWithFormat:@"%@",self.amount];
        [self investCountFieldValuechanged:self.investCountField];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"最少投资1份" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:^{
            [self investCountFieldValuechanged:self.investCountField];
        }];
    }
}

- (void)plusButtonClicked:(UIButton *)button
{
    //    [self discountLabelTapped:nil];
    NSInteger newAmount = [self.amount integerValue] + 1;
    self.amount = [NSString stringWithFormat:@"%zi",newAmount];
    self.amountLabel.text = [NSString stringWithFormat:@"%@份",self.amount];
    
    self.investCountField.text = [NSString stringWithFormat:@"%@",self.amount];
    [self investCountFieldValuechanged:self.investCountField];
}



- (void)discountLabelTapped:(UIButton *)tap
{
    [self.view bringSubviewToFront:self.couponTableView];
    [self.couponTableView reloadData];
    if (tap == nil) {
        [UIView animateWithDuration:0.5 animations:^{
            self.couponTableView.height = 0;
            self.nextIV.transform = CGAffineTransformIdentity;
            self.nextIV.transform = CGAffineTransformRotate(self.nextIV.transform, -M_PI_2);
        } completion:^(BOOL finished) {
        }];
        return;
    }
    
    if (self.dataList.count <= 0) {
        [MBProgressHUD showError:@"您没有优惠券可选!" toView:self.view];
        [UIView animateWithDuration:0.5 animations:^{
            self.couponTableView.height = 0;
            self.nextIV.transform = CGAffineTransformIdentity;
            self.nextIV.transform = CGAffineTransformRotate(self.nextIV.transform, -M_PI_2);
        }];
        return;
    }
    
    
    NSLog(@"tapped");
    CGFloat maxHeight = self.doneBtn.y - self.payView.y - self.thirdLineView.maxY - 64;
    
    // 计算高度
    CGFloat height = self.dataList.count * H(92);
    if (height >= maxHeight) {
        height = maxHeight;
    }
    
    if (self.couponTableView.height > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.couponTableView.height = 0;
            self.nextIV.transform = CGAffineTransformIdentity;
            self.nextIV.transform = CGAffineTransformRotate(self.nextIV.transform, -M_PI_2);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.couponTableView.height = height;
            self.nextIV.transform = CGAffineTransformIdentity;
        }];
    }
}



- (void)planDetailBtnClicked:(UIButton *)button
{
    [self discountLabelTapped:nil];
    LDBDetailViewController *planDetailVC = [[LDBDetailViewController alloc] init];
    planDetailVC.model = self.model;
    [self.navigationController pushViewController:planDetailVC animated:YES];
    
}

- (void)recordBtnClicked:(UIButton *)button
{
    [self discountLabelTapped:nil];
    XYJoinRecordController *planDetailVC = [[XYJoinRecordController alloc] init];
    planDetailVC.planId = self.model.planId;
    planDetailVC.model=self.model;
    planDetailVC.type = @"理财计划";
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
    [self discountLabelTapped:nil];
    XYCommentController *planDetailVC = [[XYCommentController alloc] init];
    planDetailVC.planId = self.model.planId;
    planDetailVC.productType = [self.model.bidType  integerValue];
    [self.navigationController pushViewController:planDetailVC animated:YES];
}

- (void)errorHud:(XYErrorHud *)hud doneBtnClicked:(UIButton *)button
{
    [self discountLabelTapped:nil];
    [hud removeFromSuperview];
    
    DSYAccountRechargeController *rechargeVC = [[DSYAccountRechargeController alloc] init];
    rechargeVC.comeFrom = 1;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.investCountField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
