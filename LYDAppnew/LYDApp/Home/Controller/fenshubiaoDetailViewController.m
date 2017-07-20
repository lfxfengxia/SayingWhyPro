//
//  fenshubiaoDetailViewController.m
//  LYDApp
//份数标详情
//  Created by fcl on 2017/6/21.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "fenshubiaoDetailViewController.h"
#import "WenTiCell.h"
#import "WenTiModel.h"
#import "DSYAbountUsWebViewController.h"
#import "BuyFenshuMarkVC.h"
#import "LDBDetailViewController.h"


@interface fenshubiaoDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *headview;
@property (nonatomic, strong) UIView *headtop;
@property (nonatomic, strong) UIImageView *headbottom;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray  *dataArr;
@property(nonatomic,strong)UILabel *periodsLabel;
@property(nonatomic,strong)UILabel *planPersonLabel;
@property(nonatomic,strong)UIWebView *uw;
@property(nonatomic,strong)UILabel *rateLabelAprDiscountLabel;

@end

@implementation fenshubiaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigaTitle = _chanshu.title;
    [self  createUI];
    [self loadData];
    [self loadOtherInfo];
    [self LoadDetailData];

}


//- (void)setModel:(XYPlanModel *)model
//{
//    _model = model;
//
//    [self  createUI];
//    
//}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}



- (void)loadData
{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign};
    
    
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/content/getPlanCategory",APIPREFIX] parameters:para success:^(id data) {
        
         [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        for (NSDictionary *dict in [backData valueForKey:@"newsList"]) {
            WenTiModel *model = [[WenTiModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
//
//        
//        
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.01f;

}




- (void)LoadUI {
    
    //            CGFloat totalInvestAmount = 0;
    //            if (![backData[@"totalInvestAmount"] isKindOfClass:[NSNull class]]) {
    //                totalInvestAmount = [backData[@"totalInvestAmount"] floatValue];
    //            }
    //            NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
    //            [numberFormatter1 setFormatterBehavior: NSNumberFormatterBehavior10_4];
    //            [numberFormatter1 setNumberStyle: NSNumberFormatterDecimalStyle];
    //            NSString *numberString1 = [numberFormatter1 stringFromNumber: [NSNumber numberWithInteger: totalInvestAmount]];
    //
    //            // 设置需要显示的数据（累计投资人数）
    //            self.planPersonLabel.text =numberString1;
    
    
    
//    if (![backData[@"totalInvestAmount"] isKindOfClass:[NSNull class]]) {
//        totalInvestAmount = [backData[@"totalInvestAmount"] floatValue];
//    }
//    NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
//    [numberFormatter1 setFormatterBehavior: NSNumberFormatterBehavior10_4];
//    [numberFormatter1 setNumberStyle: NSNumberFormatterDecimalStyle];
//    NSString *numberString1 = [numberFormatter1 stringFromNumber: [NSNumber numberWithInteger: totalInvestAmount]];
//    
    // 设置需要显示的数据（累计投资人数）
    //self.planPersonLabel.text =_modelData.totalSoldAmount;
    
    
    

    
   // NSString *tt=[NSString stringWithFormat:@"%@",_modelData.totalSoldAmount];
    
    NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
    [numberFormatter1 setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter1 setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberString1 = [numberFormatter1 stringFromNumber: [NSNumber numberWithInteger: [_modelData.totalSoldAmount doubleValue]]];
    
    // 设置需要显示的数据（累计投资人数）
    self.planPersonLabel.text =numberString1;
    
    
    
    //self.planPersonLabel.text=tt;
    
    
        NSString *rateLabel=[NSString stringWithFormat:@"%.2f",[_modelData.apr floatValue]-[_modelData.aprDiscount floatValue]];
        NSString *aprDiscountLabel=[NSString stringWithFormat:@"%.2f%%",[_modelData.aprDiscount floatValue]];
        _rateLabelAprDiscountLabel.text =[NSString stringWithFormat:@"%@%%+%@%%",rateLabel,aprDiscountLabel];
        NSString *Ratastr=[NSString stringWithFormat:@"%.2f%%+%.2f%%",[rateLabel floatValue],[aprDiscountLabel floatValue]];
        NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:Ratastr];
        [str1 addAttribute:NSFontAttributeName value: [UIFont systemFontOfSize:34] range:NSMakeRange(0, rateLabel.length)];
        _rateLabelAprDiscountLabel.attributedText = str1;
         NSString *strperiods=[NSString stringWithFormat:@"限期%@个月",_modelData.periods];
        _periodsLabel.text=strperiods;
        //http://27.115.115.86:8060/product/investRecordPage?bidTypeStr=1&idStr=1
    //   NSString *strurl=[NSString stringWithFormat:@"%@/product/investRecordPage?bidTypeStr=%@&idStr=%@", APIPREFIX,_model.bidType,_model.planId];
    
           NSString *strurl=[NSString stringWithFormat:@"%@/product/investRecordPage?bidTypeStr=%@&idStr=%@",APIPREFIX,_modelData.bidType,_modelData.planId];
    
        NSURL* url = [NSURL URLWithString:strurl];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [_uw loadRequest:request];//加载
    
    
}




- (void)createUI {


    _headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(11)+KHeight(158)+KHeight(11)+KHeight(211))];
    _headview.backgroundColor =[UIColor clearColor];

    _headtop = [[UIView alloc] initWithFrame:CGRectMake((kSCREENW-KWidth(351))/2, KHeight(11), KWidth(351), KHeight(158))];
    _headtop.backgroundColor = RGB(255, 255, 255);

    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake((_headtop.frame.size.width-KWidth(126))/2, KHeight(20), KWidth(126), KHeight(12))];
    img1.image=[UIImage imageNamed:@"Groupyujinianhuan"];
    [_headtop addSubview:img1];





//    NSString *rateLabel=[NSString stringWithFormat:@"%.2f",[_modelData.apr floatValue]-[_modelData.aprDiscount floatValue]];
//    NSString *aprDiscountLabel=[NSString stringWithFormat:@"%.2f%%",[_modelData.aprDiscount floatValue]];



    _rateLabelAprDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, img1.maxY+KHeight(20), kSCREENW, KHeight(34))];
    _rateLabelAprDiscountLabel.textAlignment=NSTextAlignmentCenter;
    _rateLabelAprDiscountLabel.font = [UIFont systemFontOfSize:KHeight(20)];
    _rateLabelAprDiscountLabel.adjustsFontSizeToFitWidth = YES;
//    rateLabelAprDiscountLabel.text =[NSString stringWithFormat:@"%@%%+%@%%",rateLabel,aprDiscountLabel];
    _rateLabelAprDiscountLabel.textColor=ORANGECOLOR;






    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(33), _rateLabelAprDiscountLabel.maxY+KHeight(20), (_headtop.frame.size.width-4*KWidth(33))/3, KHeight(16))];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:12];
    label1.text=@"智能分散";
    label1.textColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];
    label1.layer.borderWidth=1;
    label1.layer.borderColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0].CGColor;
    label1.layer.cornerRadius=5;
    [_headtop addSubview:label1];



    _periodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(label1.maxX+KWidth(33), _rateLabelAprDiscountLabel.maxY+KHeight(20), (_headtop.frame.size.width-4*KWidth(33))/3, KHeight(16))];
    _periodsLabel.textAlignment=NSTextAlignmentCenter;
    _periodsLabel.font = [UIFont systemFontOfSize:12];
    _periodsLabel.textColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];
    _periodsLabel.layer.borderWidth=1;
    _periodsLabel.layer.borderColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0].CGColor;
    _periodsLabel.layer.cornerRadius=5;

//    NSString *strperiods=[NSString stringWithFormat:@"限期%@个月",_modelData.periods];
//    _periodsLabel.text=strperiods;


    [_headtop addSubview:_periodsLabel];


    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(_periodsLabel.maxX+KWidth(33), _rateLabelAprDiscountLabel.maxY+KHeight(20), (_headtop.frame.size.width-4*KWidth(33))/3, KHeight(16))];
    label3.textAlignment=NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:12];
    label3.text=@"省心高息";
    label3.textColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];
    label3.layer.borderWidth=1;
    label3.layer.borderColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0].CGColor;
    label3.layer.cornerRadius=5;
    [_headtop addSubview:label3];



    [_headtop addSubview:_rateLabelAprDiscountLabel];
    [_headview addSubview:_headtop];

    _headbottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, _headtop.maxY+KHeight(11), kSCREENW, KHeight(211))];
    _headbottom.image=[UIImage imageNamed:@"1月标b"];


    UILabel *label= [[UILabel alloc] init];
    label.frame = CGRectMake(0, KHeight(22), kSCREENW,KHeight(19));
    label.text = @"累计售出金额";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    label.textAlignment=NSTextAlignmentCenter;

    [_headbottom addSubview:label];


    _planPersonLabel = [[UILabel alloc] init];
    _planPersonLabel.frame = CGRectMake(0, label.maxY+KHeight(10), kSCREENW, KHeight(28));
    //_planPersonLabel.text = @"￥45,000,931,000";
    _planPersonLabel.font = [UIFont systemFontOfSize:25];
    _planPersonLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
    _planPersonLabel.textAlignment=NSTextAlignmentCenter;
    [_headbottom addSubview:_planPersonLabel];



    _uw=[[UIWebView alloc] init];
    _uw.frame=CGRectMake(0, _planPersonLabel.maxY+KHeight(14), kSCREENW, _headbottom.height-KHeight(40)-(_planPersonLabel.maxY+KHeight(14)));
    _uw.opaque = NO;
    [_uw setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1月标b.png"]]];
    _uw.backgroundColor=[UIColor clearColor];
    //http://27.115.115.86:8060/product/investRecordPage?bidTypeStr=1&idStr=1
//   NSString *strurl=[NSString stringWithFormat:@"%@/product/investRecordPage?bidTypeStr=%@&idStr=%@", APIPREFIX,_model.bidType,_model.planId];
//
//       NSString *strurl=[NSString stringWithFormat:@"http://27.115.115.86:8060/product/investRecordPage?bidTypeStr=%@&idStr=%@",_modelData.bidType,_modelData.planId];
//
//    NSURL* url = [NSURL URLWithString:strurl];//创建URL
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
//    [_uw loadRequest:request];//加载
    [_headbottom addSubview:_uw];










    [_headview addSubview:_headbottom];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, kSCREENH-KHeight(49)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView =_headview;
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(shuaxin)];

    [self.view addSubview:_tableView];
    //[self loadBannerData];

    UIButton  *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(0, kSCREENH-KHeight(49), KWidth(49), KHeight(49));
//    [btn1 setTitle:@"客服" forState:UIControlStateNormal];
    btn1.backgroundColor=[UIColor whiteColor];
    [btn1 setImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(GoKefu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];


    UIButton  *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(btn1.maxX, kSCREENH-KHeight(49), kSCREENW-btn1.maxX, KHeight(49));
    [btn2 setTitle:@"立即抢购" forState:UIControlStateNormal];
    btn2.backgroundColor=[UIColor orangeColor];
    [btn2 addTarget:self action:@selector(Buy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];


}



-(void)GoKefu
{

    // 关于我们
    DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
    aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/help?type=app&type2=cs", APIPREFIX];
    //        aboutUsVC.title = _dataArray[indexPath.row];
    aboutUsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutUsVC animated:YES];

}


-(void)shuaxin
{

    [self loadData];
    //[self loadOtherInfo];
    [self LoadDetailData];

}


#pragma mark 加载人数与总投资金额等数据
- (void)loadOtherInfo {
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
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

            
            CGFloat totalInvestAmount = 0;
//            if (![backData[@"totalInvestAmount"] isKindOfClass:[NSNull class]]) {
//                totalInvestAmount = [backData[@"totalInvestAmount"] floatValue];
//            }
//            NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
//            [numberFormatter1 setFormatterBehavior: NSNumberFormatterBehavior10_4];
//            [numberFormatter1 setNumberStyle: NSNumberFormatterDecimalStyle];
//            NSString *numberString1 = [numberFormatter1 stringFromNumber: [NSNumber numberWithInteger: totalInvestAmount]];
//            
//            // 设置需要显示的数据（累计投资人数）
//            self.planPersonLabel.text =numberString1;
           
            
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            // 不必为当前的加载不成功负责
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        NSLog(@"%ld", operation.response.statusCode);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2+self.dataArr.count;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    if (indexPath.section==0) {
        static NSString *identify = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        cell.textLabel.text=@"产品详情";
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.textLabel.textColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];

        return cell;
    }
    else  if (indexPath.section==1+self.dataArr.count) {
        static NSString *identify = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        cell.textLabel.text=@"更多问题";
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.textLabel.textColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
        return cell;
    }
    else
    {
        
        
        WenTiCell *cell = [WenTiCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArr[indexPath.section-1];
        return cell;
        
        
    
    
    }

    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.section==0) {//@"产品详情";
        return KHeight(44);
    }
    else  if (indexPath.section==1+self.dataArr.count) {//更多问题
        return KHeight(44);
    }
    else
    {
        return [self.dataArr[indexPath.section-1] cellHeight];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {//@"产品详情";
        LDBDetailViewController *planDetailVC = [[LDBDetailViewController alloc] init];
        planDetailVC.model = self.modelData;
        
        [self.navigationController pushViewController:planDetailVC animated:YES];
    }
    else  if (indexPath.section==1+self.dataArr.count) {//更多问题
        DSYAbountUsWebViewController *aboutUsVC = [[DSYAbountUsWebViewController alloc] init];
        aboutUsVC.strurl=[NSString stringWithFormat:@"%@/content/help/faq/list", APIPREFIX];
        
        //        aboutUsVC.title = _dataArray[indexPath.row];
        aboutUsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
    else
    {
       
    }
    
}

-(void)Buy
{
    if ([TOKEN length]==0) {
        [self pushToLoginController];
    }
    else
    {
      [self requestDetail];
    }
    
   
}




-(void)LoadDetailData{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"bidType":_chanshu.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"bidType":_chanshu.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    // 开始请求数据/product/newPlans/{planId}
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/newPlans/%@", APIPREFIX,_chanshu.planId] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        id backData = LYDJSONSerialization(data);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            XYPlanModel   *model=[XYPlanModel baseModelWithDic:backData[@"planModel"]];
            self.modelData=model;
            [self LoadUI];
            [self.tableView reloadData];
            
            
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




-(void)requestDetail{
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"bidType":self.modelData.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"bidType":self.modelData.bidType,@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    // 开始请求数据
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/product/plans/%@", APIPREFIX,self.modelData.planId] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        id backData = LYDJSONSerialization(data);
        
        if ([[backData valueForKey:@"code"] integerValue] == 200) {
            BuyFenshuMarkVC *buy=[[BuyFenshuMarkVC alloc]init];
            buy.myBalance=backData[@"availableBalance"];
            buy.model=[XYPlanModel baseModelWithDic:backData[@"planModel"]];
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
