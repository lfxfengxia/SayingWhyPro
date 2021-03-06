//
//  TiYanBiaoDetailViewController.m
//  LYDApp
//
//  Created by fcl on 2017/6/26.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "TiYanBiaoDetailViewController.h"
#import "WenTiCell.h"
#import "WenTiModel.h"
#import "DSYAbountUsWebViewController.h"
#import "LDBDetailViewController.h"
#import "NewcomerInvestmentVC.h"
@interface TiYanBiaoDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *headview;
@property (nonatomic, strong) UIView *headtop;
@property (nonatomic, strong) UIImageView *headbottom;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray  *dataArr;
@property(nonatomic,strong)UILabel *periodsLabel;
@property(nonatomic,strong)UILabel *planPersonLabel;
@property(nonatomic,strong)UIWebView *uw;
@property(nonatomic,strong)UIView   *tankuangView;
@end

@implementation TiYanBiaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.navigaTitle = @"使用体验金";
    [self backui];
    [self loadData];
    [self loadOtherInfo];
     [self  createUI];
}


- (void)setModel:(XYSanBidModel *)model
{
    _model = model;
    
   
    
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}


-(void)backui
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 20, 20);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[btn setTitle:@"上一页" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
}


-(void)backAction
{

    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    _tankuangView=[[UIView alloc] init];
    _tankuangView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
    
    
    _tankuangView.frame = window.bounds;
    
    _tankuangView.userInteractionEnabled=YES;
    
    
    UIImageView *imgtankuang=[[UIImageView alloc] initWithFrame:CGRectMake((_tankuangView.frame.size.width-KWidth(200))/2, (kSCREENH-KHeight(151))/2, KWidth(200), KHeight(151))];
    imgtankuang.userInteractionEnabled=YES;
    imgtankuang.image=[UIImage imageNamed:@"投资成功弹窗"];
    
    UIButton *btnxx=[UIButton buttonWithType:UIButtonTypeCustom];
    btnxx.frame=CGRectMake(0, imgtankuang.frame.size.height-KHeight(30), KWidth(100), KHeight(30));
    [btnxx addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [imgtankuang addSubview:btnxx];
    
    
    
    UIButton *btnGozheche=[UIButton buttonWithType:UIButtonTypeCustom];

    btnGozheche.frame=CGRectMake(btnxx.maxX, imgtankuang.frame.size.height-KHeight(30), KWidth(100), KHeight(30));
    [btnGozheche addTarget:self action:@selector(goTouzi) forControlEvents:UIControlEventTouchUpInside];
    [imgtankuang addSubview:btnGozheche];
    [_tankuangView addSubview:imgtankuang];
//    // 2.添加自己到窗口上
    [window addSubview:_tankuangView];
    
    /*添加手势事件,移除View*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTankuang)];
    [_tankuangView addGestureRecognizer:tapGesture];
}


-(void)fanhui
{
    
    [_tankuangView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dismissTankuang
{
    
    [_tankuangView removeFromSuperview];
}



-(void)goTouzi
{
     [_tankuangView removeFromSuperview];
    NewcomerInvestmentVC *comer=[[NewcomerInvestmentVC alloc]init];
    comer.model = _model;
    comer.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:comer animated:YES];

}


- (void)loadData
{
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
        //        [self.tableView.header endRefreshing];
        //        [self.tableView.footer endRefreshing];
        //
        //
        //
        id response = LYDJSONSerialization(operation.responseObject);
        if ([[response valueForKey:@"code"] integerValue] == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
            
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
    
}


- (void)createUI {
    
    
    _headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, KHeight(11)+KHeight(158)+KHeight(11)+KHeight(211))];
    _headview.backgroundColor =[UIColor clearColor];
    
    _headtop = [[UIView alloc] initWithFrame:CGRectMake((kSCREENW-KWidth(351))/2, KHeight(11), KWidth(351), KHeight(158))];
    _headtop.backgroundColor = RGB(255, 255, 255);
    
    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake((_headtop.frame.size.width-KWidth(126))/2, KHeight(20), KWidth(126), KHeight(12))];
    img1.image=[UIImage imageNamed:@"Groupyujinianhuan"];
    [_headtop addSubview:img1];
    
    NSString *rateLabel=[NSString stringWithFormat:@"%.2f",[_model.apr floatValue]];
    //NSString *aprDiscountLabel=[NSString stringWithFormat:@"%.2f%%",[_model.aprDiscount floatValue]];
    
    
    
    UILabel *rateLabelAprDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, img1.maxY+KHeight(20), kSCREENW, KHeight(34))];
    rateLabelAprDiscountLabel.textAlignment=NSTextAlignmentCenter;
    rateLabelAprDiscountLabel.font = [UIFont systemFontOfSize:KHeight(20)];
    rateLabelAprDiscountLabel.adjustsFontSizeToFitWidth = YES;
    rateLabelAprDiscountLabel.text =[NSString stringWithFormat:@"%@%%",rateLabel];
    rateLabelAprDiscountLabel.textColor=ORANGECOLOR;
    
    
    
    NSString *Ratastr=[NSString stringWithFormat:@"%.2f%%",[rateLabel floatValue]];
    NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:Ratastr];
    [str1 addAttribute:NSFontAttributeName value: [UIFont systemFontOfSize:34] range:NSMakeRange(0, rateLabel.length)];
    rateLabelAprDiscountLabel.attributedText = str1;
    
    
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(33), rateLabelAprDiscountLabel.maxY+KHeight(20), (_headtop.frame.size.width-4*KWidth(33))/3, KHeight(16))];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:12];
    label1.text=@"智能分散";
    label1.textColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];
    label1.layer.borderWidth=1;
    label1.layer.borderColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0].CGColor;
    label1.layer.cornerRadius=5;
    [_headtop addSubview:label1];
    
    
    
    _periodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(label1.maxX+KWidth(33), rateLabelAprDiscountLabel.maxY+KHeight(20), (_headtop.frame.size.width-4*KWidth(33))/3, KHeight(16))];
    _periodsLabel.textAlignment=NSTextAlignmentCenter;
    _periodsLabel.font = [UIFont systemFontOfSize:12];
    _periodsLabel.textColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];
    _periodsLabel.layer.borderWidth=1;
    _periodsLabel.layer.borderColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0].CGColor;
    _periodsLabel.layer.cornerRadius=5;
    
    NSString *strperiods=[NSString stringWithFormat:@"限期%@个月",_model.periods];
    _periodsLabel.text=strperiods;
    
    
    [_headtop addSubview:_periodsLabel];
    
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(_periodsLabel.maxX+KWidth(33), rateLabelAprDiscountLabel.maxY+KHeight(20), (_headtop.frame.size.width-4*KWidth(33))/3, KHeight(16))];
    label3.textAlignment=NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:12];
    label3.text=@"省心高息";
    label3.textColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];
    label3.layer.borderWidth=1;
    label3.layer.borderColor=[UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0].CGColor;
    label3.layer.cornerRadius=5;
    [_headtop addSubview:label3];
    
    
    
    [_headtop addSubview:rateLabelAprDiscountLabel];
    [_headview addSubview:_headtop];
    
    _headbottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, _headtop.maxY+KHeight(11), kSCREENW, KHeight(211))];
    _headbottom.image=[UIImage imageNamed:@"1月标b"];

    
    [_headview addSubview:_headbottom];
    
    
    _uw=[[UIWebView alloc] init];
    _uw.backgroundColor=[UIColor clearColor];
    _uw.frame=CGRectMake(0,(KHeight(211)-KHeight(85))/2 , kSCREENW,KHeight(85));
    //http://27.115.115.86:8060/product/investRecordPage?bidTypeStr=1&idStr=1
    //   NSString *strurl=[NSString stringWithFormat:@"%@/product/investRecordPage?bidTypeStr=%@&idStr=%@", APIPREFIX,_model.bidType,_model.planId];
    _uw.opaque = NO;
    [_uw setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1月标b.png"]]];
    NSString *strurl=[NSString stringWithFormat:@"%@/product/investRecordPage?bidTypeStr=%@&idStr=%@",APIPREFIX,@"4",@"1"];
    
    NSURL* url = [NSURL URLWithString:strurl];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_uw loadRequest:request];//加载
    [_headbottom addSubview:_uw];

    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, kSCREENH-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView =_headview;
    _tableView.separatorColor=[UIColor clearColor];
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
    [btn2  addTarget:self action:@selector(GoTiYanBiao) forControlEvents:UIControlEventTouchUpInside];
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



//到体验标购买页
-(void)GoTiYanBiao
{

    
    NewcomerInvestmentVC *comer=[[NewcomerInvestmentVC alloc]init];
    comer.model = _model;
    comer.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:comer animated:YES];

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
            
            
            CGFloat totalInvestAmount = 0;
            if (![backData[@"totalInvestAmount"] isKindOfClass:[NSNull class]]) {
                totalInvestAmount = [backData[@"totalInvestAmount"] floatValue];
            }
            NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
            [numberFormatter1 setFormatterBehavior: NSNumberFormatterBehavior10_4];
            [numberFormatter1 setNumberStyle: NSNumberFormatterDecimalStyle];
            NSString *numberString1 = [numberFormatter1 stringFromNumber: [NSNumber numberWithInteger: totalInvestAmount]];
            
            // 设置需要显示的数据（累计投资人数）
            self.planPersonLabel.text =numberString1;
            
            
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
        planDetailVC.ZhuanXiangmodel = self.model;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01f;
    
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
