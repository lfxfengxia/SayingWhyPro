//
//  XinShouZhuanXiangGouMaiViewController.m
//  LYDApp
//
//  Created by fcl on 2017/6/28.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "XinShouZhuanXiangGouMaiViewController.h"
#import "BuyMarkHeadView.h"
#import "FenShuInvestmentView.h"
#import "CouponsView.h"
#import "DSYCouponSelectViewCell.h"
#import "DSYCouponModel.h"
#import "XYPlanConfirmTXController.h"
@interface XinShouZhuanXiangGouMaiViewController ()<UITableViewDelegate,UITableViewDataSource,XYErrorHudDelegate,ChongzhiDelegate>
@property(nonatomic,strong)BuyMarkHeadView *headView;
@property(nonatomic,strong)FenShuInvestmentView *investmentView;
@property(nonatomic,strong)CouponsView *couponView;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)UITableView *couponTableView;
@property (nonatomic, strong) NSIndexPath   *currentIndex;
@property (nonatomic, strong) DSYCouponModel *coupon;
@property(nonatomic,strong)UIButton *BuyBtn;

@end

@implementation XinShouZhuanXiangGouMaiViewController

-(NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showMessage:nil toView:self.view];
    // 更新数据
    [self loadMyBalance];
    
    
    
    
    
    [self requestCouponList];
    self.currentIndex = nil;
    self.coupon = nil;
    
    //    NSString *showStr = [NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count];
    //    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:showStr attributes:nil];
    //    [self.discountLabel setAttributedTitle:attr forState:(UIControlStateNormal)];
    //    [self.couponTableView reloadData];
    //    [self setupMyUI];
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        id backData = LYDJSONSerialization(data);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            self.myBalance = [NSString stringWithFormat:@"%@",[backData valueForKey:@"balance"]];
            if (self.investmentView) {
                //self.balanceLabel.text = [NSString stringWithFormat:@"¥%.2f", [self.myBalance floatValue]];
                self.investmentView.balance.text=[NSString stringWithFormat:@"¥%.2f", [self.myBalance floatValue]];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            self.investmentView.balance.text = [NSString stringWithFormat:@"余额获取失败"];
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


-(void)didClickButtonChongzhi:(UIButton *)button
{
    
    
    if ([DSYAccount sharedDSYAccount].mobile.length == 0) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"当前用户获取失败" okHandler:^(UIAlertAction *action) {
            // 清空Token
            UserDefaultsWriteObj(@"", @"access-token");
            [DSYAccount sharedDSYAccount].refresh = NO;
            XYLoginController *loginVC = [[XYLoginController alloc] init];
            loginVC.hiddenBackBtn = YES;
            [self.navigationController pushViewController:loginVC animated:NO];
        } cancelHandler:^(UIAlertAction * action) {
        }];
        return;
    }
    
    DSYAccountRechargeController *rechargeVC = [[DSYAccountRechargeController alloc] init];
    rechargeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
}


-(CouponsView *)couponView
{
    if (!_couponView) {
        _couponView=[[CouponsView alloc]init];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discountLabelTapped:)];
        [_couponView addGestureRecognizer:tap];
        _couponView.userInteractionEnabled=YES;
    }
    return _couponView;
}

-(BuyMarkHeadView *)headView
{
    if (!_headView) {
        _headView=[[BuyMarkHeadView alloc]init];
    }
    return _headView;
}

-(FenShuInvestmentView *)investmentView
{
    if (!_investmentView) {
        _investmentView=[[FenShuInvestmentView alloc]init];
        _investmentView.delegate=self;
    }
    return _investmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGB(246, 246, 245);
    self.navigaTitle=[NSString stringWithFormat:@"购买%@",self.model.title];
    [self createUI];
    //[self requestCouponList];
}

-(void)createUI{
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).mas_offset(KWidth(12));
        make.right.equalTo(self.view.mas_right).mas_offset(-KWidth(12));
        make.top.equalTo(self.view.mas_top).mas_offset(KHeight(10)+64);
        make.height.mas_equalTo(KHeight(158));
    }];
    [self.headView getAccount:self.model];
    
    [self.view addSubview:self.investmentView];
    [self.investmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.headView.mas_bottom).mas_offset(KHeight(10));
        make.height.mas_equalTo(KHeight(186));
    }];
    [self.investmentView setFenShuInvestmentViewInformation:self.myBalance XYPlanModel:self.model];
    [self.view addSubview:self.couponView];
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.investmentView.mas_bottom).mas_offset(KHeight(10));
        make.height.mas_equalTo(KHeight(44));
    }];
    
    self.BuyBtn=[[UIButton alloc]init];
    self.BuyBtn.frame=CGRectMake(0, ScreenHeight-KHeight(49),ScreenWidth, KHeight(49));
    self.BuyBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];
    [self.BuyBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    [self.BuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.BuyBtn addTarget:self action:@selector(goGouMai) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.BuyBtn];
    
}




-(void)goGouMai
{
    
    if (self.coupon.minInvestAmount > self.investmentView.count * [self.model.perAmount integerValue])
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
    
    
    
    if ([DSYAccount sharedDSYAccount].ipsAccount.length <= 0) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"用户未开户，请进行开户" okHandler:^(UIAlertAction *action) {
            DSYOpenAccountController *oppenAccountVC = [[DSYOpenAccountController alloc] initWithType:DSYOpenAccountControllerFromTypeNone];
            oppenAccountVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:oppenAccountVC animated:YES];
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else if (self.investmentView.count * [self.model.perAmount integerValue] > [self.myBalance integerValue]+youhuiquan) {
        
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"余额不足" andDoneBtnTitle:@"去充值" andDoneBtnHidden:NO];
        errorHud.delegate = self;
        [self.view.window addSubview:errorHud];
        
    } else {
        
        XYPlanConfirmTXController *confirmVC = [[XYPlanConfirmTXController alloc] init];
        confirmVC.model = self.model;
        
        confirmVC.amount =[NSString stringWithFormat:@"%ld",(long)self.investmentView.count] ;
        
        if (self.currentIndex == nil) {
            confirmVC.discount = @"没有使用优惠券";
            confirmVC.couponId = @"0";
        } else {
            DSYCouponModel *coupon = self.dataList[self.currentIndex.row];
            confirmVC.couponId = [NSString stringWithFormat:@"%ld", coupon.couponId];
            //            DSYCouponSelectViewCell *cell = [self.couponTableView cellForRowAtIndexPath:self.currentIndex];
            
            //confirmVC.discount = self.discountLabel.titleLabel.attributedText.string;
            confirmVC.discount = self.couponView.Coupons.attributedText.string;
            confirmVC.coupon = coupon;
        }
        //        confirmVC.discount = @"500";
        [self.navigationController pushViewController:confirmVC animated:YES];
        
    }
    [self discountLabelTapped:nil];
    
}



#pragma mark contentTableView的创建---------
- (UITableView *)couponTableView {
    if (!_couponTableView) {
        //  计算最大高度
        
        CGFloat tableViewY = self.couponView.y+self.couponView.height;
        
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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


-(void)requestCouponList{
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
            
            NSString *showStr = [NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count];
            NSAttributedString *attr = [[NSAttributedString alloc] initWithString:showStr attributes:nil];
            self.couponView.Coupons.attributedText=attr;
            
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

- (void)discountLabelTapped:(UITapGestureRecognizer *)tap
{
    [self.view bringSubviewToFront:self.couponTableView];
    [self.couponTableView reloadData];
    //    if (tap == nil) {
    //        [UIView animateWithDuration:0.5 animations:^{
    //            self.couponTableView.height = 0;
    //            self.couponView.jiantou.transform = CGAffineTransformIdentity;
    //            self.couponView.jiantou.transform = CGAffineTransformRotate(self.couponView.jiantou.transform, -M_PI_2);
    //        } completion:^(BOOL finished) {
    //        }];
    //        return;
    //    }
    
    if (self.dataList.count <= 0) {
        [MBProgressHUD showError:@"您没有优惠券可选!" toView:self.view];
        [UIView animateWithDuration:0.5 animations:^{
            self.couponTableView.height = 0;
            self.couponView.jiantou.transform = CGAffineTransformIdentity;
            self.couponView.jiantou.transform = CGAffineTransformRotate(self.couponView.jiantou.transform, -M_PI_2);
        }];
        return;
    }
    
    
    CGFloat maxHeight = HEIGHT-self.couponView.frame.origin.y-self.couponView.height-KHeight(49);
    
    // 计算高度
    CGFloat height = self.dataList.count * H(92);
    if (height >= maxHeight) {
        height = maxHeight;
    }
    
    if (self.couponTableView.height > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.couponTableView.height = 0;
            //self.couponView.jiantou.transform = CGAffineTransformIdentity;
            self.couponView.jiantou.transform = CGAffineTransformRotate(self.couponView.jiantou.transform, -M_PI_2);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.couponTableView.height = height;
            //self.couponView.jiantou.transform = CGAffineTransformIdentity;
            self.couponView.jiantou.transform = CGAffineTransformRotate(self.couponView.jiantou.transform, M_PI_2);
        }];
    }
}

#pragma mark contentTableView的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYCouponSelectViewCell *cell = [self.couponTableView cellForRowAtIndexPath:indexPath];
    // 优惠券中加息券的利率
    if (self.currentIndex == indexPath) {
        self.currentIndex = nil;
        self.coupon = nil;
        NSString *showStr = [NSString stringWithFormat:@"您有%ld张优惠券可以使用", self.dataList.count];
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:showStr attributes:nil];
        self.couponView.Coupons.attributedText=attr;
        [self.couponTableView reloadData];
        
        [self setupMyUI];
        return;
    }
    
    
    self.currentIndex = indexPath;
    DSYCouponModel *coupon = self.dataList[self.currentIndex.row];
    self.coupon = coupon;
    
    
    //最小份数
    NSInteger  maxFenShu=self.coupon.minInvestAmount/[self.model.perAmount integerValue];
    
    if (maxFenShu*[self.model.perAmount integerValue]<self.coupon.minInvestAmount) {
        ++maxFenShu;
    }
    
    
    self.investmentView.fenshuLabel.text= [NSString stringWithFormat:@"%ld",(long)maxFenShu];
    self.investmentView.Field.text=[NSString stringWithFormat:@"%ld",(long)maxFenShu];
    self.investmentView.count=maxFenShu;
    [self setupMyUI];
    [self.investmentView fieldTextChang];
    self.couponView.Coupons.attributedText=cell.amoutNameLabel.attributedText;
    [self.couponTableView reloadData];
    
    //    [self discountLabelTapped:nil];
}


#pragma mark 设置UI的显示内容
- (void)setupMyUI {
    CGFloat apr = 0;
    // 总投资金额
    CGFloat allInvestAmount =  self.investmentView.count * [self.model.perAmount floatValue] * 1.0;
    // 投资金额的显示
    self.investmentView.total.text = [NSString stringWithFormat:@"￥%.2f", allInvestAmount];
    
    if (self.coupon.type == 3) {  // 如果是加息券的时候
        apr = self.coupon.amount;
    } else { // 不是加息券的时候
        apr = 0;
    }
    
    
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
    
    
    ////贴息收益
    CGFloat actualAdd11 =[self.model.aprDiscount  floatValue];
    CGFloat rateAdd11 = actualAdd11 / 100  / 12;
    // 如果是日
    if ([self.model.periodUnit integerValue] == 1) {
        // 日
        rateAdd11 = actualAdd11 / 365 / 100;
    } else if ([self.model.periodUnit integerValue] == -1) {
        // 年
        rateAdd11 = actualAdd11 / 100;
    } else if ([self.model.periodUnit integerValue] == 2) {
        // 周
        rateAdd11 = actualAdd11 * 7 / 365 / 100;
    }
    
    
    //金额*以前的利率+金额*贴息券的利率
    //    self.preBenifitLabel.text = [NSString stringWithFormat:@"￥%.2f", allInvestAmount *  periods * rate+allInvestAmount *  periods * rateAdd+allInvestAmount *  periods * rateAdd11];
    
    //金额*以前的利率+金额*贴息券的利率
    self.investmentView.earnings.text = [NSString stringWithFormat:@"￥%.2f", allInvestAmount *  periods * rate+allInvestAmount *  periods * rateAdd];
    
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
