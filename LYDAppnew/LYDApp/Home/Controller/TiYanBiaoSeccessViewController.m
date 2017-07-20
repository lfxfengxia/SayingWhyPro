//
//  TiYanBiaoSeccessViewController.m
//  LYDApp
//
//  Created by fcl on 2017/7/3.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "TiYanBiaoSeccessViewController.h"
#import "XYSanBidModel.h"
#import "XYPlanModel.h"
#import "fenshubiaoDetailViewController.h"

@interface TiYanBiaoSeccessViewController ()
@property (nonatomic, copy) NSMutableArray  *headsArr;
@end

@implementation TiYanBiaoSeccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"投资完成";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    [self createUI];
    [self loadData];

}



#pragma mark - 最新数据请求方式
- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@/home/detailsNew", APIPREFIX];
    //    NSString *url = @"http://lydapi.coralcode.cn/help/about";
    [MBProgressHUD showMessage:@"正在加载首页..." toView:self.view];
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        [LYDTool sendGetWithUrl:url parameters:[self getMyPara] success:^(id data) {
            id backData = LYDJSONSerialization(data);
            NSLog(@"%@", backData);
            [self successDealWithData:backData];
        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
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
        
        
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
    }
    
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        
    }];
}




- (void)createUI {
    
    UIImageView *imgbg=[[UIImageView alloc] init];
    imgbg.frame=CGRectMake(0, 64, kSCREENW, KHeight(397));
    imgbg.image=[UIImage imageNamed:@"投资成功BG"];
    imgbg.userInteractionEnabled=YES;
    [self.view addSubview:imgbg];
    
    
    
    UIImageView *imgbgKuang=[[UIImageView alloc] init];
    imgbgKuang.frame=CGRectMake((kSCREENW-KWidth(297))/2, 180, KWidth(297), KHeight(247));
    imgbgKuang.image=[UIImage imageNamed:@"框"];
    imgbgKuang.userInteractionEnabled=YES;
    [imgbg addSubview:imgbgKuang];
    
    
    UILabel *lbl=[[UILabel alloc] init];
    lbl.text=@"新手专享标";
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.textColor=[UIColor orangeColor];
    lbl.font=[UIFont systemFontOfSize:20];
    lbl.frame=CGRectMake(0, KHeight(20), imgbgKuang.frame.size.width, KHeight(30));
    [imgbgKuang addSubview:lbl];
    
    
    UILabel *lbl1=[[UILabel alloc] init];
    lbl1.text=@"新手专享";
    lbl1.textAlignment=NSTextAlignmentCenter;
    lbl1.textColor=[UIColor orangeColor];
    lbl1.font=[UIFont systemFontOfSize:10];
    lbl1.frame=CGRectMake(KWidth(50), lbl.maxY, KWidth(55), KHeight(15));
    lbl1.layer.cornerRadius=5;
    lbl1.layer.borderWidth=1;
    lbl1.layer.borderColor=[UIColor orangeColor].CGColor;
    [imgbgKuang addSubview:lbl1];
    
    
    UILabel *lbl2=[[UILabel alloc] init];
    lbl2.text=@"按月付息";
    lbl2.textAlignment=NSTextAlignmentCenter;
    lbl2.textColor=[UIColor blueColor];
    lbl2.font=[UIFont systemFontOfSize:10];
    lbl2.frame=CGRectMake(lbl1.maxX+(imgbgKuang.frame.size.width-3*KWidth(55)-2*KWidth(50))/2, lbl.maxY, KWidth(55), KHeight(15));
    lbl2.layer.cornerRadius=5;
    lbl2.layer.borderWidth=1;
    lbl2.layer.borderColor=[UIColor blueColor].CGColor;
    [imgbgKuang addSubview:lbl2];
    
    
    UILabel *lbl3=[[UILabel alloc] init];
    lbl3.text=@"省心高息";
    lbl3.textAlignment=NSTextAlignmentCenter;
    lbl3.textColor=[UIColor redColor];
    lbl3.font=[UIFont systemFontOfSize:10];
    lbl3.frame=CGRectMake(lbl2.maxX+(imgbgKuang.frame.size.width-3*KWidth(55)-2*KWidth(50))/2, lbl.maxY, KWidth(55), KHeight(15));
    lbl3.layer.cornerRadius=5;
    lbl3.layer.borderWidth=1;
    lbl3.layer.borderColor=[UIColor redColor].CGColor;
    [imgbgKuang addSubview:lbl3];
    
    
    
    UILabel *lbl4=[[UILabel alloc] init];
    lbl4.text=@"15%";
    lbl4.textAlignment=NSTextAlignmentCenter;
    lbl4.textColor=[UIColor orangeColor];
    lbl4.font=[UIFont systemFontOfSize:30];
    lbl4.frame=CGRectMake(0, lbl3.maxY+KHeight(20),imgbgKuang.frame.size.width, KHeight(40));
    [imgbgKuang addSubview:lbl4];
    
    
    UILabel *lbl5=[[UILabel alloc] init];
    lbl5.text=@"年化收益率";
    lbl5.textAlignment=NSTextAlignmentCenter;
    lbl5.textColor=[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    lbl5.font=[UIFont systemFontOfSize:13];
    lbl5.frame=CGRectMake(0, lbl4.maxY+KHeight(20), imgbgKuang.frame.size.width, KHeight(15));
    [imgbgKuang addSubview:lbl5];
    
    
    
    UILabel *lbl6=[[UILabel alloc] init];
    lbl6.text=@"一个月";
    lbl6.textAlignment=NSTextAlignmentCenter;
    lbl6.textColor=[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    lbl6.font=[UIFont systemFontOfSize:11];
    lbl6.frame=CGRectMake(imgbgKuang.frame.size.width/5, lbl5.maxY+KHeight(20), imgbgKuang.frame.size.width/5, KHeight(20));
    [imgbgKuang addSubview:lbl6];
    
    
    UILabel *lbl7=[[UILabel alloc] init];
    lbl7.text=@"1000元";
    lbl7.textAlignment=NSTextAlignmentCenter;
    lbl7.textColor=[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    lbl7.font=[UIFont systemFontOfSize:11];
    
    lbl7.frame=CGRectMake(lbl6.maxX+imgbgKuang.frame.size.width/5, lbl5.maxY+KHeight(20), imgbgKuang.frame.size.width/5, KHeight(20));
    [imgbgKuang addSubview:lbl7];
    
    
    
    UILabel *lbl8=[[UILabel alloc] init];
    lbl8.text=@"投资期限";
    lbl8.textAlignment=NSTextAlignmentCenter;
    lbl8.textColor=[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    lbl8.font=[UIFont systemFontOfSize:13];
    lbl8.frame=CGRectMake(imgbgKuang.frame.size.width/5, lbl6.maxY+KHeight(5), imgbgKuang.frame.size.width/5, KHeight(20));
    [imgbgKuang addSubview:lbl8];
    
    
    UILabel *lbl9=[[UILabel alloc] init];
    lbl9.text=@"单份金额";
    lbl9.textAlignment=NSTextAlignmentCenter;
    lbl9.textColor=[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0];
    lbl9.font=[UIFont systemFontOfSize:13];
    lbl9.frame=CGRectMake(imgbgKuang.frame.size.width/5+lbl8.maxX, lbl6.maxY+KHeight(5), imgbgKuang.frame.size.width/5, KHeight(20));
    [imgbgKuang addSubview:lbl9];
    
    
    UIButton *btnclick=[UIButton buttonWithType:UIButtonTypeCustom];
    btnclick.backgroundColor=[UIColor orangeColor];
    [btnclick setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnclick setTitle:@"前往投资" forState:UIControlStateNormal];
    btnclick.layer.cornerRadius=20;
    btnclick.userInteractionEnabled=YES;
    [btnclick addTarget:self action:@selector(GotoXinShouBiaoDetail) forControlEvents:UIControlEventTouchUpInside];
    btnclick.frame=CGRectMake((kSCREENW-KWidth(200))/2, imgbgKuang.maxY+KHeight(70), KWidth(200), KHeight(40));
    [self.view addSubview:btnclick];
    
    
    UIButton *bb=[UIButton buttonWithType:UIButtonTypeCustom];
    bb.backgroundColor=[UIColor clearColor];
    [bb setTitleColor:[UIColor colorWithRed:202/255.0 green:191/255.0 blue:187/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    [bb setTitle:@"查看更多理财" forState:UIControlStateNormal];
    bb.userInteractionEnabled=YES;
    [bb addTarget:self action:@selector(fanhuilicai) forControlEvents:UIControlEventTouchUpInside];
    bb.frame=CGRectMake((kSCREENW-KWidth(160))/2, btnclick.maxY+KHeight(10), KWidth(160), KHeight(20));
    [self.view addSubview:bb];

    
}


-(void)fanhuilicai
{

    [self.navigationController popToRootViewControllerAnimated:YES];
    
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



@end
