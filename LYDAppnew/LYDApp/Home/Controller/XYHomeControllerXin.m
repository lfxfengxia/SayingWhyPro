    //
//  XYHomeControllerXin.m
//  LYDApp
//
//  Created by fcl on 2017/6/15.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "XYHomeControllerXin.h"
#import "XYSanBidDetailController.h"
#import "XYPlanDetailController.h"
#import "XYExperienceController.h"
#import "DSYSanbidDetailViewController.h"
#import "DSYBannerDetailViewController.h"
#import "XYHomePlanCell.h"
#import "XYBidCell.h"
#import "XYPlanModel.h"
#import "XYSanBidModel.h"
#import "XYBannerModel.h"
#import "XYHomeLDBCell.h"
#import "LYDPlanDetailController.h"
#import "NewBidDetailController.h"
#import "XYHomePlanTXCell.h"
#import "toolsimple.h"
#import "MessageWebController.h"
#import "DSYAccountCouponController.h"
#import "MessageDSYAccountCouponController.h"
#import "GonggaoWebViewController.h"
#import "XYHomePlanTXCellFirst.h"
#import "XYHomeLDBCellFirst.h"
#import "XYBidZhuanXiangCell.h"
#import "XYHomePlanTXCellFirstReMen.h"
#import "FenxiaoHuoDongViewController.h"
#import "MessageXYAccountController.h"
#import "YiShouqingViewController.h"
#import "fenshubiaoDetailViewController.h"
#import "YiYueBiaoDetailViewController.h"
#import "TiYanJingLoginViewController.h"
#import "TiYanBiaoDetailViewController.h"
#import "BuyFenshuMarkVC.h"
#import "YiYueBiaoGouMaiViewController.h"
#import "TiYanBiaoSeccessViewController.h"
#import "DSYAbountUsWebViewController.h"
#import "DSYAskFriendsViewController.h"

// 导航栏高度
#define kNavBarH 64.0f
// 头部图片的高度
#define kHeardH  180.0f


@interface XYHomeControllerXin ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,UIAlertViewDelegate,MycellDelegate,YiYueBiaocellDelegate,XYHomePlanTXCellDelegate,XYHomeLDBCellDelegate>
{
    
    
    CGFloat _font;
    
    
}

@property(nonatomic, strong) UIView *navigationView;       // 导航栏
@property(nonatomic, strong) UIView *centerTextView;       // title文字
@property (nonatomic, assign) CGFloat lastOffsetY;        // 记录上一次位置
@property(nonatomic, strong) UIView *tankuangView;       // 领取优惠券弹框
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, assign) NSInteger     pageNum;

@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) SDCycleScrollView *bannerSV;
@property (nonatomic, strong) UIImageView   *headADView;
@property (nonatomic, strong) UICollectionView  *headCV;
@property (nonatomic, strong) UIView        *headTitleView;

@property (nonatomic, strong) UIView        *footView;
@property(nonatomic,strong) UIImageView *footADView;
@property (nonatomic, strong) UICollectionView  *footCV;

@property (nonatomic, copy) NSMutableArray  *bannersArr;
@property (nonatomic, copy) NSMutableArray  *plansArr;
@property (nonatomic, copy) NSMutableArray  *headsArr;
@property (nonatomic, copy) NSMutableArray  *footsArr;
@property (nonatomic, copy) NSDictionary  *gonggaoArr;
@property(nonatomic,strong) NSTimer* timer;// 定义定时器
@property(nonatomic,strong) UIView *viewAnima; //装 滚动视图的容器
@property(nonatomic,strong) UILabel *gonggaotitle; //公告title
@property(nonatomic,weak) UILabel *customLab; //滚动视图的文字显示
@property (nonatomic, strong) UIImageView   *btnXuanfu;
@property (nonatomic, copy) NSDictionary  *gongxiangDic;


@end

@implementation XYHomeControllerXin

- (NSDictionary *)gonggaoArr
{
    if (!_gonggaoArr) {
        _gonggaoArr = [[NSDictionary alloc] init];
    }
    return _gonggaoArr;
}

- (NSMutableArray *)bannersArr
{
    if (!_bannersArr) {
        _bannersArr = [NSMutableArray array];
    }
    return _bannersArr;
}

- (NSMutableArray *)plansArr
{
    if (!_plansArr) {
        _plansArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _plansArr;
}

- (NSMutableArray *)headsArr
{
    if (!_headsArr) {
        _headsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _headsArr;
}

- (NSMutableArray *)footsArr
{
    if (!_footsArr) {
        _footsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _footsArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
    
    [self IsUpdate];
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//
//    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    
    
    
  
    [self createUI];
    
    [self loadBannerData];
    
    //[self loaduserData];
    if ([TOKEN length]!=0) {
        [self loaduserData];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self IsUpdate];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GOtoWebClass:) name:@"MsgYuiSong" object:nil];//收到推送消息的通知
    self.navigationItem.title=@"零用贷";
    if (HEIGHT==736)
    {
        _font=15;
    }
    else
    {
        _font=myFontSize;
    }
    
    
    [self createUI];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.pageNum = 1;
   
   
    //[MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [self loadBannerData];
    [self loadData];
    [self loadPlansData];
    [self getGongxiangData];
    
    
    NSString *strTuiSongState=[[NSUserDefaults standardUserDefaults] stringForKey:@"TuiSongState"];
    if ([strTuiSongState isEqualToString:@"1"]) {
        [self GOtoWebClassDead];
        
    }
    //[self.view addSubview:self.navigationView];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"tanchuang"])//领取体验金弹窗
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tanchuang"];
        
            // 1.获得最上面的窗口
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            _tankuangView=[[UIView alloc] init];
            _tankuangView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
        

        _tankuangView.frame = window.bounds;
        
        _tankuangView.userInteractionEnabled=YES;
        
        
        UIImageView *imgtankuang=[[UIImageView alloc] initWithFrame:CGRectMake((kSCREENW-KWidth(263))/2, KHeight(126), KWidth(263), KHeight(359))];
        imgtankuang.userInteractionEnabled=YES;
        imgtankuang.image=[UIImage imageNamed:@"youhuiquantankuang-1"];
        
        UIButton *btnxx=[UIButton buttonWithType:UIButtonTypeCustom];
        
        btnxx.frame=CGRectMake(KWidth(263-40), 0, KWidth(40), KHeight(35));
        [btnxx addTarget:self action:@selector(dismissTankuang) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [imgtankuang addSubview:btnxx];
        UIButton *btnGozheche=[UIButton buttonWithType:UIButtonTypeCustom];
        
        btnGozheche.frame=CGRectMake(0, KHeight(359-45), KWidth(263), KHeight(45));
        [btnGozheche addTarget:self action:@selector(gotoAlertGetTiYanJing) forControlEvents:UIControlEventTouchUpInside];
        [imgtankuang addSubview:btnGozheche];
        [_tankuangView addSubview:imgtankuang];
            // 2.添加自己到窗口上
            [window addSubview:_tankuangView];
    }
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setImage:[UIImage imageNamed:@"right客服"] forState:UIControlStateNormal];
    
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [rightBtn addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
    
}



-(void)btnRightClick
{

    // 关于我们
    DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
    aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/help?type2=cs", APIPREFIX];
    //        aboutUsVC.title = _dataArray[indexPath.row];
    aboutUsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutUsVC animated:YES];
}






/**
 * 加载信息
 */
- (void)loaduserData {
    // 设置总资产的显示
    //    [self showAllAsset];
    //    [self setUpInformation];
    
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"accountId":@([DSYUser sharedDSYUser].accountId), @"sign":sign};
    
    NSLog(@"%@----%@-----%@-----%@",APPKEY, timestamp, DEVICEID, TOKEN);
    [[DSYAccount sharedDSYAccount] clean];
    //    [MBProgressHUD showMessage:@"正在获取用户信息..." toView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self.contentTableView.header endRefreshing];
    });
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/infoVersionThree", APIPREFIX] parameters:para success:^(id data) {
        //        [MBProgressHUD hideHUDForView:self.view];
        //        [self.contentTableView.header endRefreshing];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        NSInteger statusCode = [backData[@"code"] integerValue];
        
        if (statusCode == 200) {
            [[DSYAccount sharedDSYAccount] setValuesForKeysWithDictionary:backData[@"account"]];
            // 数据加载成功后设置相应的信息
            //            [self setUpInformation];
            [self createUI];
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
            //            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
        //        [self.contentTableView reloadData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //        [self.contentTableView.header endRefreshing];
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


-(void)dismissTankuang
{
  
    [_tankuangView removeFromSuperview];
}





//公告按钮
-(void)massageBTn
{
    NSLog(@"公告");
    //    self.tabBarController.tabBar.hidden = YES;
    
    
    GonggaoWebViewController *announce = [[GonggaoWebViewController alloc]init];
    announce.hidesBottomBarWhenPushed = YES;
    announce.urlid=self.gonggaoArr[@"id"];
    [self.navigationController pushViewController:announce animated:YES];
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
//    UIView   *vv=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, 25)];
//    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 3, 15)];
//    lbl.backgroundColor=[UIColor orangeColor];
//    [vv addSubview:lbl];
//    
//    
//    UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(lbl.maxX+2, 5,kSCREENW, 15)];
//    lbltitle.textAlignment=NSTextAlignmentLeft;
//    lbltitle.font=[UIFont systemFontOfSize:KHeight(15)];
//    lbltitle.textColor=[UIColor blackColor];
//    //lbltitle.backgroundColor=[UIColor orangeColor];
//    [vv addSubview:lbltitle];
//    
//    //    vv.backgroundColor=[UIColor redColor];
//    if (section==0) {
//        lbltitle.text=@"零定宝-份数标";
//    }
//    else if(section==1)
//    {
//        lbltitle.text=@"零定宝-1个月";
//    }
//    
//    return vv;
    
    
    
    
    UIImageView   *vv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(50))];
    

    if (section==0) {
        vv.image=[UIImage imageNamed:@"零定宝-份数标"];
    }
    else if(section==1)
    {
        vv.image=[UIImage imageNamed:@"零定宝-1月标"];
    }
    
    return vv;
    
}









- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc]init];
        _navigationView.frame = CGRectMake(0, 0, kSCREENW, kNavBarH);
        _navigationView.backgroundColor = [UIColor whiteColor];
        _navigationView.alpha = 0.0;
        
        //添加子控件
        [self setNavigationSubView];
    }
    return _navigationView;
}



// 注意:毛玻璃效果API是iOS8的,适配iOS8以下的请用其他方法
-(void)setNavigationSubView{
    
//    // 毛玻璃背景
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:_navigationView.bounds];
//    //bgImgView.image = [UIImage imageNamed:@"666"];
//    [_navigationView addSubview:bgImgView];
//    
//    /**  毛玻璃特效类型
//     *   UIBlurEffectStyleExtraLight,
//     *   UIBlurEffectStyleLight,
//     *   UIBlurEffectStyleDark
//     */
//    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    //  毛玻璃视图
//    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    //添加到要有毛玻璃特效的控件中
//    effectView.frame = bgImgView.bounds;
//    [bgImgView addSubview:effectView];
    //设置模糊透明度
//    effectView.alpha = 0.9f;
    
    //中间文本框
    UIView *centerTextView = [[UIView alloc]init];
    self.centerTextView = centerTextView;
    CGFloat centerTextViewX = 0;
    CGFloat centerTextViewY = 64;
    CGFloat centerTextViewW = 0;
    CGFloat centerTextViewH = 0;
    
    //文字大小
    NSString *title = @"理财";
    NSString *desc  = @"摇滚清心坊8套";
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGSize descSize = [desc sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
//    centerTextViewW = titleSize.width > descSize.width ? titleSize.width : descSize.width;
    centerTextViewW = titleSize.width > descSize.width ? descSize.width : titleSize.width;
    centerTextViewH = titleSize.height + descSize.height +10;
    centerTextViewX = (kSCREENW - centerTextViewW) / 2;
    centerTextView.frame = CGRectMake(centerTextViewX, centerTextViewY, centerTextViewW, centerTextViewH);
    
    //文字label
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.frame = CGRectMake(0,5, centerTextViewW, titleSize.height);
    
    UILabel *descLabel = [[UILabel alloc]init];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.text = desc;
    descLabel.font = [UIFont systemFontOfSize:11];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.frame = CGRectMake(0, titleSize.height + 5, centerTextViewW, descSize.height);
    
    [centerTextView addSubview:titleLabel];
   // [centerTextView addSubview:descLabel];
    [_navigationView addSubview:centerTextView];
}



#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 计算当前偏移位置
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat delta = offsetY - _lastOffsetY;
    CGFloat height = kHeardH - delta;
    if (height < kNavBarH) {
        height = kNavBarH;
    }
    
    CGFloat margin = kHeardH-kNavBarH+10;//10是header中Label的top
    
    if (delta>margin && delta<margin+39) {
        CGPoint center = self.centerTextView.center;
        CGFloat centerY = 64 - (delta-margin) + 10;
        centerY = (centerY > 42)?centerY:42;// 42=32+10
        center.y = centerY;
        self.centerTextView.center = center;
        self.centerTextView.alpha = (centerY < 42)?1.0:delta / kHeardH;
    }
    
    if (delta>margin+39) {
        CGPoint center = self.centerTextView.center;
        center.y = 42;
        self.centerTextView.center = center;
        self.centerTextView.alpha = 1.0;
    }
    if (delta<=margin) {
        self.centerTextView.alpha = 0;
    }
    if (delta<= 0) {
        CGPoint center = self.centerTextView.center;
        center.y = 64;
        self.centerTextView.center = center;
        self.centerTextView.alpha = 0.0;
    }
//    [_scaleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
    
    CGFloat alpha = delta / (kHeardH - kNavBarH);
    if (alpha >= 1.0) {
        alpha = 1.0;
    }
    self.navigationView.alpha = alpha;
}



//杀死状态加载的方法
-(void)GOtoWebClassDead
{
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"TuiSongState"];
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [array lastObject];
    
    NSString *documnetPath = [documents stringByAppendingPathComponent:@"dic.plist"];
    
    
    
    NSDictionary *note = [NSDictionary dictionaryWithContentsOfFile:documnetPath];
    
    NSLog(@"%@", documnetPath);
    
    
    NSString *strkeyvalue=note[@"key"];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"xiaohui" object:nil];//销毁之前的消息
    if ([strkeyvalue containsString:@"upush=1"]) {
        //跳转到优惠券
        // 优惠券
        MessageDSYAccountCouponController *couponVC = [[MessageDSYAccountCouponController alloc] init];
        
        couponVC.title=@"消息";
        
        UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:couponVC];
        
        
        
        
        [self presentViewController:nvc animated:YES completion:nil];
    }
    else if ([strkeyvalue containsString:@"upush=2"]) {
        
        
        
        self.tabBarController.selectedIndex =2;
    }
    else if ([strkeyvalue containsString:@"upush=3"]) {
        self.tabBarController.selectedIndex =0;
    }
    else if ([strkeyvalue containsString:@"upush=4"]) {
        self.tabBarController.selectedIndex =1;
    }
    else if ([strkeyvalue containsString:@"upush=5"]) {
        self.tabBarController.selectedIndex =3;
    }
    else
    {
        
        //跳转到web页面
        MessageWebController *messwebVC=[[MessageWebController alloc] init];
        messwebVC.dic=note;
        
        messwebVC.title=@"消息";
        
        UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:messwebVC];
        
        [self presentViewController:nvc animated:YES completion:nil];
        
    }
    
    
    
}







-(void)yourHandlingCode:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = [gestureRecognizer view];
    if (view.tag==0) {
        NSLog(@"安全保障");
        //http://27.115.115.86:9580/content/help/knowLyd
        DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
        aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/help/knowLyd", APIPREFIX];
        
        //        aboutUsVC.title = _dataArray[indexPath.row];
        aboutUsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
    else  if(view.tag==1)
    {
        NSLog(@"邀请有礼");
        // 邀请好友
        DSYAskFriendsViewController *friendVC = [[DSYAskFriendsViewController alloc] init];
        friendVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:friendVC animated:YES];
    }
    else  if(view.tag==2)
    {
       NSLog(@"平台数据");
        //http://27.115.115.86:9580/content/help/operateData
        DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
        aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/help/operateData", APIPREFIX];
        
        //        aboutUsVC.title = _dataArray[indexPath.row];
        aboutUsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
        
    }
}







-(void)GOtoWebClass:(NSNotification *)noti
{
    
    
    
    NSDictionary *note=[noti object];
    NSString *strkeyvalue=note[@"key"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"xiaohui" object:nil];//销毁之前的消息
    
    
    
    //    * app推送专用
    //    * upush=1跳转到优惠券页面
    //    * upush=2跳转到我的账户
    //    * upush=3跳转到首页
    //    * upush=4跳转到理财
    //    * upush=5跳转到更多
    if ([strkeyvalue containsString:@"upush=1"]) {
        //跳转到优惠券
        // 优惠券
        MessageDSYAccountCouponController *couponVC = [[MessageDSYAccountCouponController alloc] init];
        
        couponVC.title=@"消息";
        
        UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:couponVC];
        
        
        
        
        [self presentViewController:nvc animated:YES completion:nil];
    }
    else if ([strkeyvalue containsString:@"upush=2"]) {
        
        
        
        self.tabBarController.selectedIndex =2;
    }
    else if ([strkeyvalue containsString:@"upush=3"]) {
        self.tabBarController.selectedIndex =0;
    }
    else if ([strkeyvalue containsString:@"upush=4"]) {
        self.tabBarController.selectedIndex =1;
    }
    else if ([strkeyvalue containsString:@"upush=5"]) {
        self.tabBarController.selectedIndex =3;
    }
    else
    {
        
        //跳转到web页面
        MessageWebController *messwebVC=[[MessageWebController alloc] init];
        messwebVC.dic=note;
        
        messwebVC.title=@"消息";
        
        UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:messwebVC];
        
        [self presentViewController:nvc animated:YES completion:nil];
        
    }
    
    
    
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
        //imposedUpdate/*状态:0最新版本，2强制，1非强制*/
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


- (void)configNavigationBar{
    //左边返回按钮
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 20, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"special_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //右边分享按钮
    UIButton *shartBtn = [[UIButton alloc]init];
    shartBtn.frame = CGRectMake(kSCREENW-44, 20, 44, 44);
    [shartBtn setImage:[UIImage imageNamed:@"special_share"] forState:UIControlStateNormal];
    [shartBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [self.view addSubview:shartBtn];
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


-(void)goLingYongDai
{

    DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
    aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/help/knowLyd", APIPREFIX];
    
    //        aboutUsVC.title = _dataArray[indexPath.row];
    aboutUsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutUsVC animated:YES];

}



- (void)createUI
{
    
 
    if ([TOKEN length] == 0) {//未登录状态
            
            self.headView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
//        if(!self.headView){
//            self.headView = [[UIView alloc] init];
//        }
           self.headView = [[UIView alloc] init];
            self.headView.frame= CGRectMake(0, 0, kSCREENW, KHeight(312)+KHeight(125));
            UIImageView *imghead=[[UIImageView alloc] init];
            imghead.frame=CGRectMake(0, 0, kSCREENW, KHeight(312));
            imghead.image=[UIImage imageNamed:@"未登录-首页长条图"];
        
        
        
        
        UITapGestureRecognizer *tapLingYongDai = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goLingYongDai)];
        // 允许用户交互
        imghead.userInteractionEnabled = YES;
        
        [imghead addGestureRecognizer:tapLingYongDai];
        
        
        
        
            UIButton *toubiaoStare=[UIButton buttonWithType:UIButtonTypeCustom];
            toubiaoStare.frame=CGRectMake(0, imghead.maxY, kSCREENW, KHeight(125));
            //toubiaoStare.image=[UIImage imageNamed:@"新手专享"];
            [toubiaoStare addTarget:self action:@selector(gotoGetTiYanJing) forControlEvents:UIControlEventTouchUpInside];
            [toubiaoStare setBackgroundImage:[UIImage imageNamed:@"新手专享1"] forState:UIControlStateNormal];
            
            
            
            [self.headView addSubview:toubiaoStare];
            [self.headView addSubview:imghead];
            

            
            
        } else {
            
            
            

            //[self IsTouGuoData];
            
            
            if ([DSYAccount sharedDSYAccount].canInvestNew==1) {//没有投过体验标
                
                self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(420))];
                self.headView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
//                if(!self.headView){
//                    self.headView = [[UIView alloc] init];
//                }

                self.headView.frame= CGRectMake(0, 0, kSCREENW, KHeight(312)+KHeight(125));
                if (!self.bannerSV) {
                    self.bannerSV = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(188))];
                    self.bannerSV.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
                }
                //self.bannerSV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
                self.bannerSV.showPageControl=NO;
                self.bannerSV.autoScrollTimeInterval = 3;
                //    self.bannerSV.imageURLStringsGroup = tempArray;
                //self.bannerSV.placeholderImage = [UIImage imageNamed:@"banner"];
//                self.bannerSV.pageDotColor = [UIColor whiteColor];
//                self.bannerSV.currentPageDotColor = ORANGECOLOR;
                
                
                self.bannerSV.delegate = self;
                [self.headView addSubview:self.bannerSV];
                
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.bannerSV.maxY, kSCREENW, KHeight(124))];
                view.backgroundColor=[UIColor whiteColor];
                
                
                
                
                for (int i=0; i<3; i++) {
                    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(i*kSCREENW/3, 0, kSCREENW/3, KHeight(124))];
                    view1.tag=i;

                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yourHandlingCode:)];
                    
                    [view1 addGestureRecognizer:singleTap];
                    [singleTap view].tag=i;
                    
                    
                    
                    view.backgroundColor=[UIColor whiteColor];
                    UIView *view11 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREENW/3, 3*view1.size.height/4)];
                    
                    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(KWidth(23), KHeight(16), KWidth(80), KHeight(68))];
                    
                    
                    
                    if (i==0) {
                        img1.image=[UIImage imageNamed:@"风控"];
                    }
                    else if (i==1)
                    {
                        
                        img1.image=[UIImage imageNamed:@"邀请"];
                    }else
                    {
                        
                        img1.image=[UIImage imageNamed:@"平台数据"];
                    }
                    UILabel  *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, view11.maxY, view11.size.width, view1.size.height-view11.size.height)];
                    
                    if (i==0) {
                        lbl.text = @"安全保障";
                    }
                    else if (i==1)
                    {
                        
                        lbl.text = @"邀请有礼";
                    }else
                    {
                        
                        lbl.text = @"平台数据";
                        
                    }
                    lbl.font = [UIFont systemFontOfSize:13];
                    lbl.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1/1.0];
                    lbl.textAlignment=NSTextAlignmentCenter;
                    [view1 addSubview:lbl];
                    [view11 addSubview:img1];
                    [view1 addSubview:view11];
                    [view addSubview:view1];
                    
                }
                UIButton *toubiaoStare=[UIButton buttonWithType:UIButtonTypeCustom];
                toubiaoStare.frame=CGRectMake(0, view.maxY, kSCREENW, KHeight(125));
                //toubiaoStare.image=[UIImage imageNamed:@"新手专享"];
                [toubiaoStare addTarget:self action:@selector(gotoTiYanBiaoDetail) forControlEvents:UIControlEventTouchUpInside];
                [toubiaoStare setBackgroundImage:[UIImage imageNamed:@"30000元体验金使用2"] forState:UIControlStateNormal];

                [self.headView addSubview:toubiaoStare];
                [self.headView addSubview:view];


            }
            else if([DSYAccount sharedDSYAccount].canInvestPlanNew==1)//没有投过新手专享标
            {
                
                
                self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(420))];
                self.headView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
//                if(!self.headView){
//                    self.headView = [[UIView alloc] init];
//                }
                self.headView.frame=CGRectMake(0, 0, kSCREENW, KHeight(312)+KHeight(125));
                if (!self.bannerSV) {
                    self.bannerSV = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(188))];
                    self.bannerSV.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
                }
                self.bannerSV.showPageControl=NO;
                self.bannerSV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
                self.bannerSV.autoScrollTimeInterval = 3;
                //    self.bannerSV.imageURLStringsGroup = tempArray;
                //self.bannerSV.placeholderImage = [UIImage imageNamed:@"banner"];
                self.bannerSV.pageDotColor = [UIColor whiteColor];
                self.bannerSV.currentPageDotColor = ORANGECOLOR;
                
                
                self.bannerSV.delegate = self;
                [self.headView addSubview:self.bannerSV];
                
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.bannerSV.maxY, kSCREENW, KHeight(124))];
                view.backgroundColor=[UIColor whiteColor];
                
                
                
                
                for (int i=0; i<3; i++) {
                    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(i*kSCREENW/3, 0, kSCREENW/3, KHeight(124))];
                    
                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yourHandlingCode:)];
                    
                    [view1 addGestureRecognizer:singleTap];
                    [singleTap view].tag=i;
                    
                    view.backgroundColor=[UIColor whiteColor];
                    UIView *view11 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREENW/3, 3*view1.size.height/4)];
                    
                    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(KWidth(23), KHeight(16), KWidth(80), KHeight(68))];
                    
                    
                    
                    if (i==0) {
                        img1.image=[UIImage imageNamed:@"风控"];
                    }
                    else if (i==1)
                    {
                        
                        img1.image=[UIImage imageNamed:@"邀请"];
                    }else
                    {
                        
                        img1.image=[UIImage imageNamed:@"平台数据"];
                    }
                    UILabel  *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, view11.maxY, view11.size.width, view1.size.height-view11.size.height)];
                    
                    if (i==0) {
                        lbl.text = @"安全保障";
                    }
                    else if (i==1)
                    {
                        
                        lbl.text = @"邀请有礼";
                    }else
                    {
                        
                        lbl.text = @"平台数据";
                        
                    }
                    lbl.font = [UIFont systemFontOfSize:13];
                    lbl.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1/1.0];
                    lbl.textAlignment=NSTextAlignmentCenter;
                    [view1 addSubview:lbl];
                    [view11 addSubview:img1];
                    [view1 addSubview:view11];
                    [view addSubview:view1];
                    
                }
                UIButton *toubiaoStare=[UIButton buttonWithType:UIButtonTypeCustom];
                toubiaoStare.frame=CGRectMake(0, view.maxY, kSCREENW, KHeight(125));
                //toubiaoStare.image=[UIImage imageNamed:@"新手专享"];
                [toubiaoStare addTarget:self action:@selector(GotoXinShouBiaoDetail) forControlEvents:UIControlEventTouchUpInside];
                [toubiaoStare setBackgroundImage:[UIImage imageNamed:@"15%超高利息3"] forState:UIControlStateNormal];
                
                [self.headView addSubview:toubiaoStare];
                [self.headView addSubview:view];
                
                
            }
            else//体验标  新手专享标都投过应该隐藏头部
            {
                self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(420))];
                self.headView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
//                if(!self.headView){
//                    self.headView = [[UIView alloc] init];
//                }
                self.headView.frame = CGRectMake(0, 0, kSCREENW, KHeight(312));
                if (!self.bannerSV) {
                    self.bannerSV = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(188))];
                    self.bannerSV.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
                }
                self.bannerSV.showPageControl=NO;
//                self.bannerSV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
                self.bannerSV.autoScrollTimeInterval = 3;
                //    self.bannerSV.imageURLStringsGroup = tempArray;
                //self.bannerSV.placeholderImage = [UIImage imageNamed:@"banner"];
//                self.bannerSV.pageDotColor = [UIColor whiteColor];
//                self.bannerSV.currentPageDotColor = ORANGECOLOR;
               
                
                self.bannerSV.delegate = self;
                [self.headView addSubview:self.bannerSV];
                
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.bannerSV.maxY, kSCREENW, KHeight(124))];
                view.backgroundColor=[UIColor whiteColor];
                
                
                
                
                for (int i=0; i<3; i++) {
                    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(i*kSCREENW/3, 0, kSCREENW/3, KHeight(124))];
                    view.backgroundColor=[UIColor whiteColor];
                    UIView *view11 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREENW/3, 3*view1.size.height/4)];
                    
                    
                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yourHandlingCode:)];
                    
                    
                    [view1 addGestureRecognizer:singleTap];
                    [singleTap view].tag=i;
                    
                    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(KWidth(23), KHeight(16), KWidth(80), KHeight(68))];
                    
                    
                    
                    if (i==0) {
                        img1.image=[UIImage imageNamed:@"风控"];
                    }
                    else if (i==1)
                    {
                        
                        img1.image=[UIImage imageNamed:@"邀请"];
                    }else
                    {
                        
                        img1.image=[UIImage imageNamed:@"平台数据"];
                    }
                    UILabel  *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, view11.maxY, view11.size.width, view1.size.height-view11.size.height)];
                    
                    if (i==0) {
                        lbl.text = @"安全保障";
                    }
                    else if (i==1)
                    {
                        
                        lbl.text = @"邀请有礼";
                    }else
                    {
                        
                        lbl.text = @"平台数据";
                        
                    }
                    lbl.font = [UIFont systemFontOfSize:13];
                    lbl.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1/1.0];
                    lbl.textAlignment=NSTextAlignmentCenter;
                    [view1 addSubview:lbl];
                    [view11 addSubview:img1];
                    [view1 addSubview:view11];
                    [view addSubview:view1];
                    
                }
                
                
                
                [self.headView addSubview:view];

            
            }

        }
    
    
    
    

    
    
    
    
    
    
    
    
    
    //    self.headADView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bannerSV.maxY + KHeight(10)+ KHeight(20), kSCREENW, KHeight(80))];
//    self.headADView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bannerSV.maxY + KHeight(10)+ KHeight(20), kSCREENW, 0)];
//    //self.headADView.image = [UIImage imageNamed:@"headAD"];
//    [self.headView addSubview:self.headADView];
    
    UICollectionViewFlowLayout *headLayout = [[UICollectionViewFlowLayout alloc] init];
    headLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    headLayout.minimumInteritemSpacing = KWidth(10);
    headLayout.minimumLineSpacing = KWidth(10);
    //CGFloat itemW = KWidth(550/2);
    
    CGFloat itemW = (kSCREENW-KWidth(10))/2;
    
    
    CGFloat itemH = KHeight(101);
    headLayout.itemSize = CGSizeMake(itemW , itemH);
    
    UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, KHeight(35) - 1, kSCREENW, 1)];
    bottomline.backgroundColor = [UIColor colorWithRed:0.88 green:0.87 blue:0.89 alpha:1.00];
    [self.headTitleView addSubview:bottomline];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW,KHeight(52)+KHeight(10))];
    
    self.footADView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KHeight(10), kSCREENW,KHeight(52))];
    
    self.footADView.image=[UIImage imageNamed:@"RectangleBg"];
    self.footView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapShouqing = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goShouqing)];

    
    [self.footView addGestureRecognizer:tapShouqing];
//    self.footADView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KHeight(10), kSCREENW, 0)];
//    self.footADView.image = [UIImage imageNamed:@"footAD"];
    [self.footView addSubview:self.footADView];
    
//    UICollectionViewFlowLayout *footLayout = [[UICollectionViewFlowLayout alloc] init];
//    footLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    footLayout.minimumInteritemSpacing = KWidth(10);
//    footLayout.minimumLineSpacing = KWidth(10);
//    CGFloat footitemW = KWidth(550/2);
//    CGFloat footitemH = KHeight(80);
//    footLayout.itemSize = CGSizeMake(footitemW , footitemH);
    
//    self.footCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.footADView.maxY, kSCREENW, KHeight(101)) collectionViewLayout:footLayout];
//    self.footCV.delegate = self;
//    self.footCV.dataSource = self;
//    self.footCV.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
//    self.footCV.showsHorizontalScrollIndicator = NO;
//    [self.footCV registerClass:[XYBidCell class] forCellWithReuseIdentifier:[XYBidCell identifier]];
//    [self.footView addSubview:self.footCV];
    if(!_tableView){
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH - 49-64) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    self.tableView.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        //[self loadData];
        
        [self loadData];
        [self loadBannerData];
        [self loadPlansData];
        [self getGongxiangData];
    }];

    [self.view addSubview:self.tableView];
    
//    self.btnXuanfu=[[UIImageView alloc] init];
//    self.btnXuanfu.frame=CGRectMake(ScreenWidth-20-80, ScreenHeight-49-80-20, 80, 80);
//    //self.btnXuanfu.image=[UIImage imageNamed:@"xuanfuBg"];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotogongxianghuodong)];
//    // 允许用户交互
//    self.btnXuanfu.userInteractionEnabled = YES;
//    
//    [self.btnXuanfu addGestureRecognizer:tap];
//    [self.view addSubview:self.btnXuanfu];
//    [self.view addSubview:self.navigationView];
}



//到新手专享标详情页
-(void)GotoXinShouBiaoDetail
{
    XYSanBidModel *ttttt= self.headsArr[1];
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"bidType":ttttt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"bidType":ttttt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    // 开始请求数据
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,ttttt.bidId] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        id backData = LYDJSONSerialization(data);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            
//            NewBidDetailController *detailVC = [[NewBidDetailController alloc] init];
//            detailVC.model =  [XYPlanModel baseModelWithDic:backData[@"planModel"]];
//            detailVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:detailVC animated:YES];
            
            
            XYPlanModel *tt=[XYPlanModel baseModelWithDic:backData[@"planModel"]];
            fenshubiaoDetailViewController *fenshubiaoDetail=[[fenshubiaoDetailViewController alloc] init];
            fenshubiaoDetail.chanshu=tt;
            fenshubiaoDetail.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:fenshubiaoDetail animated:YES];
            
            
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            //self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
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




//弹框注册领取体验金
-(void)gotoAlertGetTiYanJing
{
    
    [self  dismissTankuang];
    TiYanJingLoginViewController *TiYanJingLogin=[[TiYanJingLoginViewController alloc] init];
    TiYanJingLogin.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:TiYanJingLogin animated:YES];
    
}




//注册领取体验金
-(void)gotoGetTiYanJing
{


    TiYanJingLoginViewController *TiYanJingLogin=[[TiYanJingLoginViewController alloc] init];
    TiYanJingLogin.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:TiYanJingLogin animated:YES];

}


-(void)gotoTiYanBiaoDetail
{
  
    //XYSanBidModel *ttttt= self.headsArr[indexPath.row];
    // 新手体验标
    TiYanBiaoDetailViewController *TiYanBiaoDetail = [[TiYanBiaoDetailViewController alloc] init];
    TiYanBiaoDetail.model = self.headsArr[0];
    TiYanBiaoDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TiYanBiaoDetail animated:YES];
    
    
    
//    TiYanBiaoDetailViewController *TiYanBiaoDetail=[[TiYanBiaoDetailViewController alloc] init];
//    TiYanBiaoDetail.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:TiYanBiaoDetail animated:YES];

}

-(void)goShouqing
{


    
    
    YiShouqingViewController *vc=[[YiShouqingViewController alloc] init];
    //        aboutUsVC.title = _dataArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}








-(void)getGongxiangData
{
    
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign};
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/content/returnAlertValue",APIPREFIX] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        //showIs   1显示  0不显示
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            
            self.gongxiangDic=backData;
            
            NSString *strImgurl=_gongxiangDic[@"imgStrUrl"];
            NSURL *url = [NSURL URLWithString:strImgurl];
            UIImage *img = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
            
            
            
            _btnXuanfu.image=img;
            
            if ([_gongxiangDic[@"showIs"] integerValue]==1) {
                
                _btnXuanfu.hidden=NO;
            }
            else
            {
                
                _btnXuanfu.hidden=YES;
            }
            
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        //[self errorDataHandleWithOperation:operation];
    }];
    
}



-(void)gotogongxianghuodong
{
    
    FenxiaoHuoDongViewController *vc=[[FenxiaoHuoDongViewController alloc] init];
    vc.gongxiangDic=_gongxiangDic;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


//公告跑马灯
- (void) changePos
{
    CGPoint curPos = self.customLab.center;
    //    NSLog(@"%f",self.customLab.center.x);
    // 当curPos的x坐标已经超过了屏幕的宽度
    if(curPos.x <  -100 )
    {
        CGFloat jianJu = self.customLab.frame.size.width/2;
        // 控制蝴蝶再次从屏幕左侧开始移动
        self.customLab.center = CGPointMake(self.viewAnima.frame.size.width + jianJu, 10*hy);
        
    }
    else
    {
        // 通过修改iv的center属性来改变iv控件的位置
        self.customLab.center = CGPointMake(curPos.x - 10, 10*hy);
    }
    //其实蝴蝶的整个移动都是————靠iv.center来去设置的
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}






#pragma mark - tableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.plansArr.count>0) {
        if (section==0) {//前4条为零定宝
            return 4;
        }
        else
        {
            
            return self.plansArr.count-4;//出去4条零定宝和1条新手专享
        }
        
    }
    else
    {
        return 0;
    }
    
    
    //return self.plansArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.section==0) {
        //份数标
        //bidType  1，零定宝    2，新手专享标
        XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
        if (indexPath.row==0) {
            XYHomePlanTXCellFirstReMen *cell = [XYHomePlanTXCellFirstReMen cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.plansArr[indexPath.row];
            cell.Qianggoudelegate=self;
            return cell;
        }
        else
        {
            XYHomePlanTXCell *cell = [XYHomePlanTXCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.plansArr[indexPath.row];
            cell.delegate=self;
            return cell;
            
        }

        
    }
    else
    {
        //1月标
        if (indexPath.row==0) {
            XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+4]);
            //        if (tt.bidType.intValue==1) {//零定宝
            XYHomeLDBCellFirst *cell = [XYHomeLDBCellFirst cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.plansArr[indexPath.row+4];
            cell.delete=self;
            return cell;
        }
        else
        {
            XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+4]);
            //        if (tt.bidType.intValue==1) {//零定宝
            
            XYHomeLDBCell *cell = [XYHomeLDBCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.plansArr[indexPath.row+4];
            cell.delegate=self;
            return cell;
            
        }
        

        
        
    }
    
    
    
    
}

//份数标抢购按钮的代理方法
-(void)didClickButton:(UIButton *)button
{
    
    if ([TOKEN length]==0) {
        [self pushToLoginController];
    }
    else
    {
        XYHomePlanTXCellFirstReMen  *cell=(XYHomePlanTXCellFirstReMen *)[[button superview] superview];
        
        [self requestDetail:cell.model];
    }

}



-(void)didClickButtonXYHomePlanTXCell:(UIButton *)button
{
    if ([TOKEN length]==0) {
        [self pushToLoginController];
    }
    else
    {
        XYHomePlanTXCell  *cell=(XYHomePlanTXCell *)[[button superview] superview];
        
        [self requestDetail:cell.model];
    }

}




//一月标抢购按钮的代理方法
-(void)didClickButtonYiYueBiao:(UIButton *)button
{

    if ([TOKEN length]==0) {
        [self pushToLoginController];
    }
    else
    {
        XYHomeLDBCellFirst  *cell=(XYHomeLDBCellFirst *)[[button superview] superview];
        
        //[self requestDetail:cell.model];
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"bidType":cell.model.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
        // 生成签名认证
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"bidType":cell.model.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
        
        // 开始请求数据
        [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,cell.model.planId] parameters:para success:^(id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            id backData = LYDJSONSerialization(data);
            
            if ([[backData valueForKey:@"code"] integerValue] == 200) {
                YiYueBiaoGouMaiViewController *detailVC = [[YiYueBiaoGouMaiViewController alloc] init];
                detailVC.model =  [XYPlanModel baseModelWithDic:backData[@"planModel"]];
                detailVC.myBalance=backData[@"availableBalance"];
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
                [DSYUtils showSuccessForStatus_600_ForViewController:self];
            } else {
                
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
                //self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
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
            }
            else if (errorData==500) {
                [DSYUtils showSuccessForStatus_600_ForViewController:self];
            }
            
            else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
            }
        }];
    }

}



-(void)didClickButtonXYHomeLDBCell:(UIButton *)button
{

    if ([TOKEN length]==0) {
        [self pushToLoginController];
    }
    else
    {
        XYHomeLDBCell  *cell=(XYHomeLDBCell *)[[button superview] superview];
        
        //[self requestDetail:cell.model];
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"bidType":cell.model.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
        // 生成签名认证
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"bidType":cell.model.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
        
        // 开始请求数据
        [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,cell.model.planId] parameters:para success:^(id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            id backData = LYDJSONSerialization(data);
            
            if ([[backData valueForKey:@"code"] integerValue] == 200) {
                YiYueBiaoGouMaiViewController *detailVC = [[YiYueBiaoGouMaiViewController alloc] init];
                detailVC.model =  [XYPlanModel baseModelWithDic:backData[@"planModel"]];
                detailVC.myBalance=backData[@"availableBalance"];
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
                [DSYUtils showSuccessForStatus_600_ForViewController:self];
            } else {
                
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
                //self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
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
            }
            else if (errorData==500) {
                [DSYUtils showSuccessForStatus_600_ForViewController:self];
            }
            
            else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
            }
        }];
    }


}



-(void)requestDetail:(XYPlanModel *)model
{
    
    
    
    
    
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"bidType":model.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"bidType":model.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    // 开始请求数据
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,model.planId] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        id backData = LYDJSONSerialization(data);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            BuyFenshuMarkVC *buy=[[BuyFenshuMarkVC alloc]init];
            buy.myBalance=backData[@"availableBalance"];
            buy.model=[XYPlanModel baseModelWithDic:backData[@"planModel"]];
            buy.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:buy animated:YES];
            //            LYDPlanDetailController *detailVC = [[LYDPlanDetailController alloc] init];
            //            detailVC.model =  [XYPlanModel baseModelWithDic:backData[@"planModel"]];
            //            detailVC.hidesBottomBarWhenPushed = YES;
            //            [self.navigationController pushViewController:detailVC animated:YES];
            
            
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            //self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
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
        }
    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    return [XYHomePlanCell cellHeight];
    
    XYPlanModel *tt;
    if (indexPath.section==0) {
        tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
        
        
        
        
        if (indexPath.row==0) {

            
            return [XYHomePlanTXCellFirstReMen cellHeight];
        }
        else
        {

            
            return [XYHomePlanTXCell cellHeight];
            
        }
        
        
    }
    else
    {
        tt=(XYPlanModel *)(self.plansArr[indexPath.row+4]);
        
        
        if (indexPath.row==0) {

            
            
            return [XYHomeLDBCellFirst cellHeight];
        }
        else
        {

          return  [XYHomeLDBCell cellHeight];
            
        }
        
        
        
        
       
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KHeight(50);
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - collectionView delegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.headCV) {
        return self.headsArr.count;
    } else {
        return self.footsArr.count;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger dd=indexPath.section;
    NSInteger tt=indexPath.row;
    if (collectionView == self.headCV) {
        if (tt==0) {
            //新手体验
            XYBidCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[XYBidCell identifier] forIndexPath:indexPath];
            cell.model = self.headsArr[indexPath.item];
            return cell;
            
        }
        else
        {    //新手专享
            XYBidZhuanXiangCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[XYBidZhuanXiangCell identifier] forIndexPath:indexPath];
            cell.model = self.headsArr[indexPath.item];
            return cell;
        }
        
    } else {
        XYBidCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[XYBidCell identifier] forIndexPath:indexPath];
        cell.model = self.footsArr[indexPath.item];
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([TOKEN length] == 0) {
        [self pushToLoginController];
    }
    else
    {
        
        
        XYSanBidModel *ttttt= self.headsArr[indexPath.row];
        
        //XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
        //bidType  1，零定宝    2，新手专享标
        if (ttttt.bidType.intValue==2) {
            //planId   bidType
            
            
            NSString *timestamp = [LYDTool createTimeStamp];
            NSDictionary *secretDict = @{@"bidType":ttttt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
            // 生成签名认证
            NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
            NSDictionary *para = @{@"bidType":ttttt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
            
            // 开始请求数据
            [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,ttttt.bidId] parameters:para success:^(id data) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                id backData = LYDJSONSerialization(data);
                
                if ([[backData valueForKey:@"code"] integerValue] == 200) {
                    
                    NewBidDetailController *detailVC = [[NewBidDetailController alloc] init];
                    detailVC.model =  [XYPlanModel baseModelWithDic:backData[@"planModel"]];
                    detailVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:detailVC animated:YES];
                    
                    
                } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
                    [DSYUtils showSuccessForStatus_600_ForViewController:self];
                } else {
                    
                    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
                    [self.view.window addSubview:errorHud];
                    //self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
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
        
        else
        {
            
            
            // 新手体验标
            XYExperienceController *experienceVC = [[XYExperienceController alloc] init];
            experienceVC.model = self.headsArr[indexPath.row];
            experienceVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:experienceVC animated:YES];
        }
        
        
        
        //    if (indexPath.row==0) {
        //        // 新手体验标
        //        XYExperienceController *experienceVC = [[XYExperienceController alloc] init];
        //        experienceVC.model = self.headsArr[indexPath.row];
        //        experienceVC.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:experienceVC animated:YES];
        //    }
        //    else
        //    {
        //
        //
        //    }
        
        
    }
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(KHeight(0), KWidth(0), KHeight(0), KWidth(0));
}

#pragma mark - 点击轮播回调
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    DSYBannerDetailViewController *bannerVC = [[DSYBannerDetailViewController alloc] init];
    bannerVC.banner = self.bannersArr[index];
    bannerVC.hidesBottomBarWhenPushed = YES;
    
    if (![self isBlankString:bannerVC.banner.linkUrl]) {
        
        [self.navigationController pushViewController:bannerVC animated:YES];
    }
    
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


- (void)refreshHeadView
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (XYBannerModel *model in _bannersArr) {
        //NSString *urlString = [model.imageUrl hasPrefix:@"http://"] ? model.imageUrl : [NSString stringWithFormat:@"%@%@",APIPREFIX,model.imageUrl];
        //        NSString *urlString = [model.imageUrl hasPrefix:@"http://"] ? model.imageUrl : [NSString stringWithFormat:@"%@%@",APIPREFIX,model.imageUrl];
        [tempArray addObject:model.imageUrl];
    }
    
    //    NSString* strtitle = @"公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh";
    NSString *strtitle=_gonggaoArr[@"title"];
    self.gonggaotitle.frame=CGRectMake(0, 0, strtitle.length*15*hx, 20*hy);
    self.bannerSV.imageURLStringsGroup = tempArray;
    self.gonggaotitle.text=strtitle;
    
}



#pragma mark - 最新数据请求方式
- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@/home/detailsNew", APIPREFIX];
    //    NSString *url = @"http://lydapi.coralcode.cn/help/about";
    [MBProgressHUD showMessage:@"正在加载首页..." toView:self.view];
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        [LYDTool sendGetWithUrl:url parameters:[self getMyPara] success:^(id data) {
            id backData = LYDJSONSerialization(data);
            [self.tableView.header endRefreshing];
            NSLog(@"%@", backData);
            [self successDealWithData:backData];
        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
            [self.tableView.header endRefreshing];
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络异常!" toView:self.view];
            [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
            }];
        }];
    }];
    
}




- (NSDictionary *)getMyPara {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        // 顶部轮播图
        //        self.bannersArr = [XYBannerModel baseModelByArr:data[@"bannerModelList"]];
        //        [self refreshHeadView];
        // 新手专区
        self.headsArr = [XYSanBidModel baseModelByArr:data[@"productNewListModelList"]];
        [self.headCV reloadData];
        [self.headCV layoutIfNeeded];
        // 理财计划
        //        self.plansArr = [XYPlanModel baseModelByArr:data[@"planModelList"]];
        //        [self.tableView reloadData];
        //        [self.tableView layoutIfNeeded];
        // 散标
        //        self.footsArr = [XYSanBidModel baseModelByArr:data[@"bidPersonList"]];
        //        [self.footCV reloadData];
        
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
    }
    
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}




#pragma mark - 原来的老旧的方法(现在不适用)
- (void)loadBannerData
{
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"location":@"1"};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"location":@"1",@"sign":sign};
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/content/banners",APIPREFIX] parameters:para success:^(id data) {
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        [self.bannersArr removeAllObjects];
        
        for (NSDictionary *dict in backData) {
            XYBannerModel *model = [[XYBannerModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.bannersArr addObject:model];
        }
        
        [self refreshHeadView];//刷新轮播图
        
        //[self loadHeadsData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        [MBProgressHUD hideHUDForView:self.view];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    }];
    
}


- (void)loadPlansData
{
    //     @ApiParam(value = "满标状态：1显示、2不显示") @RequestParam() final Integer loneType,
    //
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:15]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:15]};
    
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plansNewThree",APIPREFIX] parameters:para success:^(id data) {
        
        
        
        if (self.pageNum == 1) {
            [self.plansArr removeAllObjects];
        }
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData allKeys] count] == 0) {
            [self.tableView.footer noticeNoMoreData];
            [self.tableView.header endRefreshing];
        } else {
            for (NSDictionary *dict in [backData valueForKey:@"planList"]) {
                XYPlanModel *model = [[XYPlanModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.plansArr addObject:model];
            }
            
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            
            if (self.plansArr.count < 10) {
                [self.tableView.footer noticeNoMoreData];
            }
            
            [self.tableView reloadData];
            
            
            
            if (self.pageNum == 1) {
                // [self loadFootsData];
            }
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
    
}











- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.section==0) {//份数标
        XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
        fenshubiaoDetailViewController *fenshubiaoDetail=[[fenshubiaoDetailViewController alloc] init];
        fenshubiaoDetail.chanshu=tt;
        fenshubiaoDetail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:fenshubiaoDetail animated:YES];
    }
    else//一月标
    {
        XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+4]);
        YiYueBiaoDetailViewController *YiYueBiaoDetail=[[YiYueBiaoDetailViewController alloc] init];
        YiYueBiaoDetail.hidesBottomBarWhenPushed=YES;
        YiYueBiaoDetail.chanshu=tt;
        [self.navigationController pushViewController:YiYueBiaoDetail animated:YES];
    
    }
    
    
    
}


- (void)loadFootsData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:10],@"bidsType":@"4"};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:10],@"bidsType":@"4",@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/bids",APIPREFIX] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            
            [self.footsArr removeAllObjects];
            
            for (NSDictionary *dict in [backData valueForKey:@"bidsList"]) {
                XYSanBidModel *model = [[XYSanBidModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.footsArr addObject:model];
            }
            [self.footCV reloadData];
            
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        id response = LYDJSONSerialization(operation.responseObject);
        NSLog(@"%@",response);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
}

@end
