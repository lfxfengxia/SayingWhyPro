//
//  XYHomeController.m
//  LYDApp
//
//  Created by dookay_73 on 16/10/31.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYHomeController.h"
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

@interface XYHomeController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,UIAlertViewDelegate>

{


CGFloat _font;


}


@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, assign) NSInteger     pageNum;

@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) SDCycleScrollView *bannerSV;
@property (nonatomic, strong) UIImageView   *headADView;
@property (nonatomic, strong) UICollectionView  *headCV;
@property (nonatomic, strong) UIView        *headTitleView;

@property (nonatomic, strong) UIView        *footView;
@property (nonatomic, strong) UIImageView   *footADView;
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

@implementation XYHomeController



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
        _bannersArr = [NSMutableArray arrayWithCapacity:0];
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
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self IsUpdate];
    
    
    
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GOtoWebClass:) name:@"MsgYuiSong" object:nil];//收到推送消息的通知
    
    if (HEIGHT==736)
    {
        _font=15;
    }
    else
    {
        _font=myFontSize;
    }
   
    

    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.pageNum = 1;
    
    [self createUI];
//     [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [self loadBannerData];
    [self GetGonggaiData];
    [self loadData]; 
    [self loadPlansData];
    [self getGongxiangData];

//[self loadproductNewListModelList];
//    [self loadPlansData];
//    [self loadBannerData];
//    [self loadHeadsData];
    
//    NSString *url = @"http://lyd-invest-api.doolab.cn/help/about";
//    [LYDTool sendGetWithUrl:url parameters:nil success:^(id data) {
//        NSLog(@"%@", LYDJSONSerialization(data));
//        
//    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//        NSLog(@"失败");
//    }];
    
    NSString *strTuiSongState=[[NSUserDefaults standardUserDefaults] stringForKey:@"TuiSongState"];
    if ([strTuiSongState isEqualToString:@"1"]) {
        [self GOtoWebClassDead];
        
    }
    
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

    UIView   *vv=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, 25)];
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 3, 15)];
    lbl.backgroundColor=[UIColor orangeColor];
    [vv addSubview:lbl];
    
    
    UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(lbl.maxX+2, 5,kSCREENW, 15)];
    lbltitle.textAlignment=NSTextAlignmentLeft;
    lbltitle.font=[UIFont systemFontOfSize:KHeight(15)];
    lbltitle.textColor=[UIColor blackColor];
    //lbltitle.backgroundColor=[UIColor orangeColor];
    [vv addSubview:lbltitle];
    
//    vv.backgroundColor=[UIColor redColor];
    if (section==0) {
        lbltitle.text=@"零定宝-份数标";
    }
    else if(section==1)
    {
        lbltitle.text=@"零定宝-1个月";
    }

    return vv;

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






- (void)createUI
{
    
    //self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(420))];
    self.headView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(440-35-80))];
    self.bannerSV = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(390 / 2))];
    self.bannerSV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerSV.autoScrollTimeInterval = 3;
    //    self.bannerSV.imageURLStringsGroup = tempArray;
    //self.bannerSV.placeholderImage = [UIImage imageNamed:@"banner"];
    self.bannerSV.pageDotColor = [UIColor whiteColor];
    self.bannerSV.currentPageDotColor = ORANGECOLOR;
    self.bannerSV.backgroundColor=[UIColor whiteColor];
    
    self.bannerSV.delegate = self;
    [self.headView addSubview:self.bannerSV];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.bannerSV.maxY, WIDTH, 20*hy)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5*hx, 5, 13*hx, 10*hy)];
    imageView1.image = [UIImage imageNamed:@"新闻喇叭"];
    [view addSubview:imageView1];
    
    
    
    UIView *viewAnima = [[UIView alloc]initWithFrame:CGRectMake(30, 0, WIDTH-40*hx, 20*hy)];
    self.viewAnima = viewAnima;
    self.viewAnima.clipsToBounds = YES;
    [view addSubview:self.viewAnima];
    
    //NSString* text = self.gonggaoArr[@"title"];
    
//NSString* text = @"公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告公告hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh";
    NSString* text = self.gonggaoArr[@"title"];
    
    
    
    _gonggaotitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, text.length*15*hx, 20*hy)];
    _gonggaotitle.font = [UIFont systemFontOfSize:_font+1];
    _gonggaotitle.text =text;

    self.customLab = _gonggaotitle;
    
    UIButton *btn = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0, 250*hx, 20*hy)];
    btn.backgroundColor = [UIColor clearColor];
    btn.userInteractionEnabled = YES;
    [btn addTarget:self action:@selector(massageBTn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewAnima addSubview:btn];
    [self.viewAnima addSubview:self.gonggaotitle];
    
//    if (text.length*15*hx<=250*hx) {
//        
//    }
//    else
//    {
//        // 启动NSTimer定时器来改变UIImageView的位置
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changePos) userInfo:nil repeats:YES];
//    }
    
            // 启动NSTimer定时器来改变UIImageView的位置
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changePos) userInfo:nil repeats:YES];
    
    
    
    
    
    
    
     [self.headView addSubview:view];
    
    
    
    
    
    
    
    
    
//    self.headADView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bannerSV.maxY + KHeight(10)+ KHeight(20), kSCREENW, KHeight(80))];
        self.headADView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bannerSV.maxY + KHeight(10)+ KHeight(20), kSCREENW, 0)];
    //self.headADView.image = [UIImage imageNamed:@"headAD"];
    [self.headView addSubview:self.headADView];
    
    UICollectionViewFlowLayout *headLayout = [[UICollectionViewFlowLayout alloc] init];
    headLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    headLayout.minimumInteritemSpacing = KWidth(10);
    headLayout.minimumLineSpacing = KWidth(10);
    //CGFloat itemW = KWidth(550/2);
    
    CGFloat itemW = (kSCREENW-KWidth(10))/2;
    
    
    CGFloat itemH = KHeight(101);
    headLayout.itemSize = CGSizeMake(itemW , itemH);
    
    self.headCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.headADView.maxY, kSCREENW, KHeight(101)) collectionViewLayout:headLayout];
    self.headCV.delegate = self;
    self.headCV.dataSource = self;
    self.headCV.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.headCV.showsHorizontalScrollIndicator = NO;
    [self.headCV registerClass:[XYBidCell class] forCellWithReuseIdentifier:[XYBidCell identifier]];
    [self.headCV registerClass:[XYBidZhuanXiangCell class] forCellWithReuseIdentifier:[XYBidZhuanXiangCell identifier]];
    [self.headView addSubview:self.headCV];
    
//    self.headTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headCV.maxY, kSCREENW, KHeight(35))];
//    self.headTitleView.backgroundColor = [UIColor whiteColor];
//    [self.headView addSubview:self.headTitleView];
//    
//    UIView *headline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, 1)];
//    headline.backgroundColor = [UIColor colorWithRed:0.88 green:0.87 blue:0.89 alpha:1.00];
//    [self.headTitleView addSubview:headline];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(12), KHeight(10), kSCREENW - (KWidth(12) * 2), KHeight(13))];
//    titleLabel.font = [UIFont systemFontOfSize:KHeight(14)];
//    titleLabel.text = @"零定宝";
//    [self.headTitleView addSubview:titleLabel];
    
    UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, KHeight(35) - 1, kSCREENW, 1)];
    bottomline.backgroundColor = [UIColor colorWithRed:0.88 green:0.87 blue:0.89 alpha:1.00];
    [self.headTitleView addSubview:bottomline];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(382/2)-KHeight(101))];
    self.footView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.footADView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KHeight(10), kSCREENW, 0)];
    self.footADView.image = [UIImage imageNamed:@"footAD"];
    [self.footView addSubview:self.footADView];
    
    UICollectionViewFlowLayout *footLayout = [[UICollectionViewFlowLayout alloc] init];
    footLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    footLayout.minimumInteritemSpacing = KWidth(10);
    footLayout.minimumLineSpacing = KWidth(10);
    CGFloat footitemW = KWidth(550/2);
    CGFloat footitemH = KHeight(80);
    footLayout.itemSize = CGSizeMake(footitemW , footitemH);
    
    self.footCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.footADView.maxY, kSCREENW, KHeight(101)) collectionViewLayout:footLayout];
    self.footCV.delegate = self;
    self.footCV.dataSource = self;
    self.footCV.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.footCV.showsHorizontalScrollIndicator = NO;
    [self.footCV registerClass:[XYBidCell class] forCellWithReuseIdentifier:[XYBidCell identifier]];
    [self.footView addSubview:self.footCV];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kSCREENW, kSCREENH - 49) style:UITableViewStyleGrouped];
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
        [self GetGonggaiData];
        [self loadPlansData];
        [self getGongxiangData];
    }];
    
//    self.tableView.footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
//        self.pageNum += 1;
//        [self loadPlansData];
//    }];

    
    
    
    [self.view addSubview:self.tableView];
    
    self.btnXuanfu=[[UIImageView alloc] init];
    self.btnXuanfu.frame=CGRectMake(ScreenWidth-20-80, ScreenHeight-49-80-20, 80, 80);
    //self.btnXuanfu.image=[UIImage imageNamed:@"xuanfuBg"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotogongxianghuodong)];
    // 允许用户交互
    self.btnXuanfu.userInteractionEnabled = YES;
    
    [self.btnXuanfu addGestureRecognizer:tap];
    [self.view addSubview:self.btnXuanfu];
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
        //bidType  1，零定宝    2，新手专享标
        
        
        
        if (indexPath.row==0) {
            XYHomePlanTXCellFirstReMen *cell = [XYHomePlanTXCellFirstReMen cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.plansArr[indexPath.row];
            return cell;
        }
        else
        {
            XYHomePlanTXCell *cell = [XYHomePlanTXCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.plansArr[indexPath.row];
            return cell;
        
        }
        
        
        
        
        
    }
    else
    {
        
        if (indexPath.row==0) {
            XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+4]);
            //        if (tt.bidType.intValue==1) {//零定宝
            XYHomeLDBCellFirst *cell = [XYHomeLDBCellFirst cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.plansArr[indexPath.row+4];
            return cell;
        }
        else
        {
            XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+4]);
            //        if (tt.bidType.intValue==1) {//零定宝
            XYHomeLDBCell *cell = [XYHomeLDBCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.plansArr[indexPath.row+4];
            return cell;
        
        }
        
    
    }
    

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([TOKEN length] == 0) {
//      [self pushToLoginController];
//    } else {
//        XYPlanDetailController *planVC = [[XYPlanDetailController alloc] init];
//        planVC.model = self.plansArr[indexPath.row];
//        planVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:planVC animated:YES];
//    }
    
    
    if ([TOKEN length] == 0) {
        [self pushToLoginController];
    } else {
        
//        XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
//        //bidType  1，零定宝    2，新手专享标
//        if (tt.bidType.intValue==1) {
//            //零定宝
//            //                LYDPlanDetailController *detailVC = [[LYDPlanDetailController alloc] init];
//            //                detailVC.model = self.plansArr[indexPath.row];
//            //                detailVC.hidesBottomBarWhenPushed = YES;
//            //                [self.navigationController pushViewController:detailVC animated:YES];
//            
//            
//            
//            
//            
//            //planId   bidType
//            
//            
//            NSString *timestamp = [LYDTool createTimeStamp];
//            
//            
//            
//            //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
//            NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
//            // 生成签名认证
//            NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//            NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
//            
//            // 开始请求数据
//            [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                
//                id backData = LYDJSONSerialization(data);
//                
//                if ([[backData valueForKey:@"code"] integerValue] == 200) {
//                    //            self.myBalance = [NSString stringWithFormat:@"%@",[backData valueForKey:@"balance"]];
//                    //            if (self.balanceLabel) {
//                    //                self.balanceLabel.text = [NSString stringWithFormat:@"¥%.2f", [self.myBalance floatValue]];
//                    //            }
//                    
//                    
//                    //            for (NSDictionary *dict in [backData valueForKey:@"planModel"]) {
//                    //                XYPlanModel *model = [[XYPlanModel alloc] init];
//                    //                [model setValuesForKeysWithDictionary:dict];
//                    //                [self.plansArr addObject:model];
//                    //            }
//                    
//                    LYDPlanDetailController *detailVC = [[LYDPlanDetailController alloc] init];
//                    detailVC.model =  [XYPlanModel baseModelWithDic:backData[@"planModel"]];
//                    detailVC.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:detailVC animated:YES];
//                    
//                    
//                } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
//                    [DSYUtils showSuccessForStatus_600_ForViewController:self];
//                } else {
//                    
//                    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//                    [self.view.window addSubview:errorHud];
//                    //self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
//                }
//                
//                
//                
//            } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                NSInteger errorData = operation.response.statusCode;
//                
//                NSLog(@"%zi",operation.response.statusCode);
//                
//                if (errorData == 401) {
//                    // 401错误处理
//                    [DSYUtils showResponseError_401_ForViewController:self];
//                } else if (errorData == 404) {
//                    [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
//                        [self pushToLoginController];
//                        
//                    } cancelHandler:^(UIAlertAction *action) {
//                    }];
//                }
//                else if (errorData==500) {
//                    [DSYUtils showSuccessForStatus_600_ForViewController:self];
//                }
//                
//                else {
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//                    [self.view.window addSubview:errorHud];
//                }
//            }];
//            
//            
//            
//            
//            
//            
//            
//            
//            
//        }
//        else   if (tt.bidType.intValue==2) {
//            //planId   bidType
//            
//            
//            NSString *timestamp = [LYDTool createTimeStamp];
//            
//            
//            
//            //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
//            NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
//            // 生成签名认证
//            NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//            NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};                // 开始请求数据
//            [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                
//                id backData = LYDJSONSerialization(data);
//                
//                if ([[backData valueForKey:@"code"] integerValue] == 200) {
//                    
//                    NewBidDetailController *detailVC = [[NewBidDetailController alloc] init];
//                    detailVC.model =  [XYPlanModel baseModelWithDic:backData[@"planModel"]];
//                    detailVC.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:detailVC animated:YES];
//                    
//                    
//                } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
//                    [DSYUtils showSuccessForStatus_600_ForViewController:self];
//                } else {
//                    
//                    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//                    [self.view.window addSubview:errorHud];
//                    //self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
//                }
//                
//                
//                
//            } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                NSInteger errorData = operation.response.statusCode;
//                
//                NSLog(@"%zi",operation.response.statusCode);
//                
//                if (errorData == 401) {
//                    // 401错误处理
//                    [DSYUtils showResponseError_401_ForViewController:self];
//                } else if (errorData == 404) {
//                    [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
//                        [self pushToLoginController];
//                        
//                    } cancelHandler:^(UIAlertAction *action) {
//                    }];
//                }
//                else if (errorData==500) {
//                    [DSYUtils showSuccessForStatus_600_ForViewController:self];
//                }
//                
//                else {
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//                    [self.view.window addSubview:errorHud];
//                }
//            }];
//            
//        }
//        
//        
//        
//        else
//        {
//            //                XYPlanDetailController *detailVC = [[XYPlanDetailController alloc] init];
//            //                detailVC.model = self.plansArr[indexPath.row];
//            //                detailVC.hidesBottomBarWhenPushed = YES;
//            //                [self.navigationController pushViewController:detailVC animated:YES];
//            
//            
//            
//            NSString *timestamp = [LYDTool createTimeStamp];
//            
//            
//            
//            //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
//            NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
//            // 生成签名认证
//            NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//            NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
//            
//            // 开始请求数据
//            [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                
//                id backData = LYDJSONSerialization(data);
//                
//                if ([[backData valueForKey:@"code"] integerValue] == 200) {
//                    //            self.myBalance = [NSString stringWithFormat:@"%@",[backData valueForKey:@"balance"]];
//                    //            if (self.balanceLabel) {
//                    //                self.balanceLabel.text = [NSString stringWithFormat:@"¥%.2f", [self.myBalance floatValue]];
//                    //            }
//                    
//                    
//                    //            for (NSDictionary *dict in [backData valueForKey:@"planModel"]) {
//                    //                XYPlanModel *model = [[XYPlanModel alloc] init];
//                    //                [model setValuesForKeysWithDictionary:dict];
//                    //                [self.plansArr addObject:model];
//                    //            }
//                    
//                    
//                    XYPlanDetailController *detailVC = [[XYPlanDetailController alloc] init];
//                    detailVC.model = [XYPlanModel baseModelWithDic:backData[@"planModel"]];
//                    detailVC.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:detailVC animated:YES];
//                    
//                    
//                } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
//                    [DSYUtils showSuccessForStatus_600_ForViewController:self];
//                } else {
//                    
//                    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"获取余额失败" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//                    [self.view.window addSubview:errorHud];
//                    //self.balanceLabel.text = [NSString stringWithFormat:@"余额获取失败"];
//                }
//                
//                
//                
//            } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                NSInteger errorData = operation.response.statusCode;
//                
//                NSLog(@"%zi",operation.response.statusCode);
//                
//                if (errorData == 401) {
//                    // 401错误处理
//                    [DSYUtils showResponseError_401_ForViewController:self];
//                } else if (errorData == 404) {
//                    [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
//                        [self pushToLoginController];
//                        
//                    } cancelHandler:^(UIAlertAction *action) {
//                    }];
//                }
//                else if (errorData==500) {
//                    [DSYUtils showSuccessForStatus_600_ForViewController:self];
//                }
//                
//                else {
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//                    [self.view.window addSubview:errorHud];
//                }
//            }];
//            //
//            
//            
//            
//            
//        }


        
        if (indexPath.section==0) {//份数标
            
            XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
            //bidType  1，零定宝    2，新手专享标
            if (tt.bidType.intValue==1) {
                //零定宝
                //                LYDPlanDetailController *detailVC = [[LYDPlanDetailController alloc] init];
                //                detailVC.model = self.plansArr[indexPath.row];
                //                detailVC.hidesBottomBarWhenPushed = YES;
                //                [self.navigationController pushViewController:detailVC animated:YES];
                
                
                
                
                
                //planId   bidType
                
                
                NSString *timestamp = [LYDTool createTimeStamp];
                
                
                
                //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
                NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                // 生成签名认证
                NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
                
                // 开始请求数据
                [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
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
                        
                        LYDPlanDetailController *detailVC = [[LYDPlanDetailController alloc] init];
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
            else   if (tt.bidType.intValue==2) {
                //planId   bidType
                
                
                NSString *timestamp = [LYDTool createTimeStamp];
                
                
                
                //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
                NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                // 生成签名认证
                NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};                // 开始请求数据
                [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
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
            
            
            
            else
            {
                //                XYPlanDetailController *detailVC = [[XYPlanDetailController alloc] init];
                //                detailVC.model = self.plansArr[indexPath.row];
                //                detailVC.hidesBottomBarWhenPushed = YES;
                //                [self.navigationController pushViewController:detailVC animated:YES];
                
                
                
                NSString *timestamp = [LYDTool createTimeStamp];
                
                
                
                //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
                NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                // 生成签名认证
                NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
                
                // 开始请求数据
                [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
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
                        
                        
                        XYPlanDetailController *detailVC = [[XYPlanDetailController alloc] init];
                        detailVC.model = [XYPlanModel baseModelWithDic:backData[@"planModel"]];
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
                //
                
                
                
                
            }

            
        }
        else
        {
        //零定宝
            XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+4]);
            //bidType  1，零定宝    2，新手专享标
            if (tt.bidType.intValue==1) {
                //零定宝
                //                LYDPlanDetailController *detailVC = [[LYDPlanDetailController alloc] init];
                //                detailVC.model = self.plansArr[indexPath.row];
                //                detailVC.hidesBottomBarWhenPushed = YES;
                //                [self.navigationController pushViewController:detailVC animated:YES];
                
                
                
                
                
                //planId   bidType
                
                
                NSString *timestamp = [LYDTool createTimeStamp];
                
                
                
                //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
                NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                // 生成签名认证
                NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
                
                // 开始请求数据
                [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
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
                        
                        LYDPlanDetailController *detailVC = [[LYDPlanDetailController alloc] init];
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
            else   if (tt.bidType.intValue==2) {
                //planId   bidType
                
                
                NSString *timestamp = [LYDTool createTimeStamp];
                
                
                
                //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
                NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                // 生成签名认证
                NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};                // 开始请求数据
                [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
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
            
            
            
            else
            {
                //                XYPlanDetailController *detailVC = [[XYPlanDetailController alloc] init];
                //                detailVC.model = self.plansArr[indexPath.row];
                //                detailVC.hidesBottomBarWhenPushed = YES;
                //                [self.navigationController pushViewController:detailVC animated:YES];
                
                
                
                NSString *timestamp = [LYDTool createTimeStamp];
                
                
                
                //NSDictionary *tttttttttttt = @{@"planId":self.model.planId, @"bidType":nil};
                NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                // 生成签名认证
                NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
                
                // 开始请求数据
                [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
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
                        
                        
                        XYPlanDetailController *detailVC = [[XYPlanDetailController alloc] init];
                        detailVC.model = [XYPlanModel baseModelWithDic:backData[@"planModel"]];
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
                //
                
                
                
                
            }

        
        
        
        }
        
        
        
        
        
        
        
        
    }

    
    
    
    
    
    
    
    
    

    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [XYHomePlanCell cellHeight];
    
    XYPlanModel *tt;
    if (indexPath.section==0) {
        tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
        return [XYHomePlanTXCell cellHeight];
    }
    else
    {
        tt=(XYPlanModel *)(self.plansArr[indexPath.row+4]);
        return [XYHomeLDBCell cellHeight];
    }
    
    
    
    
//    //        else//份数标
//    //        {
//    XYHomePlanTXCell *cell = [XYHomePlanTXCell cellWithTableView:tableView];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.model = self.plansArr[indexPath.row];
//    return cell;
    
//    if (tt.bidType.intValue==1) {
//        return [XYHomeLDBCell cellHeight];
//    }
//    else if (tt.bidType.intValue==2)//新手专享标  没有贴息
//    {
//        return [XYHomePlanCell cellHeight];
//        
//    }
//    else
//    {
//        return [XYHomePlanTXCell cellHeight];
//        
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
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

//#pragma mark - 最新数据请求方式
//- (void)loadData {
//    NSString *url = [NSString stringWithFormat:@"%@/home/details", APIPREFIX];
////    NSString *url = @"http://lydapi.coralcode.cn/help/about";
//    [MBProgressHUD showMessage:@"正在加载首页..." toView:self.view];
//    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
//        [LYDTool sendGetWithUrl:url parameters:[self getMyPara] success:^(id data) {
//            id backData = LYDJSONSerialization(data);
//            [self.tableView.header endRefreshing];
//            NSLog(@"%@", backData);
//            [self successDealWithData:backData];
//        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//            [self.tableView.header endRefreshing];
//            [MBProgressHUD hideHUDForView:self.view];
//            [MBProgressHUD showError:@"网络异常!" toView:self.view];
//            [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
//            }];
//        }];
//    }];
//    
//}


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


#pragma mark - 获取公告信息
- (void)GetGonggaiData
{
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"location":@"27"};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"location":@"27",@"sign":sign};
    
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/content/getNotice",APIPREFIX] parameters:para success:^(id data) {
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"backData:%@",backData);
        
        
//        for (NSDictionary *dict in backData) {
////            XYBannerModel *model = [[XYBannerModel alloc] init];
////            [model setValuesForKeysWithDictionary:dict];
////            [self.bannersArr addObject:model];
//            
//        }
        self.gonggaoArr=backData;
        
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

//- (void)loadPlansData
//{
////     @ApiParam(value = "满标状态：1显示、2不显示") @RequestParam() final Integer loneType,
////
//    NSString *timestamp = [LYDTool createTimeStamp];
//    
//    NSDictionary *secretDict = @{@"loneType":[NSNumber numberWithInteger:2],@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:15]};
//    
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *para = @{@"loneType":[NSNumber numberWithInteger:2],@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:15]};
//    
//    
//    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans",APIPREFIX] parameters:para success:^(id data) {
//        
//        
//        
//        if (self.pageNum == 1) {
//            [self.plansArr removeAllObjects];
//        }
//        
//        id backData = LYDJSONSerialization(data);
//        NSLog(@"%@",backData);
//        
//        if ([[backData allKeys] count] == 0) {
//            [self.tableView.footer noticeNoMoreData];
//            [self.tableView.header endRefreshing];
//        } else {
//            for (NSDictionary *dict in [backData valueForKey:@"planList"]) {
//                XYPlanModel *model = [[XYPlanModel alloc] init];
//                [model setValuesForKeysWithDictionary:dict];
//                [self.plansArr addObject:model];
//            }
//            
//            [self.tableView.header endRefreshing];
//            [self.tableView.footer endRefreshing];
//            
//            if (self.plansArr.count < 10) {
//                [self.tableView.footer noticeNoMoreData];
//            }
//            
//            [self.tableView reloadData];
//            
//            
//            
//            if (self.pageNum == 1) {
//               // [self loadFootsData];
//            }
//        }
//    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//        
//        [MBProgressHUD hideHUDForView:self.view];
//        [self.tableView.header endRefreshing];
//        [self.tableView.footer endRefreshing];
//        
//        
//        
//        id response = LYDJSONSerialization(operation.responseObject);
//        NSLog(@"%@",response);
//        if ([[response valueForKey:@"code"] integerValue] == 401) {
//            [DSYUtils showResponseError_401_ForViewController:self];
//            
//        } else {
//            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//            [self.view.window addSubview:errorHud];
//        }
//        
//    }];
//    
//}



- (void)loadPlansData
{
    //     @ApiParam(value = "满标状态：1显示、2不显示") @RequestParam() final Integer loneType,
    //
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"loneType":[NSNumber numberWithInteger:2],@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:15]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"loneType":[NSNumber numberWithInteger:2],@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:15]};
    
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plansNew",APIPREFIX] parameters:para success:^(id data) {
        
        
        
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



//#pragma mark - 网络加载数据----------------------
//#pragma mark  加载理财的数据--------------
//- (void)loadPlanData
//{
//    NSString *timestamp = [LYDTool createTimeStamp];
//    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:10]};
//    
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:10],@"sign":sign};
//    
//    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans",APIPREFIX] parameters:para success:^(id data) {
//        [self.planTableView.header endRefreshing];
//        [self.planTableView.footer endRefreshing];
//        [MBProgressHUD hideHUDForView:self.view];
//        
//        id backData = LYDJSONSerialization(data);
//        //bidType   1零定宝
//        NSLog(@"%@",backData);
//        
//        if ([[backData valueForKey:@"code"] integerValue] == 200) {
//            if (self.planPageNum == 1) {
//                [self.plansArr removeAllObjects];
//            }
//            if ([[backData valueForKey:@"planList"] count] == 0) {
//                [self.planTableView.footer noticeNoMoreData];
//                [self.planTableView.header endRefreshing];
//            } else {
//                for (NSDictionary *dict in [backData valueForKey:@"planList"]) {
//                    XYPlanModel *model = [[XYPlanModel alloc] init];
//                    [model setValuesForKeysWithDictionary:dict];
//                    [self.plansArr addObject:model];
//                }
//                
//                if (self.plansArr.count < 10) {
//                    [self.planTableView.footer noticeNoMoreData];
//                }
//                [self.planTableView reloadData];
//            }
//            
//        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
//            [DSYUtils showSuccessForStatus_600_ForViewController:self];
//        } else {
//            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
//            [self.view.window addSubview:errorHud];
//            
//        }
//        
//    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//        [self errorDataHandleWithOperation:operation];
//    }];
//    
//    
//}


//- (void)loadHeadsData
//{
//    NSString *timestamp = [LYDTool createTimeStamp];
//    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:10],@"bidsType":@"2"};
//    
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:1],@"pageSize":[NSNumber numberWithInteger:10],@"bidsType":@"2",@"sign":sign};
//    
//    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/bids",APIPREFIX] parameters:para success:^(id data) {
//        
//        
//        
//        id backData = LYDJSONSerialization(data);
//        NSLog(@"%@",backData);
//        
//        if ([[backData valueForKey:@"code"] integerValue] == 200) {
//            
//            [self.headsArr removeAllObjects];
//            
//            for (NSDictionary *dict in [backData valueForKey:@"bidsList"]) {
//                XYSanBidModel *model = [[XYSanBidModel alloc] init];
//                [model setValuesForKeysWithDictionary:dict];
//                [self.headsArr addObject:model];
//            }
//            [self.headCV reloadData];
//            
//            [self loadPlansData];
//            
//        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
//            [DSYUtils showSuccessForStatus_600_ForViewController:self];
//        } else {
//            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
//            [self.view.window addSubview:errorHud];
//            
//        }
//        
//    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//        
//        [MBProgressHUD hideHUDForView:self.view];
//        
//        [self.tableView.header endRefreshing];
//        [self.tableView.footer endRefreshing];
//        
//        id response = LYDJSONSerialization(operation.responseObject);
//        NSLog(@"%@",response);
//        if ([[response valueForKey:@"code"] integerValue] == 401) {
//            [DSYUtils showResponseError_401_ForViewController:self];
//            
//        } else {
//            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
//            [self.view.window addSubview:errorHud];
//        }
//        
//    }];
//}

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