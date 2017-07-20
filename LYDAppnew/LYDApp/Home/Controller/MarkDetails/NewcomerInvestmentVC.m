//
//  NewcomerInvestmentVC.m
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/28.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "NewcomerInvestmentVC.h"
#import "NewcomerInvestmentHeadView.h"
#import "NewComerMainView.h"
#import "XYExperienceConfirmController.h"

@interface NewcomerInvestmentVC ()
@property(nonatomic,strong)NewcomerInvestmentHeadView *headView;
@property(nonatomic,strong)NewComerMainView *mainView;
@property(nonatomic,strong)UIButton *buyBtn;
@end

@implementation NewcomerInvestmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGB(246, 246, 245);
    self.navigaTitle=@"使用体验金";
    [self createUI];
}


-(void)viewWillAppear:(BOOL)animated
{

    [self loadData];
}

-(NewComerMainView *)mainView
{
    if (!_mainView) {
        _mainView=[[NewComerMainView alloc]init];
    }
    return _mainView;
}
-(NewcomerInvestmentHeadView *)headView
{
    if (!_headView) {
        _headView=[[NewcomerInvestmentHeadView alloc]init];
    }
    return _headView;
}


/**
 * 加载信息
 */
- (void)loadData {
    // 设置总资产的显示
    //    [self showAllAsset];
    //    [self setUpInformation];
    
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"accountId":@([DSYUser sharedDSYUser].accountId), @"sign":sign};
    
    NSLog(@"%@----%@-----%@-----%@",APPKEY, timestamp, DEVICEID, TOKEN);
    [[DSYAccount sharedDSYAccount] clean];
    [MBProgressHUD showMessage:@"正在获取用户信息..." toView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    //http://localhost:8080/account/infoVersionThree
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/infoVersionThree", APIPREFIX] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];

        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        NSInteger statusCode = [backData[@"code"] integerValue];
        
        if (statusCode == 200) {
            [[DSYAccount sharedDSYAccount] setValuesForKeysWithDictionary:backData[@"account"]];
            // 数据加载成功后设置相应的信息

        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self okHandler:^(UIAlertAction * action) {
                // 清空Token
                UserDefaultsWriteObj(@"", @"access-token");
                [DSYAccount sharedDSYAccount].refresh = NO;
                XYLoginController *loginVC = [[XYLoginController alloc] init];
                loginVC.hiddenBackBtn = YES;
                [self.navigationController pushViewController:loginVC animated:NO];
            }];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }

        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //        id errorData = LYDJSONSerialization(operation.responseObject);
        
        NSInteger statusCode = operation.response.statusCode;
        
        //        NSString *result = [[ NSString alloc] initWithData:operation.responseObject encoding:NSUTF8StringEncoding];
        
        if (statusCode == 401) {
            // 401错误处理
            [DSYUtils showResponseError_401_ForViewController:self];
        } else if (statusCode == 404) {
            [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
                [self pushToLoginController];
            } cancelHandler:^(UIAlertAction *action) {
                [self pushToLoginController];
            }];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    }];
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
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.headView.mas_bottom).mas_offset(KHeight(10));
        make.height.mas_equalTo(KHeight(98));
    }];
    [self.mainView NewComerMainWithModel:self.model];
    
    self.buyBtn=[[UIButton alloc]init];
    self.buyBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];
    [self.buyBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buyBtn addTarget:self action:@selector(buyNewComerMark) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(KHeight(49));
    }];
    
}

-(void)buyNewComerMark{
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
