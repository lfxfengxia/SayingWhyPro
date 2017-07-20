//
//  XYMoreController.m
//  LYDApp
//
//  Created by dookay_73 on 16/10/31.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYMoreController.h"
#import "RBAboutUsViewController.h"
#import "RBMessageCenterViewController.h"
#import "RBServiceCenterViewController.h"
#import "RBFeedBackViewController.h"

#import "DSYAbountUsController.h"
#import "DSYHelpWebViewController.h"

#import "DSYAbountUsWebViewController.h"         // 关于我们
#import "DSYInvestIntroWebViewController.h"      // 投资说明
#import "DSYHelpWebViewController.h"             // 帮助中心
#import "DSYCustomerWebViewController.h"         // 消息中心、
#import "WYJKViewController.h"//我要借款
#import "toolsimple.h"
#import "XYBannerModel.h"

@interface XYMoreController () <UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) SDCycleScrollView *bannerSV;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, copy) NSMutableArray  *bannersArr;
@end

@implementation XYMoreController
- (NSMutableArray *)bannersArr
{
    if (!_bannersArr) {
        _bannersArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _bannersArr;
}

- (void)viewDidLoad {
   [self IsUpdate];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BgColor;
    
    
    self.dataArray = @[@"关于我们", @"帮助中心", @"客服中心", @"意见反馈", @"当前版本", @"清除缓存"];
    self.imagesArray = @[@"guanyuwmnew", @"bangzhuzhongxinnew", @"kefuzhongchongnew", @"yijianfankuinewnew", @"dangqianbanbennew", @"qingchuhuanchunnew"];
    
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
   [self IsUpdate];
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
}

- (void)createUI {
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSArray *imageArray = @[@"banner",
                               @"banner",
                               @"banner"];
    [tempArray addObjectsFromArray:imageArray];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENW*390/750 + 10)];
    _bgView.backgroundColor = BgColor;

    self.bannerSV = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(390 / 2))];
    self.bannerSV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerSV.autoScrollTimeInterval = 3;
    self.bannerSV.imageURLStringsGroup = tempArray;
    self.bannerSV.localizationImageNamesGroup = tempArray;
    self.bannerSV.placeholderImage = [UIImage imageNamed:@"banner"];
    self.bannerSV.pageDotColor = [UIColor whiteColor];
    self.bannerSV.currentPageDotColor = ORANGECOLOR;
    self.bannerSV.delegate = self;
    [self.bgView addSubview:self.bannerSV];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH-49-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _bgView;
    _tableView.separatorColor=[UIColor clearColor];
    [self loadBannerData];
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
- (void)refreshHeadView
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (XYBannerModel *model in _bannersArr) {
        //NSString *urlString = [model.imageUrl hasPrefix:@"http://"] ? model.imageUrl : [NSString stringWithFormat:@"%@%@",APIPREFIX,model.imageUrl];
//        NSString *urlString = [model.imageUrl hasPrefix:@"http://"] ? model.imageUrl : [NSString stringWithFormat:@"%@%@",APIPREFIX,model.imageUrl];
        [tempArray addObject:model.imageUrl];
    }
    self.bannerSV.imageURLStringsGroup = tempArray;
    
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else
    {
    
       return _dataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"RBMoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightThin];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.font = DSY_NORMALFONT_13;
    }
    
    
    if (indexPath.section==0) {
        cell.imageView.image = [UIImage imageNamed:@"woyaojiekuannew"];
        cell.textLabel.text = @"我要借款";
        //    self.dataArray = @[@"我要借款",@"关于我们", @"帮助中心", @"客服中心", @"意见反馈", @"当前版本", @"清除缓存"];
        //        self.imagesArray = @[@"woyaojiekuannew",@"guanyuwmnew", @"bangzhuzhongxinnew", @"kefuzhongchongnew", @"yijianfankuinewnew", @"dangqianbanbennew", @"qingchuhuanchunnew"];
        
    }
    else
    {
    
        cell.imageView.image = [UIImage imageNamed:_imagesArray[indexPath.row]];
        cell.textLabel.text = _dataArray[indexPath.row];
        if (indexPath.row == 4) {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 版本", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        } else {
            cell.detailTextLabel.text = @"";
        }
        
        if (indexPath.row!=5) {
            UIImageView  *imglineheng=[[UIImageView alloc] initWithFrame:CGRectMake(15, cell.frame.size.height, cell.frame.size.width-30, 1)];
            imglineheng.image=[UIImage imageNamed:@"licai_line_hui"];
            [cell.contentView addSubview:imglineheng];
        }

    }
    
     return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    if (indexPath.section==0) {
        
        WYJKViewController *aboutUsVC = [[WYJKViewController alloc] init];
        //        aboutUsVC.title = _dataArray[indexPath.row];
        aboutUsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
    else
    {
    
       if (indexPath.row == 0) {
            // 关于我们
            DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
           aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/about", APIPREFIX];
           
            //        aboutUsVC.title = _dataArray[indexPath.row];
            aboutUsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutUsVC animated:YES];
        }
        
        else if (indexPath.row == 1) {
            DSYHelpWebViewController *helpVC = [[DSYHelpWebViewController alloc] init];
            helpVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:helpVC animated:YES];
        } else if (indexPath.row == 2) {
            DSYCustomerWebViewController *serviceCenterVC = [[DSYCustomerWebViewController alloc] init];
            serviceCenterVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:serviceCenterVC animated:YES];
        } else if (indexPath.row == 3) {
            if ([TOKEN length] == 0) {
                [self pushToLoginController];
            } else {
                RBFeedBackViewController *feedbackVC = [[RBFeedBackViewController alloc] init];
                feedbackVC.title = _dataArray[indexPath.row];
                feedbackVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:feedbackVC animated:YES];
            }
            
        } else if (indexPath.row == 4) {
            
        } else if (indexPath.row == 5) {
            __weak XYMoreController *weakSelf = self;
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = @"正在计算";
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString *show = [weakSelf caluteCache];
                show = [NSString stringWithFormat:@"将清除%@的缓存", show];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定清除缓存" message:show preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                
                                [NSThread sleepForTimeInterval:2.0];
                                NSString *filsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CustomFile"];
                                NSFileManager *mgr = [NSFileManager defaultManager];
                                [mgr removeItemAtPath:filsPath error:nil];
                                [mgr createDirectoryAtPath:filsPath withIntermediateDirectories:YES attributes:nil error:nil];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                });
                            });
                        }];
                    }];
                    
                    [alertVC addAction:cancelAction];
                    [alertVC addAction:doneAction];
                    cell.detailTextLabel.text = @"";
                    [weakSelf presentViewController:alertVC animated:YES completion:nil];
                });
            });
            
        } else {
            NSLog(@"else");
        }
    
    }
    
    
    
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==1) {
        return 10;
    }
    else
    {
        return 0.01f;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}



#pragma mark - 计算缓存文件的大小
- (NSString *)caluteCache {
    unsigned long long size =
    [self fileSize];
    //fileSize是封装在Category中的。
    
    size += [SDImageCache sharedImageCache].getSize;   //CustomFile + SDWebImage 缓存
    
    //设置文件大小格式
    NSString *sizeText = nil;
    if (size >= pow(10, 9)) {
        sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    }else if (size >= pow(10, 6)) {
        sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    }else if (size >= pow(10, 3)) {
        sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    }else {
        sizeText = [NSString stringWithFormat:@"%zdB", size];
    }
    return sizeText;
}

- (unsigned long long)fileSize
{
    NSString *filsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CustomFile"];
    
    unsigned long long size = 0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isExist = [mgr fileExistsAtPath:filsPath isDirectory:&isDirectory];
    if(!isExist) return size;
    if (isExist) {
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:filsPath];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [filsPath stringByAppendingPathComponent:subPath];
            size +=[mgr attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
    }else
    {
        size = [mgr attributesOfItemAtPath:filsPath error:nil].fileSize;
    }
    return size;
}


@end
