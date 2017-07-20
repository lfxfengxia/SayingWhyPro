//
//  MessageXYAccountController.m
//  LYDApp
//
//  Created by fcl on 2017/5/10.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "MessageXYAccountController.h"
#import "ZWVerticalAlignLabel.h"
#import "DSYAccountCenterController.h"
#import "DSYAccountRechargeController.h"
#import "DSYAccountCashController.h"
#import "DSYAccountFinancingViewController.h"
#import "RBStandardPowderViewController.h"
#import "DSYMyDebtsViewController.h"
#import "RBNewHandAreaViewController.h"
#import "RBSecurityCenterViewController.h"
#import "RBCapitalDeatilViewController.h"
#import "DSYAccountBankController.h"
#import "DSYAskFriendsViewController.h"
#import "DSYAccountCouponController.h"
#import "toolsimple.h"
#import "LoginStareViewController.h"

@interface MessageXYAccountController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic, strong) UIView *contentTableViewHeader;

@property (nonatomic, strong) UIView *headerBackgroundView; /**< 头部视图的背景视图 */
@property (nonatomic, strong) UIImageView *headerBGView;    /**< 头部内容区域 */
@property (nonatomic, strong) UIView *headerAccoutBGView;   /**< 用户显示区域 */

@property (nonatomic, strong) UILabel *navigationTitleLabel;  /**< 导航栏的标题 */
@property (nonatomic, strong) UIView *avatarShadowView;       /**< 头像阴影View */
@property (nonatomic, strong) UIImageView *avatarImgView;     /**< 头像 */

@property (nonatomic, strong) UILabel *accountNameLabel;      /**< y用户名 */
@property (nonatomic, strong) UILabel *allAssetsLabel;        /**< 总资产 */
@property (nonatomic, strong) UIButton *editBtn;

// 本金，利息， 余额的背景
@property (nonatomic, strong) UIImageView *showBgView;              /**< 本金，利息， 余额的背景 */


// 显示的label
@property (nonatomic, strong) ZWVerticalAlignLabel *advancePrincipalLabel;  /**< 预收本金 */
@property (nonatomic, strong) ZWVerticalAlignLabel *advanceInterestLabel;   /**< 预估利息 */
@property (nonatomic, strong) ZWVerticalAlignLabel *freezingBalanceLabel;  /**< 冻结资金 */
@property (nonatomic, strong) ZWVerticalAlignLabel *availableBalanceLabel;  /**< 可用余额 */
@property (nonatomic, strong) UIView *middleLine;

@property (nonatomic, strong) UIView *buttonBGView;   /**< 按钮的背景视图 */


@property (nonatomic, strong) UITableView *contentTableView;  /**< 主要区域 */

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *imgAndTitleArr;

@property (nonatomic, strong) UIView *navigationHeaderView;         /**< 最上面navigation */

@property(nonatomic,strong) UIImageView *hexiang;
@property(nonatomic,strong)UIImageView *hexiangshu1;
@property(nonatomic,strong)UIImageView *hexiangshu2;

@end

@implementation MessageXYAccountController

- (void)viewDidLoad {
    [self IsUpdate];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置tabBar的状态
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    //    [self setupNavigationBar];
    [self creatUI];
    
    // 当所有的UI创建完毕后创建navigationHeaderView,以防被其他视图覆盖
    [self navigationHeaderView];
    [DSYAccount sharedDSYAccount].refresh = YES;
    //    [self loadData];
    
    [self backui];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backAction) name:@"xiaohui" object:nil];//销毁之前的消息
}
-(void)backui
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 40, 40);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
}
-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithCapacity:0];
        [_titleArr addObjectsFromArray:@[@"个人中心"]];
    }
    return _titleArr;
}

- (NSMutableArray *)imgAndTitleArr {
    if (!_imgAndTitleArr) {
        _imgAndTitleArr = [NSMutableArray arrayWithCapacity:0];
        
        [_imgAndTitleArr addObject:@{@"icon":@"zijingmingxinew", @"title":@"资金明细", @"count":@0}];
        [_imgAndTitleArr addObject:@{@"icon":@"anquanzhongxinnew", @"title":@"安全中心", @"count":@0}];
        [_imgAndTitleArr addObject:@{@"icon":@"yinghangkanew", @"title":@"我的银行卡", @"count":@0}];
        [_imgAndTitleArr addObject:@{@"icon":@"yaoqinghaoyounew", @"title":@"邀请好友", @"count":@0}];
        [_imgAndTitleArr addObject:@{@"icon":@"youhuiquannew", @"title":@"优惠券", @"count":@2}];
    }
    return _imgAndTitleArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [self IsUpdate];
    [super viewWillAppear:animated];
    
    if ([TOKEN length] == 0) {
        // 清空Token
        UserDefaultsWriteObj(@"", @"access-token");
        [DSYAccount sharedDSYAccount].refresh = NO;
//        XYLoginController *loginVC = [[XYLoginController alloc] init];
//        loginVC.hiddenBackBtn = YES;
        LoginStareViewController *start=[[LoginStareViewController alloc]init];
        [self.navigationController pushViewController:start animated:NO];
    } else {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD hideHUD];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    [self loadData];
}



//用户弹框提示
-(void)IsUpdate
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//app当前版本号
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"appVersion":app_Version,@"appType":@"2",@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appVersion":app_Version,@"appType":@"2",@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    // 开始请求数据
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/content/getAppVersion", APIPREFIX] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        id backData = LYDJSONSerialization(data);
        //imposedUpdate/*状态:0最新版本，1强制，2非强制*/
        NSInteger imposedUpdate=[backData[@"imposedUpdate"] integerValue];
        NSString *msg=backData[@"updateContent"];
        if (imposedUpdate==1) {
            NSInteger t=[toolsimple  sharedPersonalData].isalert;
            if ([toolsimple  sharedPersonalData].isalert==0) {
                [toolsimple  sharedPersonalData].isalert=1;
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                alert.tag=1;
                [alert show];
            }
            
            
        }else if (imposedUpdate==2)
        {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil];
            alert.tag=2;
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    NSError *errorr;
    NSString *urlStr=[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",AppleID];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSData *response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *appInfoDic=[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&errorr];
    
    if (errorr)
    {
        NSLog(@"error:%@",[errorr description]);
        return ;
    }
    NSArray *resultArray=[appInfoDic objectForKey:@"results"];
    //    NSLog(@"resultArray:%@",resultArray);
    if (![resultArray count])
    {
        //        NSLog(@"error: nil");
        return;
    }
    NSDictionary *infoDic=[resultArray objectAtIndex:0];
    NSString  *trackViewUrl=[infoDic objectForKey:@"trackViewUrl"];//下载地址
    //   NSString  *trackViewUrl=@"https://itunes.apple.com/us/app/零用贷理财/id1091450596?l=zh&ls=1&mt=8";//下载地址
    if (alertView.tag==1) {
        
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
        }
        
    }else if (alertView.tag==2)
    {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
        
    }
    
    
}




- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 如果用户有信息更新就刷新一次
    if ([DSYAccount sharedDSYAccount].refresh) {
        [self loadData];
        [DSYAccount sharedDSYAccount].refresh = NO;
    }
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
        [self.contentTableView.header endRefreshing];
    });
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/info", APIPREFIX] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        [self.contentTableView.header endRefreshing];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        NSInteger statusCode = [backData[@"code"] integerValue];;
        
        if (statusCode == 200) {
            [[DSYAccount sharedDSYAccount] setValuesForKeysWithDictionary:backData[@"account"]];
            // 数据加载成功后设置相应的信息
            [self setUpInformation];
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
        [self.contentTableView reloadData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.contentTableView.header endRefreshing];
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

- (void)setUpInformation {
    DSYAccount *account = [DSYAccount sharedDSYAccount];
    // 设置总资产的显示
    [self showAllAsset];
    
    self.advancePrincipalLabel.text = [NSString stringWithFormat:@"￥%.2f", account.totalCorpus];
    self.advanceInterestLabel.text = [NSString stringWithFormat:@"￥%.2f", account.totalInterest];
    self.freezingBalanceLabel.text = [NSString stringWithFormat:@"￥%.2f", account.freeze];
    self.availableBalanceLabel.text = [NSString stringWithFormat:@"￥%.2f", account.availableBalance];
    
    if ([self isBlankString:account.realName]) {
        _accountNameLabel.text = account.mobile;
    }
    else
    {
        
        _accountNameLabel.text = account.realName;
    }
    
    [self.avatarImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", account.avatar]] placeholderImage:kPlaceholderImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        //        [weakSelf addShadowForMyAvatar];
    }];
    
}

#pragma mark - UI的创建----------------------------
- (void)creatUI {
    
    [self contentTableView];
    
    [self contentTableViewHeader];
    [self headerBackgroundView];
    [self headerBGView];
    [self navigationTitleLabel];
    [self headerAccoutBGView];
    
    [self avatarImgView];
    [self accountNameLabel];
    [self editBtn];
    
    [self allAssetsLabel];
    
    [self showBgView];
    
    [self advancePrincipalLabel];
    [self advanceInterestLabel];
    [self freezingBalanceLabel];
    [self availableBalanceLabel];
    // [self middleLine];
    
    [self buttonBGView];
    [self hexiang];
    [self hexiangshu1];
    [self hexiangshu2];
}


#pragma mark - property的getter 方法（懒加载）
- (UIView *)contentTableViewHeader {
    if (!_contentTableViewHeader) {
        _contentTableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(300 + 50+76))];
        self.contentTableView.tableHeaderView = _contentTableViewHeader;
    }
    return _contentTableViewHeader;
}

- (UIView *)headerBackgroundView {
    if (!_headerBackgroundView) {
        _headerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(220+50))];
        [self.contentTableViewHeader addSubview:_headerBackgroundView];
        _headerBackgroundView.userInteractionEnabled = YES;
        //_headerBackgroundView.backgroundColor = rgba(249, 195, 56, 1);
    }
    return _headerBackgroundView;
}


- (UIImageView *)headerBGView {
    if (!_headerBGView) {
        _headerBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(220+50))];
        [self.headerBackgroundView addSubview:_headerBGView];
        _headerBGView.userInteractionEnabled = YES;
        _headerBGView.image = DSYImage(@"my_account_bg");
        
    }
    return _headerBGView;
}

- (UILabel *)navigationTitleLabel {
    if (!_navigationTitleLabel) {
        _navigationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.headerBGView.width,30)];
        [self.headerBGView addSubview:_navigationTitleLabel];
        //_navigationTitleLabel.text = @"我的账户";
        _navigationTitleLabel.font = [UIFont systemFontOfSize:17.0f weight:2];
        _navigationTitleLabel.textAlignment = NSTextAlignmentCenter;
        UILabel *lbltitle=[[UILabel alloc] init];
        lbltitle.frame=CGRectMake(0, 30, self.headerBGView.width,10);
        lbltitle.text= @"我的账户";
        lbltitle.textColor=[UIColor whiteColor];
        lbltitle.textAlignment=NSTextAlignmentCenter;
        [_navigationTitleLabel addSubview:lbltitle];
        
    }
    return _navigationTitleLabel;
}

- (UIView *)headerAccoutBGView {
    if (!_headerAccoutBGView) {
        _headerAccoutBGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationTitleLabel.maxY, self.headerBGView.width, self.headerBGView.height - self.navigationTitleLabel.maxY)];
        [self.headerBGView addSubview:_headerAccoutBGView];
    }
    return _headerAccoutBGView;
}

- (UIImageView *)avatarImgView {
    if (!_avatarImgView) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(X(20), Y(20), H(60), H(60))];
        [self.headerAccoutBGView addSubview:bgView];
        self.avatarShadowView = bgView;
        self.avatarShadowView.layer.cornerRadius = H(30);
        [self addShadowForMyAvatar];
        
        _avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(X(20), Y(20), H(60), H(60))];
        [self.headerAccoutBGView addSubview:_avatarImgView];
        //        _avatarImgView.backgroundColor = [UIColor redColor];
        _avatarImgView.image = DSYImage(@"account_test_avatar.png");
        _avatarImgView.userInteractionEnabled = YES;
        _avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImgView.layer.cornerRadius = _avatarImgView.width / 2;
        _avatarImgView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editMyAccount)];
        [_avatarImgView addGestureRecognizer:tap];
        [self addShadowForMyAvatar];
    }
    return _avatarImgView;
}

- (UILabel *)accountNameLabel {
    if (!_accountNameLabel) {
        CGFloat startX = self.avatarImgView.maxX + X(10);
        _accountNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX, self.avatarImgView.centerY - Y(20), self.headerBGView.centerX - startX+20 , H(20))];
        [self.headerAccoutBGView addSubview:_accountNameLabel];
        
        DSYAccount *account = [DSYAccount sharedDSYAccount];
        if ([self isBlankString:account.realName]) {
            _accountNameLabel.text = account.mobile;
        }
        else
        {
            
            _accountNameLabel.text = account.realName;
        }
        
        _accountNameLabel.textColor = [UIColor whiteColor];
        _accountNameLabel.font = DSY_NORMALFONT_15;
    }
    return _accountNameLabel;
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



- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.headerAccoutBGView addSubview:_editBtn];
        _editBtn.frame = CGRectMake(self.accountNameLabel.x, self.accountNameLabel.maxY, H(50), H(20));
        _editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, H(30));
        UILabel *editShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(H(20), Y(5), H(30), H(15))];
        [_editBtn setImage:DSYImage(@"account_editNew") forState:(UIControlStateNormal)];
        [_editBtn addSubview:editShowLabel];
        editShowLabel.text = @"编辑";
        [editShowLabel sizeToFit];
        editShowLabel.font = DSY_NORMALFONT_13;
        editShowLabel.userInteractionEnabled = YES;
        editShowLabel.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editMyAccount)];
        [editShowLabel addGestureRecognizer:tap];
        [_editBtn addTarget:self action:@selector(editMyAccount) forControlEvents:(UIControlEventTouchUpInside)];
        //        tap = nil;
    }
    return _editBtn;
}

- (UILabel *)allAssetsLabel {
    if (!_allAssetsLabel) {
        _allAssetsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headerAccoutBGView.centerX, self.editBtn.maxY - Y(28), self.headerAccoutBGView.width / 2 - X(30), H(28))];
        [self.headerAccoutBGView addSubview:_allAssetsLabel];
        _allAssetsLabel.text = @"￥0.00";
        _allAssetsLabel.textColor = [UIColor whiteColor];
        _allAssetsLabel.font = DSY_NORMALFONT_15;
        _allAssetsLabel.textAlignment = NSTextAlignmentRight;
        
        UILabel *allAssetsShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.allAssetsLabel.x, self.allAssetsLabel.y - H(12), self.allAssetsLabel.width, H(12))];
        [self.headerAccoutBGView addSubview:allAssetsShowLabel];
        allAssetsShowLabel.text = @"总资产";
        allAssetsShowLabel.font = DSY_NORMALFONT_15;
        allAssetsShowLabel.textColor = [UIColor whiteColor];
        allAssetsShowLabel.textAlignment = NSTextAlignmentRight;
    }
    return _allAssetsLabel;
}

- (UIImageView *)showBgView {
    if (!_showBgView) {
        _showBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.avatarImgView.maxY + Y(20), self.headerAccoutBGView.width, H(36+45+5))];
        
        
        [self.headerAccoutBGView addSubview:_showBgView];
        _showBgView.userInteractionEnabled = YES;
        //        _showBgView.image = DSYImage(@"solid_line.png");
        
    }
    return _showBgView;
}

- (UILabel *)advancePrincipalLabel {
    if (!_advancePrincipalLabel) {
        _advancePrincipalLabel = [self creatLabelWithTitle:@"待收本金" frame:CGRectMake(0, -5, self.showBgView.width / 2, 36) clickSelector:@selector(principalClick)];
        _advancePrincipalLabel.textColor=[UIColor whiteColor];
        _advancePrincipalLabel.tintColor=[UIColor whiteColor];
    }
    return _advancePrincipalLabel;
}


- (UIImageView *)hexiang {
    if (!_hexiang) {
        _hexiang = [[UIImageView alloc] init];
        _hexiang.frame=CGRectMake(50, 36, _showBgView.frame.size.width-100, 1);
        _hexiang.image=[UIImage imageNamed:@"my_acc_line_he"];
        _hexiang.tintColor=[UIColor whiteColor];
        [_showBgView  addSubview:_hexiang];
    }
    return _hexiang;
}

- (UIImageView *)hexiangshu1 {
    if (!_hexiangshu1) {
        _hexiangshu1 = [[UIImageView alloc] init];
        _hexiangshu1.frame=CGRectMake(self.showBgView.width / 2, -5, 1, 30.5);
        _hexiangshu1.image=[UIImage imageNamed:@"my_acc_line_wr"];
        _hexiangshu1.tintColor=[UIColor whiteColor];
        [_showBgView  addSubview:_hexiangshu1];
    }
    return _hexiang;
}


- (UIImageView *)hexiangshu2 {
    if (!_hexiangshu2) {
        _hexiangshu2 = [[UIImageView alloc] init];
        _hexiangshu2.frame=CGRectMake(self.showBgView.width / 2, 43+5, 1, 30.5);
        _hexiangshu2.image=[UIImage imageNamed:@"my_acc_line_wr"];
        _hexiangshu2.tintColor=[UIColor whiteColor];
        [_showBgView  addSubview:_hexiangshu2];
    }
    return _hexiang;
}



- (UILabel *)advanceInterestLabel {
    if (!_advanceInterestLabel) {
        _advanceInterestLabel = [self creatLabelWithTitle:@"待收利息" frame:CGRectMake(self.showBgView.width / 2, -5, self.showBgView.width / 2, 36) clickSelector:@selector(principalClick)];
        _advanceInterestLabel.textColor=[UIColor whiteColor];
    }
    return _advanceInterestLabel;
}
- (UILabel *) freezingBalanceLabel{
    if (!_freezingBalanceLabel) {
        _freezingBalanceLabel = [self creatLabelWithTitle:@"冻结资金" frame:CGRectMake(0, _advanceInterestLabel.maxY+5+5, self.showBgView.width / 2, 36) clickSelector:@selector(principalClick)];
        _freezingBalanceLabel.textColor=[UIColor whiteColor];
    }
    return _freezingBalanceLabel;
}

- (UILabel *)availableBalanceLabel {
    if (!_availableBalanceLabel) {
        _availableBalanceLabel = [self creatLabelWithTitle:@"可用余额" frame:CGRectMake(self.showBgView.width / 2, self.advanceInterestLabel.maxY+5+5, self.showBgView.width / 2, 36) clickSelector:@selector(principalClick)];
        _availableBalanceLabel.textColor=[UIColor whiteColor];
    }
    return _availableBalanceLabel;
}

-(UIView *)middleLine{
    if (!_middleLine) {
        _middleLine = [[UIView alloc] initWithFrame:CGRectMake(self.showBgView.width / 2, 0, 1, self.showBgView.height)];
        _middleLine.backgroundColor = RGB(229, 173, 61);
        [self.showBgView addSubview:_middleLine];
    }
    return _middleLine;
}


- (UIView *)buttonBGView {
    if (!_buttonBGView) {
        _buttonBGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerBackgroundView.maxY, self.headerBackgroundView.width, H(150))];
        [self.contentTableViewHeader addSubview:_buttonBGView];
        //_buttonBGView.backgroundColor = rgba(249, 249, 249, 1);
        _buttonBGView.backgroundColor = [UIColor clearColor];
        // 创建两个button
        //        UIButton *rechargeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //        [rechargeBtn setTitle:@"充值" forState:(UIControlStateNormal)];
        //        [rechargeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        //        rechargeBtn.titleLabel.font = DSY_NORMALFONT_16;
        //        rechargeBtn.frame = CGRectMake(0, 0, W(170), H(49));
        //        rechargeBtn.backgroundColor = rgba(251, 108, 32, 1);
        //        rechargeBtn.center = CGPointMake(_buttonBGView.width / 4, _buttonBGView.height / 2);
        //        rechargeBtn.layer.cornerRadius = X(2.5);
        //        [rechargeBtn addTarget:self action:@selector(rechargeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        //        [_buttonBGView addSubview:rechargeBtn];
        //
        //        UIButton *cashBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //        [cashBtn setTitle:@"提现" forState:(UIControlStateNormal)];
        //        [cashBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        //        cashBtn.titleLabel.font = DSY_NORMALFONT_16;
        //        cashBtn.frame = CGRectMake(0, 0, W(170), H(49));
        //        cashBtn.layer.cornerRadius = X(2.5);
        //        cashBtn.backgroundColor = rgba(251, 108, 32, 1);
        //        cashBtn.center = CGPointMake(_buttonBGView.width * 3 / 4, _buttonBGView.height / 2);
        //        [cashBtn addTarget:self action:@selector(cashBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        //        [_buttonBGView addSubview:cashBtn];
        
        UIView  *btnview=[[UIView alloc] init];
        btnview.frame=CGRectMake(0, 0, 2*self.headerBackgroundView.width/3, 40);
        btnview.backgroundColor=[UIColor whiteColor];
        btnview.layer.cornerRadius=20;
        btnview.center = CGPointMake(_buttonBGView.width/2, 0);
        
        
        UIImageView *imgshu=[[UIImageView alloc] init];
        imgshu.image=[UIImage imageNamed:@"my_acc_line_or"];
        imgshu.frame=CGRectMake(self.headerBackgroundView.width/3, 10, 1, 20);
        
        
        [btnview addSubview:imgshu];
        
        
        
        
        UIButton *rechargeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [rechargeBtn setTitle:@"充值" forState:(UIControlStateNormal)];
        [rechargeBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        rechargeBtn.titleLabel.font = DSY_NORMALFONT_16;
        rechargeBtn.frame = CGRectMake(0, 0, self.headerBackgroundView.width/3, 40);
        rechargeBtn.backgroundColor = [UIColor clearColor];
        //rechargeBtn.center = CGPointMake(_buttonBGView.width / 4, _buttonBGView.height / 2);
        rechargeBtn.layer.cornerRadius = X(2.5);
        [rechargeBtn addTarget:self action:@selector(rechargeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        
        [btnview addSubview:rechargeBtn];
        
        
        
        
        
        UIButton *cashBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [cashBtn setTitle:@"提现" forState:(UIControlStateNormal)];
        [cashBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        cashBtn.titleLabel.font = DSY_NORMALFONT_16;
        cashBtn.frame = CGRectMake(rechargeBtn.maxX+1, 0, self.headerBackgroundView.width/3, 40);
        cashBtn.layer.cornerRadius = X(2.5);
        cashBtn.backgroundColor = [UIColor clearColor];
        //cashBtn.center = CGPointMake(_buttonBGView.width * 3 / 4, _buttonBGView.height / 2);
        [cashBtn addTarget:self action:@selector(cashBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [btnview addSubview:cashBtn];
        
        
        //零定宝
        
        UIImageView  *imgdqlc=[[UIImageView alloc] init];
        imgdqlc.image=[UIImage imageNamed:@"XSbg"];
        
        imgdqlc.userInteractionEnabled=YES;
        imgdqlc.frame=CGRectMake(0, 30, (self.headerBackgroundView.width-10)/2, H(150)-30);
        [_buttonBGView addSubview:imgdqlc];
        
        
        UIImageView  *imgdqlcsmall=[[UIImageView alloc] init];
        imgdqlcsmall.image=[UIImage imageNamed:@"imgdqlcsmall"];
        
        
        imgdqlcsmall.frame=CGRectMake(10, (H(150)-40)/3, (H(150)-40)/3, (H(150)-40)/3);
        [imgdqlc addSubview:imgdqlcsmall];
        
        
        
        
        UIButton  *dqlcbtn=[[UIButton alloc] init];
        dqlcbtn.frame=CGRectMake(imgdqlcsmall.maxX, 0,(self.headerBackgroundView.width-10)/2-(10+(H(150)-40)/3), H(150)-30);
        [dqlcbtn setTitle:@"零定宝" forState:UIControlStateNormal];
        [dqlcbtn addTarget:self action:@selector(goLDB) forControlEvents:UIControlEventTouchUpInside];
        
        [dqlcbtn setTitleColor:TEXTBLACK forState:UIControlStateNormal];
        
        [imgdqlc addSubview:dqlcbtn];
        
        
        //新手专区
        
        UIImageView  *imgxszq=[[UIImageView alloc] init];
        imgxszq.image=[UIImage imageNamed:@"xiangshoubiaocell"];
        
        imgxszq.userInteractionEnabled=YES;
        imgxszq.frame=CGRectMake(imgdqlc.maxX+10, 30, (self.headerBackgroundView.width-10)/2, H(150)-30);
        [_buttonBGView addSubview:imgxszq];
        
        
        
        UIImageView  *imgxszqsmall=[[UIImageView alloc] init];
        imgxszqsmall.image=[UIImage imageNamed:@"imgxszqsmall"];
        
        
        imgxszqsmall.frame=CGRectMake(10, (H(150)-40)/3, (H(150)-40)/3, (H(150)-40)/3);
        [imgxszq addSubview:imgxszqsmall];
        
        
        
        
        UIButton  *xszqbtn=[[UIButton alloc] init];
        xszqbtn.frame=CGRectMake(imgdqlcsmall.maxX, 0,(self.headerBackgroundView.width-10)/2-(10+(H(150)-40)/3), H(150)-30);
        [xszqbtn setTitle:@"新手专区" forState:UIControlStateNormal];
        [xszqbtn addTarget:self action:@selector(goSXZQ) forControlEvents:UIControlEventTouchUpInside];
        
        [xszqbtn setTitleColor:TEXTBLACK forState:UIControlStateNormal];
        
        [imgxszq addSubview:xszqbtn];
        
        
        
        
        
        
        
        
        [_buttonBGView addSubview:btnview];
        
        
    }
    return _buttonBGView;
}





-(void)goLDB
{
    
    // 定期理财
    DSYAccountFinancingViewController *financingVC = [[DSYAccountFinancingViewController alloc] init];
    financingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:financingVC animated:YES];
    
}



-(void)goSXZQ
{
    
    // 新手专区
    RBNewHandAreaViewController *newHandAreaVC = [[RBNewHandAreaViewController alloc] init];
    newHandAreaVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newHandAreaVC animated:YES];
    
}


- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, self.view.width, self.view.height + 20) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_contentTableView];
        _contentTableView.backgroundColor = rgba(249, 249, 249, 1);
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.rowHeight = H(44);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        [_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultTableViewCell"];
        
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0); // 设置端距，这里表示separator离左边和右边均80像素
        _contentTableView.separatorColor=[UIColor clearColor];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _contentTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _contentTableView;
}

#pragma mark navigationLabel的创建------------
- (UIView *)navigationHeaderView {
    if (!_navigationHeaderView) {
        _navigationHeaderView = [[UIView alloc] init];
        [self.view addSubview:_navigationHeaderView];
        [self.view bringSubviewToFront:_navigationHeaderView];
        _navigationHeaderView.backgroundColor = self.headerBackgroundView.backgroundColor;
        [_navigationHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(64);
        }];
        
        UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:self.navigationTitleLabel.textColor fontOfSystemSize:W(17.0)];
        [_navigationHeaderView addSubview:showLabel];
        [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_navigationHeaderView).with.insets(UIEdgeInsetsZero);
        }];
        showLabel.font = self.navigationTitleLabel.font;
        showLabel.text = self.navigationTitleLabel.text;
        
        _navigationHeaderView.hidden = YES;
        
    }
    return _navigationHeaderView;
}

#pragma mark - 自定义方法
#pragma mark  创建ZWVerticalAlignLabel相关的控件
// 创建一个视图区域
- (ZWVerticalAlignLabel *) creatLabelWithTitle:(NSString *)title frame:(CGRect)frame clickSelector:(SEL)action {
    //    CGPoint origalPoint = frame.origin;
    CGSize  origalSize  = frame.size;
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    [self.showBgView addSubview:bgView];
    
    // 提示显示
    ZWVerticalAlignLabel *showLabel = [[ZWVerticalAlignLabel alloc] initWithFrame:CGRectMake(0, 0, origalSize.width, origalSize.height / 2)];
    showLabel.text = title;
    showLabel.font = DSY_NORMALFONT_15;
    showLabel.textColor = [UIColor whiteColor];
    showLabel.userInteractionEnabled = YES;
    [showLabel textAlign:^(ZWMaker *make) {
        make.addAlignType(textAlignType_top).addAlignType(textAlignType_center);
    }];
    [bgView addSubview:showLabel];
    
    
    ZWVerticalAlignLabel *valueLabel = [[ZWVerticalAlignLabel alloc] initWithFrame:CGRectMake(0, origalSize.height / 2, origalSize.width, origalSize.height / 2)];
    valueLabel.font = DSY_NORMALFONT_15;
    valueLabel.text = @"￥0.00";
    valueLabel.textColor = [UIColor whiteColor];
    valueLabel.userInteractionEnabled = YES;
    [valueLabel textAlign:^(ZWMaker *make) {
        make.addAlignType(textAlignType_bottom).addAlignType(textAlignType_center);
    }];
    [bgView addSubview:valueLabel];
    
    
    
    return valueLabel;
}

#pragma mark  总资产的显示
- (void)showAllAsset {
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] init];
    NSAttributedString *firstStr = [[NSAttributedString alloc] initWithString:@"￥" attributes:@{NSForegroundColorAttributeName:rgba(113, 33, 0, 1), NSFontAttributeName:DSY_NORMALFONT_15}];
    
    NSString *showAllInvest = [NSString stringWithFormat:@"%.2f", [DSYAccount sharedDSYAccount].totalAsset];
    NSAttributedString *secondStr = [[NSAttributedString alloc] initWithString:showAllInvest attributes:@{NSForegroundColorAttributeName:rgba(113, 33, 0, 1), NSFontAttributeName:[UIFont systemFontOfSize:W(24.0f) weight:UIFontWeightSemibold]}];
    [attributeText appendAttributedString:firstStr];
    [attributeText appendAttributedString:secondStr];
    self.allAssetsLabel.attributedText = attributeText;
    self.allAssetsLabel.textColor=[UIColor whiteColor];
}


#pragma mark 编辑个人信息
- (void)editMyAccount {
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
    
    DSYAccountCenterController *centerVC = [[DSYAccountCenterController alloc] init];
    centerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:centerVC animated:YES];
    //    [self presentViewController:centerVC animated:YES completion:nil];
}




- (void)principalClick {
    
}


- (void)rechargeBtnClick:(UIButton *)sender {
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

- (void)cashBtnClick:(UIButton *)sender {
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
    
    DSYAccountCashController *cashVC = [[DSYAccountCashController alloc] init];
    cashVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cashVC animated:YES];
}



//#pragma mark - tableView的DataSource和Delegate方法
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        static NSString *ID = @"defaultTableViewCell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
//            cell.textLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightSemibold];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.textLabel.text = self.titleArr[indexPath.row];
//        //    cell.contentView.backgroundColor = rgba(232, 232, 232, 1);
//
//        //    cell.contentView.backgroundColor = [UIColor redColor];
//        //    cell.backgroundColor = [UIColor redColor];
//
//        return cell;
//
//    } else {
//        static NSString *ID = @"defaultSubTableViewCell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
//            cell.textLabel.font = [UIFont systemFontOfSize:13.0f weight:UIFontWeightThin];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//
//        NSDictionary *dataDic = self.imgAndTitleArr[indexPath.row];
//        cell.imageView.image = DSYImage(dataDic[@"icon"]);
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.textLabel.text = dataDic[@"title"];
//        if ([dataDic[@"count"] integerValue] > 0) {
//            if (indexPath.row == 4) {
//                cell.detailTextLabel.text =[NSString stringWithFormat:@"%ld 张", [DSYAccount sharedDSYAccount].couponCount];
//            }
//        } else {
//            cell.detailTextLabel.text = @"";
//        }
//
//        return cell;
//    }
//
//}




#pragma mark - tableView的DataSource和Delegate方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        static NSString *ID = @"defaultSubTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightThin];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row!=4) {
                UIImageView  *imglineheng=[[UIImageView alloc] initWithFrame:CGRectMake(15, cell.frame.size.height, cell.frame.size.width-30, 1)];
                imglineheng.image=[UIImage imageNamed:@"licai_line_hui"];
                [cell.contentView addSubview:imglineheng];
            }
        }
        
        NSDictionary *dataDic = self.imgAndTitleArr[indexPath.row];
        cell.imageView.image = DSYImage(dataDic[@"icon"]);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = dataDic[@"title"];
        if ([dataDic[@"count"] integerValue] > 0) {
            if (indexPath.row == 4) {
                cell.detailTextLabel.text =[NSString stringWithFormat:@"%ld 张", [DSYAccount sharedDSYAccount].couponCount];
            }
        } else {
            cell.detailTextLabel.text = @"";
        }
        
        
        return cell;
        
        
    } else {
        
        
        
        
        static NSString *ID = @"defaultSubTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightThin];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        cell.imageView.image = [UIImage imageNamed:@"grzx"];;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.titleArr[indexPath.row];
        return cell;
        
    }
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //return self.titleArr.count;
        return self.imgAndTitleArr.count;
    } else {
        return self.titleArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return H(14);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 资金明细
            RBCapitalDeatilViewController *capitalDetailVC = [[RBCapitalDeatilViewController alloc] init];
            capitalDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:capitalDetailVC animated:YES];
        }
        else if (indexPath.row == 1)
        {
            // 安全中心
            RBSecurityCenterViewController *securityCenterVC = [[RBSecurityCenterViewController alloc] init];
            securityCenterVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:securityCenterVC animated:YES];
        }
        else if (indexPath.row == 2) {
            
            // 如若没有开户，进行开户
            if ([DSYAccount sharedDSYAccount].ipsAccount.length <= 0) {
                [DSYUtils showResponseError_404_ForViewController:self message:@"用户未开户，请进行开户" okHandler:^(UIAlertAction *action) {
                    DSYOpenAccountController *openAccountVC = [[DSYOpenAccountController alloc] init];
                    [self.navigationController pushViewController:openAccountVC animated:YES];
                } cancelHandler:^(UIAlertAction *action) {
                }];
                return;
            }
            
            // 银行卡
            DSYAccountBankController *bankVC = [[DSYAccountBankController alloc] init];
            bankVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bankVC animated:YES];
        }
        else if (indexPath.row == 3) {
            // 邀请好友
            DSYAskFriendsViewController *friendVC = [[DSYAskFriendsViewController alloc] init];
            friendVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:friendVC animated:YES];
        }
        else if (indexPath.row == 4) {
            // 优惠券
            DSYAccountCouponController *couponVC = [[DSYAccountCouponController alloc] init];
            couponVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:couponVC animated:YES];
        }
        
        
    }
    else if (indexPath.section == 1)
    {
        
        [self editMyAccount];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%f", self.contentTableView.contentOffset.y);
    
    if (self.contentTableView == scrollView) {
        CGPoint offset = self.contentTableView.contentOffset;
        CGRect frame = self.headerBackgroundView.frame;
        frame.origin.y = offset.y;
        //        frame.size.height =
    }
}


#pragma mark - 设置navigationBar的状态
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, 100, 20);
    self.navigationItem.titleView = titleLabel;
    titleLabel.text = @"我的账户";
    titleLabel.font = [UIFont systemFontOfSize:17.0f weight:2];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = rgba(249, 195, 56, 1);
}

#pragma mark - 给头像添加阴影
- (void)addShadowForMyAvatar {
    self.avatarShadowView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.avatarShadowView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.avatarShadowView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.avatarShadowView.layer.shadowRadius = 1;//阴影半径，默认3
    self.avatarShadowView.clipsToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.avatarShadowView.bounds.size.width;
    
    [path addArcWithCenter:CGPointMake(self.avatarShadowView.width / 2, self.avatarShadowView.height / 2) radius:(width / 2 + 1) startAngle:0 endAngle:180 clockwise:YES];
    
    //设置阴影路径  
    self.avatarShadowView.layer.shadowPath = path.CGPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end