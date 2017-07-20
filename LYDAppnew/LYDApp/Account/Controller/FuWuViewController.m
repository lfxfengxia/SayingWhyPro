//
//  FuWuViewController.m
//  LYDApp
//
//  Created by fcl on 2017/6/30.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "FuWuViewController.h"
#import "toolsimple.h"
#import "FuWuCell.h"
#import "MJRefresh.h"
#import "DSYAbountUsWebViewController.h"
#import "RBFeedBackViewController.h"
@interface FuWuViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArray;
@end

@implementation FuWuViewController

-(NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray=[[NSMutableArray alloc]init];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"服务";
     self.navigationController.navigationBar.tintColor =[UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1/1.0];
    
    [self createUI];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [self IsUpdate];
    [self requestFuWuList];
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO];
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

-(void)requestFuWuList{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//app当前版本号
     NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appVersion":app_Version,@"appType":@"2",@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appVersion":app_Version,@"appType":@"2",@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    // 开始请求数据
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/content/getContentService", APIPREFIX] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.header endRefreshing];
        id backData = LYDJSONSerialization(data);
        [self.listArray removeAllObjects];
        for (NSMutableDictionary *dic in backData) {
            [self.listArray addObject:dic];
        }
        
        [self.tableView reloadData];
                
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self.tableView.header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger errorData = operation.response.statusCode;
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


- (void)createUI {
    UIView *tableheader=[[UIView alloc] init];
    tableheader.backgroundColor=[UIColor whiteColor];
    UIImageView *btnimg=[[UIImageView alloc] init];
    btnimg.frame=CGRectMake((kSCREENW-KWidth(325))/2, KHeight(20), KWidth(325), KHeight(135));
    btnimg.image=[UIImage imageNamed:@"立即咨询"];
    
    
    
    tableheader.frame=CGRectMake(0, 0, kSCREENW, btnimg.maxY+KHeight(20));
    [tableheader addSubview:btnimg];
    
    UIButton *consultBtn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-KWidth(58)/2, KHeight(40), KWidth(58), KHeight(58))];
    [consultBtn setBackgroundImage:[UIImage imageNamed:@"客服-1"] forState:UIControlStateNormal];
    [consultBtn addTarget:self action:@selector(consult) forControlEvents:UIControlEventTouchUpInside];
    [tableheader addSubview:consultBtn];
    
    
    UILabel *consult=[[UILabel alloc]initWithFrame:CGRectMake(0, KHeight(108), WIDTH, KHeight(18))];
    consult.text=@"立即咨询";
    consult.textColor=[UIColor whiteColor];
    consult.font=[UIFont systemFontOfSize:KWidth(14)];
    consult.textAlignment=NSTextAlignmentCenter;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(consult)];
    [consult addGestureRecognizer:tap];
    consult.userInteractionEnabled=YES;
    [tableheader addSubview:consult];

    _tableView = [[UITableView alloc] init];
    _tableView.frame=CGRectMake(0, 64, kSCREENW, kSCREENH-49-64);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = tableheader;
    _tableView.backgroundColor=  [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1/1.0];
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestFuWuList];
    }];
}

#pragma mark 咨询进入
-(void)consult
{
    // 关于我们
    DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
    aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/help?type2=cs", APIPREFIX];
    //        aboutUsVC.title = _dataArray[indexPath.row];
    aboutUsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutUsVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==1) {
        // 关于我们
        DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
        aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/help", APIPREFIX];
        //        aboutUsVC.title = _dataArray[indexPath.row];
        aboutUsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
    else if(indexPath.row==2)
    {
    
        RBFeedBackViewController *feedbackVC = [[RBFeedBackViewController alloc] init];
        feedbackVC.title = @"意见反馈";
        feedbackVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedbackVC animated:YES];
    
    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   if(indexPath.row==0)
   {
       FuWuCell *cell=[FuWuCell FuWuCellWithTableView:tableView];
       cell.selectionStyle=UITableViewCellSelectionStyleNone;
       [cell ListArray:self.listArray];
       return cell;
   }else{
       static NSString *identify = @"RBMoreCell";
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
       if (cell == nil) {
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           cell.textLabel.font = [UIFont systemFontOfSize:14];
           cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
           cell.textLabel.textColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
           cell.detailTextLabel.font = DSY_NORMALFONT_13;
       }
       if (indexPath.row==1) {
           cell.textLabel.text = @"帮助中心";
           cell.imageView.image = [UIImage imageNamed:@"帮助中心"];
           UIView  *imglineheng=[[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-1, kSCREENW, 1)];
           imglineheng.backgroundColor=RGB(242, 242, 242);
           
           [cell.contentView addSubview:imglineheng];
           return cell;
       }
       else if(indexPath.row==2)
       {
           cell.textLabel.text = @"意见反馈";
           cell.imageView.image = [UIImage imageNamed:@"意见反馈"];
           return cell;
       }
   }
       
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        if(self.listArray.count==0)
        {
            return 10;
        }else
        {
            return ((self.listArray.count-1)/3+1)*KHeight(111)+10;
        }
    }else
    {
        return KHeight(44);
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
