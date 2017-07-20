			//
//  XYMoneyController.m
//  LYDApp
//
//  Created by dookay_73 on 16/10/31.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYMoneyController.h"
#import "XYPlanDetailController.h"
#import "XYSanBidDetailController.h"
#import "XYTransportDetailController.h"

#import "XYHomePlanCell.h"
#import "XYSanBidCell.h"
#import "XYSanBidModel.h"
#import "XYTransportCell.h"
#import "XYTransportModel.h"
#import "XYPlanModel.h"
#import "XYHomeLDBCell.h"
#import "XYHomePlanTXCell.h"
#import "LYDPlanDetailController.h"
#import "NewBidDetailController.h"
#import "toolsimple.h"
#import "XYHomePlanTXCellFirst.h"
#import "XYHomeLDBCellFirst.h"
#import "XYExperienceController.h"
#import "XYExperienceControllerLiCai.h"
#import "XYHomePlanTXCellFirstXSTY.h"
#import "FenxiaoHuoDongViewController.h"
#import "NewcomerInvestmentVC.h"

@interface XYMoneyController () <UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) XYMainScrollView  *mainSV;

@property (nonatomic, strong) UIView        *headBtnView;
@property (nonatomic, strong) UIButton      *planButton;
@property (nonatomic, strong) UIButton      *sanBidButton;
@property (nonatomic, strong) UIButton      *transportButton;
@property (nonatomic, strong) UIView        *bottomLineView;

@property (nonatomic, strong) UIView        *planHeadView;
@property (nonatomic, strong) UIImageView        *planHeadBGV;
@property (nonatomic, strong) UIImageView   *planHeadHintIV;
@property (nonatomic, strong) UILabel       *planPersonTextLabel;
@property (nonatomic, strong) UILabel       *planPersonLabel;
@property (nonatomic, strong) UILabel       *planTotalTextLabel;
@property (nonatomic, strong) UILabel       *planTotalLabel;
@property (nonatomic, strong) UITableView   *planTableView;
@property (nonatomic, assign) NSInteger     planPageNum;
@property (nonatomic, copy) NSMutableArray  *plansArr;

@property (nonatomic, strong) UITableView   *sanBidTableView;
@property (nonatomic, assign) NSInteger     sanBidPageNum;
@property (nonatomic, copy) NSMutableArray  *sanBidsArr;

@property (nonatomic, strong) UIView        *transportHeadView;
@property (nonatomic, strong) UIView        *transportHeadBGV;
@property (nonatomic, strong) UIImageView   *transportHeadHintIV;
@property (nonatomic, strong) UILabel       *transportPersonTextLabel;
@property (nonatomic, strong) UILabel       *transportPersonLabel;
@property (nonatomic, strong) UILabel       *transportTotalTextLabel;
@property (nonatomic, strong) UILabel       *transportTotalLabel;
@property (nonatomic, strong) UITableView   *transportTableView;
@property (nonatomic, assign) NSInteger     transportPageNum;
@property (nonatomic, copy) NSMutableArray  *transportsArr;
@property (nonatomic, strong) UIImageView   *btnXuanfu;
@property (nonatomic, copy) NSDictionary  *gongxiangDic;
@end

@implementation XYMoneyController

- (NSMutableArray *)plansArr
{
    if (!_plansArr) {
        _plansArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _plansArr;
}

- (NSMutableArray *)sanBidsArr
{
    if (!_sanBidsArr) {
        _sanBidsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _sanBidsArr;
}

- (NSMutableArray *)transportsArr
{
    if (!_transportsArr) {
        _transportsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _transportsArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   [self IsUpdate];
    self.title = @"投资理财";
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.planPageNum = 1;
    self.sanBidPageNum = 1;
    self.transportPageNum = 1;
    
    [self createUI];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        [self loadPlanData];
        [self getGongxiangData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
   [self IsUpdate];
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadOtherInfo];
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
    return 3;
}





//#pragma mark - 网络加载数据----------------------
//#pragma mark  加载理财的数据--------------
//- (void)loadPlanData
//{
//    NSString *timestamp = [LYDTool createTimeStamp];
//    NSDictionary *secretDict = @{@"loneType":[NSNumber numberWithInteger:1],@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:15]};
//    
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *para = @{@"loneType":[NSNumber numberWithInteger:1],@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:15],@"sign":sign};
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





#pragma mark - 网络加载数据----------------------
#pragma mark  加载理财的数据--------------
- (void)loadPlanData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"loneType":[NSNumber numberWithInteger:1],@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:15]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"loneType":[NSNumber numberWithInteger:1],@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:15],@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plansNew",APIPREFIX] parameters:para success:^(id data) {
        [self.planTableView.header endRefreshing];
        [self.planTableView.footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        //bidType   1零定宝
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.planPageNum == 1) {
                [self.plansArr removeAllObjects];
            }
            if ([[backData valueForKey:@"planList"] count] == 0) {
                [self.planTableView.footer noticeNoMoreData];
                [self.planTableView.header endRefreshing];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"planList"]) {
                    XYPlanModel *model = [[XYPlanModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.plansArr addObject:model];
                }
                
                if (self.plansArr.count < 10) {
                    [self.planTableView.footer noticeNoMoreData];
                }
                [self.planTableView reloadData];
            }
            
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorDataHandleWithOperation:operation];
    }];
    
    
}




#pragma mark 加载散标数据------------
- (void)loadSanBidData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.sanBidPageNum],@"pageSize":[NSNumber numberWithInteger:10],@"bidsType":@"4"};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.sanBidPageNum],@"pageSize":[NSNumber numberWithInteger:10],@"bidsType":@"4",@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/bids",APIPREFIX] parameters:para success:^(id data) {
        [self.sanBidTableView.header endRefreshing];
        [self.sanBidTableView.footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            // 如果第一页加载
            if (self.sanBidPageNum == 1) {
                [self.sanBidsArr removeAllObjects];
            }
            
            if ([[backData valueForKey:@"bidsList"] count] == 0) {
                [self.sanBidTableView.footer noticeNoMoreData];
                [self.sanBidTableView.header endRefreshing];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"bidsList"]) {
                    XYSanBidModel *model = [[XYSanBidModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.sanBidsArr addObject:model];
                }
                
                if (self.sanBidsArr.count < 10) {
                    [self.sanBidTableView.footer noticeNoMoreData];
                }
                [self.sanBidTableView reloadData];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
            
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorDataHandleWithOperation:operation];
    }];
    
}

#pragma mark 加载债权转让的数据------------
- (void)loadTransportData
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:10]};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"pageIndex":[NSNumber numberWithInteger:self.planPageNum],@"pageSize":[NSNumber numberWithInteger:10],@"sign":sign};
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/transfers",APIPREFIX] parameters:para success:^(id data) {
        [self.transportTableView.header endRefreshing];
        [self.transportTableView.footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            if (self.transportPageNum == 1) {
                [self.transportsArr removeAllObjects];
            }
            if ([[backData valueForKey:@"transferList"] count] == 0) {
                [self.transportTableView.footer noticeNoMoreData];
                [self.transportTableView.header endRefreshing];
            } else {
                for (NSDictionary *dict in [backData valueForKey:@"transferList"]) {
                    XYTransportModel *model = [[XYTransportModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.transportsArr addObject:model];
                }
                if (self.transportsArr.count < 10) {
                    [self.transportTableView.footer noticeNoMoreData];
                }
                [self.transportTableView reloadData];
            }
        } else if ([[backData valueForKey:@"code"] integerValue] == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:[backData valueForKey:@"message"] andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self errorDataHandleWithOperation:operation];
    }];
    
}

#pragma mark 加载人数与总投资金额等数据
- (void)loadOtherInfo {
    // 设置参数
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN};
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN, @"sign":sign};
    // 设置请求的URL
    NSString *url = [NSString stringWithFormat:@"%@/product/statistics", APIPREFIX];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            
            
            NSInteger planPersonCount = 0;
            if (![backData[@"personCount"] isKindOfClass:[NSNull class]]) {
                planPersonCount = [backData[@"personCount"] integerValue];
            }
            
            CGFloat totalInvestAmount = 0;
            if (![backData[@"totalInvestAmount"] isKindOfClass:[NSNull class]]) {
                totalInvestAmount = [backData[@"totalInvestAmount"] floatValue];
            }
            
            CGFloat totalInvestCumulativeEarning = 0;
            if (![backData[@"totalInvestCumulativeEarning"] isKindOfClass:[NSNull class]]) {
                totalInvestCumulativeEarning = [backData[@"totalInvestCumulativeEarning"] floatValue];
            }
            
            CGFloat publishedAmount = 0;
            if (![backData[@"publishedAmount"] isKindOfClass:[NSNull class]]) {
                publishedAmount = [backData[@"publishedAmount"] floatValue];
            }
            
            CGFloat successAmount = 0;
            if (![backData[@"successAmount"] isKindOfClass:[NSNull class]]) {
                successAmount = [backData[@"successAmount"] floatValue];
            }
//            NSLog(@"totalInvestAmount%@",totalInvestAmount);
            
            
            
            NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
            [numberFormatter1 setFormatterBehavior: NSNumberFormatterBehavior10_4];
            [numberFormatter1 setNumberStyle: NSNumberFormatterDecimalStyle];
            NSString *numberString1 = [numberFormatter1 stringFromNumber: [NSNumber numberWithInteger: totalInvestAmount]];

            // 设置需要显示的数据（累计投资人数）
            self.planPersonLabel.text =numberString1;
            // 累计投资总金额
//            self.planTotalLabel.attributedText = [self showAttributedTextWithText:[NSString stringWithFormat:@"%.0f", totalInvestAmount]];
            
                        //self.planTotalLabel.text = [NSString stringWithFormat:@"%.0f", totalInvestAmount];
            
            
            
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
            [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
            NSString *numberString = [numberFormatter stringFromNumber: [NSNumber numberWithInteger: totalInvestCumulativeEarning]];
            
            
            
          self.planTotalLabel.text = numberString;
            // 累计发布总金额
            self.transportPersonLabel.attributedText = [self showAttributedTextWithText:[NSString stringWithFormat:@"%.0f元", publishedAmount]];
            // 累计成交金额
            self.transportTotalLabel.attributedText = [self showAttributedTextWithText:[NSString stringWithFormat:@"%.0f元", successAmount]];
            
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            // 不必为当前的加载不成功负责
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        NSLog(@"%ld", operation.response.statusCode);
    }];
}

- (NSMutableAttributedString *)showAttributedTextWithText:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(18)] range:NSMakeRange(attributeStr.length - 1, 1)];
    return attributeStr;
}

#pragma mark 网络错误的处理方法
- (void)errorDataHandleWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    [self.sanBidTableView.header endRefreshing];
    [self.sanBidTableView.footer endRefreshing];
    
    id response = LYDJSONSerialization(operation.responseObject);
    NSLog(@"%@",response);
    if ([[response valueForKey:@"code"] integerValue] == 401) {
        [DSYUtils showResponseError_401_ForViewController:self];
        
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}


#pragma mark - UI的创建-----------------------
- (void)createUI
{
//    self.headBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, KHeight(45))];
//    self.headBtnView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.headBtnView];
    
//    self.planButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(0, 0, kSCREENW/3.0, KHeight(45)) title:@"理财计划" titleColor:TEXTBLACK fontOfSystemSize:KWidth(14)];
//    [self.planButton addTarget:self action:@selector(planButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.planButton setTitleColor:ORANGECOLOR forState:UIControlStateSelected];
//    self.planButton.selected = YES;
//    [self.headBtnView addSubview:self.planButton];
//    
//    self.sanBidButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(kSCREENW/3.0, 0, kSCREENW/3.0, KHeight(45)) title:@"散标" titleColor:TEXTBLACK fontOfSystemSize:KWidth(14)];
//    [self.sanBidButton addTarget:self action:@selector(sanBidButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.sanBidButton setTitleColor:ORANGECOLOR forState:UIControlStateSelected];
//    self.sanBidButton.selected = NO;
//    [self.headBtnView addSubview:self.sanBidButton];
//    
//    self.transportButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(kSCREENW/3.0 * 2, 0, kSCREENW/3.0, KHeight(45)) title:@"债权转让" titleColor:TEXTBLACK fontOfSystemSize:KWidth(14)];
//    [self.transportButton addTarget:self action:@selector(transportButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.transportButton setTitleColor:ORANGECOLOR forState:UIControlStateSelected];
//    self.transportButton.selected = NO;
//    [self.headBtnView addSubview:self.transportButton];
    
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.planButton.maxY - 2, kSCREENW/3.0, 2)];
    _bottomLineView.backgroundColor = ORANGECOLOR;
    [self.headBtnView addSubview:_bottomLineView];
    
//    self.mainSV = [[XYMainScrollView alloc] initWithFrame:CGRectMake(0, 64 + KHeight(45), kSCREENW, kSCREENH - 64 - KHeight(45) - 49)];
    self.mainSV = [[XYMainScrollView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH - 64 - 49)];
    self.mainSV.backgroundColor = [UIColor redColor];
    self.mainSV.contentSize = CGSizeMake(kSCREENW * 3, 0);
    self.mainSV.scrollEnabled = NO;
    [self.view addSubview:self.mainSV];
    
    [self createPlanTableView];
    [self createSanBidTableView];
    [self createTransportTableView];
    
    
}

- (void)createPlanTableView
{
    self.planHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(366/2)-KHeight(71))];
    self.planHeadView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    self.planHeadBGV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, kSCREENW, self.planHeadView.height - 20)];
    self.planHeadBGV.backgroundColor = [UIColor whiteColor];
    self.planHeadBGV.image=[UIImage imageNamed:@"Groupzqdd"];
    [self.planHeadView addSubview:self.planHeadBGV];

//    self.planPersonTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.planHeadHintIV.maxY + KHeight(15), kSCREENW / 2, KHeight(11))];
//    self.planPersonTextLabel.textColor = [UIColor colorWithRed:112/255.0 green:206/255.0 blue:250/255.0 alpha:1.00];
//    self.planPersonTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
//    self.planPersonTextLabel.textAlignment = NSTextAlignmentCenter;
//    self.planPersonTextLabel.text = @"累计投资总金额(元)";
//    [self.planHeadBGV addSubview:self.planPersonTextLabel];
//    
//    self.planPersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.planPersonTextLabel.x, self.planPersonTextLabel.maxY + KHeight(10), self.planPersonTextLabel.width, KHeight(24))];
//    self.planPersonLabel.textColor =[UIColor orangeColor];
//    self.planPersonLabel.font = [UIFont systemFontOfSize:KHeight(11)];
//    self.planPersonLabel.textAlignment = NSTextAlignmentCenter;
//    self.planPersonLabel.text = @"100,000";
//    self.planPersonLabel.adjustsFontSizeToFitWidth = YES;
//    [self.planHeadBGV addSubview:self.planPersonLabel];

   
    
    self.planPersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.planHeadHintIV.maxY + KHeight(15), kSCREENW / 2, KHeight(11)+2)];
    self.planPersonLabel.textColor =[UIColor orangeColor];
    self.planPersonLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    self.planPersonLabel.textAlignment = NSTextAlignmentCenter;
    self.planPersonLabel.text = @"100,000";
    self.planPersonLabel.adjustsFontSizeToFitWidth = YES;
    [self.planHeadBGV addSubview:self.planPersonLabel];
    
    
    
    self.planPersonTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.planPersonLabel.x, self.planPersonLabel.maxY + KHeight(10), self.planPersonLabel.width, KHeight(11))];
    self.planPersonTextLabel.textColor = TEXTBLACK;
    self.planPersonTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.planPersonTextLabel.textAlignment = NSTextAlignmentCenter;
    self.planPersonTextLabel.text = @"累计投资总金额";
    [self.planHeadBGV addSubview:self.planPersonTextLabel];
    
    UILabel *lblplanPersonYi = [[UILabel alloc] initWithFrame:CGRectMake(self.planPersonLabel.x, self.planPersonTextLabel.maxY, self.planPersonLabel.width, KHeight(24))];
    lblplanPersonYi.textColor = TEXTBLACK;
    lblplanPersonYi.font = [UIFont systemFontOfSize:KHeight(11)];
    lblplanPersonYi.textAlignment = NSTextAlignmentCenter;
    lblplanPersonYi.text = @"(元)";
    [self.planHeadBGV addSubview:lblplanPersonYi];
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.planPersonLabel.maxX, self.planPersonTextLabel.y, 1, KHeight(44))];
    line.backgroundColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.92 alpha:1.00];
    [self.planHeadBGV addSubview:line];
    
    self.planTotalTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(line.maxX, self.planPersonTextLabel.y, self.planPersonTextLabel.width, self.planPersonTextLabel.height)];
    self.planTotalTextLabel.textColor = TEXTBLACK;
    self.planTotalTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.planTotalTextLabel.textAlignment = NSTextAlignmentCenter;
    //self.planTotalTextLabel.text = @"累计投资总金额(元)";
    self.planTotalTextLabel.text = @"累计赚取总收益";
    [self.planHeadBGV addSubview:self.planTotalTextLabel];
    
    
    
    
    
    
    UILabel *lblplanTotalTextYi = [[UILabel alloc] initWithFrame:CGRectMake(line.maxX, self.planPersonTextLabel.maxY, self.planPersonLabel.width, KHeight(24))];
    lblplanTotalTextYi.textColor = TEXTBLACK;
    lblplanTotalTextYi.font = [UIFont systemFontOfSize:KHeight(11)];
    lblplanTotalTextYi.textAlignment = NSTextAlignmentCenter;
    lblplanTotalTextYi.text = @"(元)";
    [self.planHeadBGV addSubview:lblplanTotalTextYi];
    
    
    
    
    self.planTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.planTotalTextLabel.x, self.planPersonLabel.y, self.planPersonLabel.width, self.planPersonLabel.height)];
    self.planTotalLabel.textColor = [UIColor orangeColor];
    self.planTotalLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    self.planTotalLabel.textAlignment = NSTextAlignmentCenter;
    self.planTotalLabel.adjustsFontSizeToFitWidth = YES;
//    NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:@"500,000"];
//    [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(18)] range:NSMakeRange(totalStr.length - 1, 1)];
//    self.planTotalLabel.attributedText = totalStr;
    self.planTotalLabel.text=@"500,000";
    [self.planHeadBGV addSubview:self.planTotalLabel];
    
    self.planTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, self.mainSV.height) style:UITableViewStyleGrouped];
    self.planTableView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.planTableView.delegate = self;
    self.planTableView.dataSource = self;
    self.planTableView.tableHeaderView = self.planHeadView;
    self.planTableView.separatorColor=[UIColor clearColor];
    self.planTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.planPageNum = 1;
        [self loadPlanData];
        
        [self loadOtherInfo];
        [self getGongxiangData];
    }];
    
    self.planTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.planPageNum += 1;
        [self loadPlanData];
        [self getGongxiangData];
    }];
    
    [self.mainSV addSubview:self.planTableView];
    
    
    self.btnXuanfu=[[UIImageView alloc] init];
    self.btnXuanfu.frame=CGRectMake(ScreenWidth-20-80, ScreenHeight-49-80-20, 80, 80);
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotogongxianghuodong)];
    // 允许用户交互
    self.btnXuanfu.userInteractionEnabled = YES;
    
    [self.btnXuanfu addGestureRecognizer:tap];
    [self.view addSubview:self.btnXuanfu];
    
}









- (void)createSanBidTableView
{
    self.sanBidTableView = [[UITableView alloc] initWithFrame:CGRectMake(kSCREENW, 0, kSCREENW, self.mainSV.height) style:UITableViewStyleGrouped];
    self.sanBidTableView.delegate = self;
    self.sanBidTableView.dataSource = self;
    self.sanBidTableView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    self.sanBidTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.sanBidPageNum = 1;
        [self loadSanBidData];
        [self loadOtherInfo];
    }];
    
    self.sanBidTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.sanBidPageNum += 1;
        [self loadSanBidData];
    }];

    [self.mainSV addSubview:self.sanBidTableView];
}

- (void)createTransportTableView
{
    self.transportHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(315/2))];
    self.transportHeadView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    
    self.transportHeadBGV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kSCREENW, self.transportHeadView.height - 20)];
    self.transportHeadBGV.backgroundColor = [UIColor whiteColor];
    [self.transportHeadView addSubview:self.transportHeadBGV];
    
    self.transportHeadHintIV = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(15), kSCREENW - (KWidth(20) * 2), KHeight(96/2))];
    self.transportHeadHintIV.image = [UIImage imageNamed:@"transportHint"];
    [self.transportHeadBGV addSubview:self.transportHeadHintIV];
    
    self.transportPersonTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.transportHeadHintIV.maxY + KHeight(15), kSCREENW / 2, KHeight(11))];
    self.transportPersonTextLabel.textColor = [UIColor colorWithRed:0.65 green:0.25 blue:0.13 alpha:1.00];
    self.transportPersonTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.transportPersonTextLabel.textAlignment = NSTextAlignmentCenter;
    self.transportPersonTextLabel.text = @"累计发布总金额";
    [self.transportHeadBGV addSubview:self.transportPersonTextLabel];
    
    self.transportPersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.transportPersonTextLabel.x, self.transportPersonTextLabel.maxY + KHeight(10), self.transportPersonTextLabel.width, KHeight(24))];
    self.transportPersonLabel.textColor = [UIColor colorWithRed:0.40 green:0.12 blue:0.01 alpha:1.00];
    self.transportPersonLabel.font = [UIFont systemFontOfSize:KHeight(28)];
    self.transportPersonLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *personStr = [[NSMutableAttributedString alloc] initWithString:@"1,000,000元"];
    [personStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(18)] range:NSMakeRange(personStr.length - 1, 1)];
    self.transportPersonLabel.attributedText = personStr;
    self.transportPersonTextLabel.adjustsFontSizeToFitWidth = YES;
    [self.transportHeadBGV addSubview:self.transportPersonLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(self.transportPersonLabel.maxX, self.transportPersonTextLabel.y, 1, KHeight(44))];
    line.backgroundColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.92 alpha:1.00];
    [self.transportHeadBGV addSubview:line];
    
    self.transportTotalTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(line.maxX, self.transportPersonTextLabel.y, self.transportPersonTextLabel.width, self.transportPersonTextLabel.height)];
    self.transportTotalTextLabel.textColor = [UIColor colorWithRed:0.65 green:0.25 blue:0.13 alpha:1.00];
    self.transportTotalTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.transportTotalTextLabel.textAlignment = NSTextAlignmentCenter;
    self.transportTotalTextLabel.text = @"累计成交总金额";
    [self.transportHeadBGV addSubview:self.transportTotalTextLabel];
    
    self.transportTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.transportTotalTextLabel.x, self.transportPersonLabel.y, self.transportPersonLabel.width, self.transportPersonLabel.height)];
    self.transportTotalLabel.textColor = [UIColor colorWithRed:0.40 green:0.12 blue:0.01 alpha:1.00];
    self.transportTotalLabel.font = [UIFont systemFontOfSize:KHeight(28)];
    self.transportTotalLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:@"500,000元"];
    [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(18)] range:NSMakeRange(totalStr.length - 1, 1)];
    self.transportTotalLabel.attributedText = totalStr;
    self.transportTotalLabel.adjustsFontSizeToFitWidth = YES;
    [self.transportHeadBGV addSubview:self.transportTotalLabel];
    
    self.transportTableView = [[UITableView alloc] initWithFrame:CGRectMake(kSCREENW * 2, 0, kSCREENW, self.mainSV.height) style:UITableViewStyleGrouped];
    self.transportTableView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.transportTableView.delegate = self;
    self.transportTableView.dataSource = self;
    self.transportTableView.tableHeaderView = self.transportHeadView;
    
    self.transportTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.transportPageNum = 1;
        [self loadTransportData];
        [self loadOtherInfo];
    }];
    
    self.transportTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.transportPageNum += 1;
        [self loadTransportData];
    }];
    [self.mainSV addSubview:self.transportTableView];
}

#pragma mark - tableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView == self.planTableView) {
//        return self.plansArr.count;
//    } else if (tableView == self.sanBidTableView) {
//        return self.sanBidsArr.count;
//    } else if (tableView == self.transportTableView) {
//        return self.transportsArr.count;
//    }
//    return 0;
    
    
    
    
    if (tableView == self.planTableView) {
        if (self.plansArr.count>0) {
            if (section==0) {//第一组包括新手体验  新手专享
                return 2;
            }
            else if (section==1)
            {
                 return 4;
            }
            else
            {
                
                return self.plansArr.count-6;//出去4条零定宝和1条新手专享
            }
            
        }
        else
        {
            return 0;
        }

    } else if (tableView == self.sanBidTableView) {
        return self.sanBidsArr.count;
    } else if (tableView == self.transportTableView) {
        return self.transportsArr.count;
    }
    return 0;
    
    
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
        vv.frame=CGRectMake(0, 0, kSCREENW, 0);
    }
    else if(section==1)
    {
        lbltitle.text=@"零定宝-份数标";
    }
    else
    {
    lbltitle.text=@"零定宝-1个月";
    
    }
    
    return vv;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.planTableView) {

        
//        //bidType  1，零定宝    2，新手专享标
//        XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
//        if (tt.bidType.intValue==1) {//零定宝
//            XYHomeLDBCell *cell = [XYHomeLDBCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.plansArr[indexPath.row];
//            return cell;
//        }
//        else  if (tt.bidType.intValue==2)//新手专享标  没有贴息
//        {
//            XYHomePlanCell *cell = [XYHomePlanCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.plansArr[indexPath.row];
//            return cell;
//        }
//
//        else//份数标
//        {
//            XYHomePlanTXCell *cell = [XYHomePlanTXCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.plansArr[indexPath.row];
//            return cell;
//        }
        
        
        
        NSLog(@"%ld",(long)indexPath.row);
        if (indexPath.section==0) {
            if (indexPath.row==0) {//新手体验
                XYHomePlanTXCellFirstXSTY *cell = [XYHomePlanTXCellFirstXSTY cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.plansArr[indexPath.row];
                return cell;
            }
            else//新手专享
            {
                XYHomePlanTXCell *cell = [XYHomePlanTXCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.plansArr[indexPath.row];
                return cell;
                
            }
        }
        else if (indexPath.section==1)//份数标
        {
            if (indexPath.row==0) {
                XYHomePlanTXCellFirst *cell = [XYHomePlanTXCellFirst cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.plansArr[indexPath.row+2];
                return cell;
            }
            else
            {
                XYHomePlanTXCell *cell = [XYHomePlanTXCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.plansArr[indexPath.row+2];
                return cell;
                
            }
        }
        else//零定宝
        {
            if (indexPath.row==0) {
                XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+6]);
                //        if (tt.bidType.intValue==1) {//零定宝
                XYHomeLDBCellFirst *cell = [XYHomeLDBCellFirst cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.plansArr[indexPath.row+6];
                return cell;
            }
            else
            {
                XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+6]);
                //        if (tt.bidType.intValue==1) {//零定宝
                XYHomeLDBCell *cell = [XYHomeLDBCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.plansArr[indexPath.row+6];
                return cell;
                
            }
        
        }
        
        
        
        
        
        
        
    } else if (tableView == self.sanBidTableView) {
        XYSanBidCell *cell = [XYSanBidCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.sanBidsArr[indexPath.row];
        return cell;
    } else if (tableView == self.transportTableView) {
        XYTransportCell *cell = [XYTransportCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.transportsArr[indexPath.row];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.planTableView) {
        //return [XYHomePlanCell cellHeight];
//        XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
//        
//        if (tt.bidType.intValue==1) {
//            return [XYHomeLDBCell cellHeight];
//        }
//        else if (tt.bidType.intValue==2)//新手专享标  没有贴息
//        {
//            return [XYHomePlanCell cellHeight];
//            
//        }
//        else
//        {
//        return [XYHomePlanTXCell cellHeight];
//        
//        }
        
        
        
        
        
        
        XYPlanModel *tt;
        if (indexPath.section==0) {
            tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
            return [XYHomePlanTXCell cellHeight];
        }
        else if (indexPath.section==1)
        {
            tt=(XYPlanModel *)(self.plansArr[indexPath.row+2]);
            return [XYHomePlanTXCell cellHeight];
        }
        else
        {
            tt=(XYPlanModel *)(self.plansArr[indexPath.row+6]);
            return [XYHomeLDBCell cellHeight];
        }
        
        
        
        
        
        
//        if (tt.bidType.intValue==1) {//零定宝
//            XYHomeLDBCell *cell = [XYHomeLDBCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.plansArr[indexPath.row];
//            return cell;
//        }
//        else  if (tt.bidType.intValue==2)//新手专享标  没有贴息
//        {
//            XYHomePlanCell *cell = [XYHomePlanCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.plansArr[indexPath.row];
//            return cell;
//        }
//        
//        else//份数标
//        {
//            XYHomePlanTXCell *cell = [XYHomePlanTXCell cellWithTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.plansArr[indexPath.row];
//            return cell;
//        }

        
        
        
        
        
        
    } else if (tableView == self.sanBidTableView) {
        return [XYSanBidCell cellHeight];
    } else if (tableView == self.transportTableView) {
        return [XYTransportCell cellHeight];
    }
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.sanBidTableView) {
        return KHeight(10.0f);
    }
    else if(tableView == self.planTableView)
    {
      
        if (section==0) {
            return 0;
        }
        else
        {
            return 25;
        }
        
    }else
    {
    
    return 25;
    
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([TOKEN length] == 0) {
        [self pushToLoginController];
    } else {
        if (tableView == self.planTableView) {

            if (indexPath.section==0) {
                XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row]);
                //bidType  1，零定宝    2，新手专享标
                if (tt.bidType.intValue==1) {
                    
                    NSString *timestamp = [LYDTool createTimeStamp];
                    
                    NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                    // 生成签名认证
                    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                    NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
                    
                    // 开始请求数据
                    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                        id backData = LYDJSONSerialization(data);
                        
                        if ([[backData valueForKey:@"code"] integerValue] == 200) {
                            
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

                    // 新手体验标
                    //XYExperienceControllerLiCai *experienceVC = [[XYExperienceControllerLiCai alloc] init];
                    //XYSanBidModel  *sbmodel=[[XYSanBidModel alloc] init];
                    NewcomerInvestmentVC *comer=[[NewcomerInvestmentVC alloc]init];
                     XYSanBidModel  *sbmodel=[[XYSanBidModel alloc] init];
                    sbmodel.periods=tt.periods;
                    sbmodel.apr=tt.apr;
                    sbmodel.periodUnit=tt.periodUnit;
                    sbmodel.minAmount=tt.minAmount;
                    sbmodel.bidId=tt.planId;
                    sbmodel.bidType=tt.bidType;
                    sbmodel.title=tt.title;
                    
                    
                    
                    comer.model = sbmodel;
                    comer.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:comer animated:YES];
                
                }
            }
            else if (indexPath.section==1)
            {
            
                XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+2]);
                //bidType  1，零定宝    2，新手专享标
                if (tt.bidType.intValue==1) {
                    
                    NSString *timestamp = [LYDTool createTimeStamp];
                    
                    NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                    // 生成签名认证
                    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                    NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
                    
                    // 开始请求数据
                    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                        id backData = LYDJSONSerialization(data);
                        
                        if ([[backData valueForKey:@"code"] integerValue] == 200) {
                            
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
                    NSString *timestamp = [LYDTool createTimeStamp];
                    NSDictionary *secretDict = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
                    // 生成签名认证
                    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
                    NSDictionary *para = @{@"bidType":tt.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
                    
                    // 开始请求数据
                    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,tt.planId] parameters:para success:^(id data) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                        id backData = LYDJSONSerialization(data);
                        
                        if ([[backData valueForKey:@"code"] integerValue] == 200) {
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
                XYPlanModel *tt=(XYPlanModel *)(self.plansArr[indexPath.row+6]);
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
//                                    XYPlanDetailController *detailVC = [[XYPlanDetailController alloc] init];
//                                    detailVC.model = self.plansArr[indexPath.row];
//                                    detailVC.hidesBottomBarWhenPushed = YES;
//                                    [self.navigationController pushViewController:detailVC animated:YES];
                    
                    
                    
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
            
            
            
        } else if (tableView == self.sanBidTableView) {
            XYSanBidDetailController *sanDetailVC = [[XYSanBidDetailController alloc] init];
            sanDetailVC.model = self.sanBidsArr[indexPath.row];
            sanDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:sanDetailVC animated:YES];
        } else if (tableView == self.transportTableView) {
            XYTransportDetailController *sanDetailVC = [[XYTransportDetailController alloc] init];
            sanDetailVC.model = self.transportsArr[indexPath.row];
            sanDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:sanDetailVC animated:YES];
        }
    }

    
    
    
    
}









-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.planTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.planTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.planTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.planTableView setLayoutMargins:UIEdgeInsetsZero];
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


#pragma mark - button点击方法
- (void)planButtonClick:(UIButton *)button
{
    
    _planButton.selected = YES;
    _sanBidButton.selected = NO;
    _transportButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.mainSV.contentOffset = CGPointMake(0, 0);
        _bottomLineView.x = 0;
    }];
    
    if (self.plansArr.count == 0) {
        [self loadPlanData];
        [self getGongxiangData];
    }
    
}

- (void)sanBidButtonClick:(UIButton *)button
{
    _planButton.selected = NO;
    _sanBidButton.selected = YES;
    _transportButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.mainSV.contentOffset = CGPointMake(kSCREENW, 0);
        _bottomLineView.x = kSCREENW/3.0;
    }];
    
    if (self.sanBidsArr.count == 0) {
        [self loadSanBidData];
    }
}

- (void)transportButtonClick:(UIButton *)button
{
    _planButton.selected = NO;
    _sanBidButton.selected = NO;
    _transportButton.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.mainSV.contentOffset = CGPointMake(kSCREENW * 2, 0);
        _bottomLineView.x = kSCREENW/3.0 * 2;
    }];
    
    if (self.transportsArr.count == 0) {
        [self loadTransportData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
