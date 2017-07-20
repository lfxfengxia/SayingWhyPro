//
//  MyViewController.m
//  LYDApp
//
//  Created by fcl on 2017/6/30.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "MyViewController.h"
#import "toolsimple.h"
#import "DSYAccountCenterController.h"
#import "XiaoXiViewController.h"
#import "SheZhiAnQuanViewController.h"
#import "DSYAskFriendsViewController.h"
#import "XYRegisterController.h"
#import "UIButton+WebCache.h"
@interface MyViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)UIButton *btnHeader;
@property(nonatomic,strong)UIView *uvBtn;
@property(nonatomic,strong)UILabel *accountNameLabel;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)UILabel *lblNEW;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1/1.0];;
    [self createUI];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [self IsUpdate];
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO];
    //界面状态控制
    [self StareShow];
    if ([TOKEN length] == 0) {
      //[self pushToLoginController];
    }
    else
    {
    [self loadData];
    }
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


-(void)denglu
{
    
    XYLoginController *login=[[XYLoginController alloc] init];
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
    
    
}



- (void)loadData
{
    [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
    NSString *timestamp = [LYDTool createTimeStamp];
    
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign};
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/user/getAccountInfo",APIPREFIX] parameters:para success:^(id data) {
        [self.tableView.header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
//        for (NSDictionary *dict in [backData valueForKey:@"newsList"]) {
//            WenTiModel *model = [[WenTiModel alloc] init];
//            [model setValuesForKeysWithDictionary:dict];
//            [self.dataArr addObject:model];
//        }
       // [self.tableView reloadData];
        self.data=backData;
        [_tableView reloadData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [self.tableView.header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
        //        [self.tableView.header endRefreshing];
        //        [self.tableView.footer endRefreshing];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        return 0;
    }
    else
    {
        return 10;
    }
    
}

- (void)createUI {
    
    
    UIImageView *tableheader=[[UIImageView alloc] init];
    tableheader.frame=CGRectMake(0, 0, kSCREENW,KHeight(212));
    
    tableheader.userInteractionEnabled=YES;
    tableheader.image=[UIImage imageNamed:@"我的登录背景"];
    
    
    _btnHeader=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnHeader addTarget:self action:@selector(GoGerenzhongxin) forControlEvents:UIControlEventTouchUpInside];
    _btnHeader.frame=CGRectMake((kSCREENW-KWidth(64))/2, KHeight(40), KWidth(64), KHeight(64));
    [_btnHeader setImage:[UIImage imageNamed:@"我的未登录头像"] forState:UIControlStateNormal];
    _btnHeader.layer.cornerRadius=KWidth(64)/2;
    _btnHeader.clipsToBounds=YES;
    [tableheader addSubview:_btnHeader];
    
    
    
//    if ([TOKEN length] == 0) {
//        [self pushToLoginController];
//    }
//    else
//    {
//        
//        
//        
//    }
    

    
    _accountNameLabel = [[UILabel alloc] init];
    _accountNameLabel.frame = CGRectMake(0, _btnHeader.maxY+KHeight(10), kSCREENW, KHeight(17));
    _accountNameLabel.text = @"用户名";
    _accountNameLabel.textAlignment=NSTextAlignmentCenter;
    _accountNameLabel.font = [UIFont systemFontOfSize:14];
    _accountNameLabel.textColor = [UIColor colorWithRed:255/255.0 green:121/255.0 blue:1/255.0 alpha:1/1.0];

    [tableheader addSubview:_accountNameLabel];
    
    
    _uvBtn=[[UIView alloc] initWithFrame:CGRectMake(0, _btnHeader.maxY+KHeight(29), kSCREENW, KHeight(30))];

    [tableheader  addSubview:_uvBtn];
    
    
    
    UIButton *btnlogin = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btnlogin setTitle:@"登录" forState:(UIControlStateNormal)];
    [btnlogin setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btnlogin.titleLabel.font = [UIFont systemFontOfSize:14];;
    btnlogin.frame = CGRectMake((kSCREENW-68*2-20)/2,0, KWidth(68), KHeight(30));
    btnlogin.backgroundColor = [UIColor orangeColor];
    btnlogin.layer.cornerRadius = 15;
    [btnlogin addTarget:self action:@selector(denglu) forControlEvents:(UIControlEventTouchUpInside)];
    [_uvBtn addSubview:btnlogin];
    
    
    UIButton *btnRegister = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btnRegister setTitle:@"注册" forState:(UIControlStateNormal)];
    [btnRegister setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize:14];;
    btnRegister.frame = CGRectMake(btnlogin.maxX+20,0, KWidth(68), KHeight(30));
    btnRegister.backgroundColor =[UIColor clearColor];
    btnRegister.layer.cornerRadius = 15;
    btnRegister.layer.borderColor=[UIColor orangeColor].CGColor;
    btnRegister.layer.borderWidth=1;
    
    [btnRegister addTarget:self action:@selector(zhuche) forControlEvents:(UIControlEventTouchUpInside)];
    [_uvBtn addSubview:btnRegister];
    
    
    
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame=CGRectMake(0, 0, kSCREENW, kSCREENH-49);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = tableheader;
    _tableView.backgroundColor=  [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1/1.0];
    _tableView.separatorColor=[UIColor clearColor];
    
    
}

-(void)zhuche
{


    XYRegisterController *regist=[[XYRegisterController alloc] init];
    regist.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:regist animated:YES];


}

-(void)GoGerenzhongxin
{
    
    
    if ([TOKEN length] == 0) {
        [self pushToLoginController];
    }
    else
    {
        [self setAvatarBtnClcik];
        
    }
    
    

 //[self editMyAccount];

}


- (void)setAvatarBtnClcik
{
    NSLog(@"设置头像");
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:@"请选择"
                            delegate:self
                            cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}



#pragma mark - ActionSheet 的代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {  //取消
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    // 允许编辑状态
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 0) {
        // 照相
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else {
        // 相册
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark - 图片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    
    NSString *url = [NSString stringWithFormat:@"%@/account/avatar%@", APIPREFIX, [self getMyPara]];
    [LYDTool uploadFileWithUrl:url parameters:nil image:imageData accountId:@"1" success:^(id data) {
        NSLog(@"成功!");
        LYDJSONSerialization(data);
        [picker dismissViewControllerAnimated:YES completion:nil];
        [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
            [self updateData];
        }];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        NSLog(@"失败");
        [MBProgressHUD showError:@"修改头像失败" toView:self.view];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
}


- (NSString *)getMyPara
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSString *str = [NSString stringWithFormat:@"?appKey=%@&deviceId=%@&timestamp=%@&appSecret=123456&token=%@&&sign=%@", APPKEY, DEVICEID, timestamp, TOKEN, sign];
    return str;
}

- (void)updateData {
    
    UIImage *img=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[DSYAccount sharedDSYAccount].avatar]]];
    
    [_btnHeader setImage:img forState:UIControlStateNormal];

//    
//    
//    // 设置图像
//    [self.avatarImgView setImageWithURL:[NSURL URLWithString:[DSYAccount sharedDSYAccount].avatar] placeholderImage:kPlaceholderImg];
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

-(void)StareShow
{
   
    if ([TOKEN length] == 0) {
        _accountNameLabel.hidden=YES;
        _uvBtn.hidden=NO;
         [_btnHeader setImage:[UIImage imageNamed:@"我的未登录头像"] forState:UIControlStateNormal];
        self.tableView.header=nil;
        
    }
    else
    {
        if (!self.tableView.header) {
            self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self loadData];
                }];
        }
        
        _accountNameLabel.hidden=NO;
        _uvBtn.hidden=YES;
        if ([self isBlankString:[DSYAccount sharedDSYAccount].realName]) {
            _accountNameLabel.text = [DSYAccount sharedDSYAccount].mobile;
        }
        else
        {
            
            _accountNameLabel.text = [DSYAccount sharedDSYAccount].realName;
        }
        
        
        
        [_btnHeader setImageWithURL:[NSURL URLWithString:[DSYAccount sharedDSYAccount].avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"我的未登录头像"]];
        

        
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    else
    {
       return 1;
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        
        
        if (indexPath.row==0) {
            static NSString *identify = @"消息";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
                cell.detailTextLabel.font = DSY_NORMALFONT_13;
                _lblNEW = [[UILabel alloc] init];
                _lblNEW.frame = CGRectMake(300, (cell.frame.size.height-15)/2, 30,15);
                _lblNEW.text = @"NEW";
                _lblNEW.textAlignment=NSTextAlignmentCenter;
                _lblNEW.font = [UIFont systemFontOfSize:10];
                _lblNEW.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0];
                _lblNEW.backgroundColor=[UIColor redColor];
                _lblNEW.layer.cornerRadius=8;
                _lblNEW.clipsToBounds=YES;
                [cell.contentView addSubview:_lblNEW];
                
            }
            cell.textLabel.text = @"消息";
            cell.imageView.image = [UIImage imageNamed:@"消息"];
            
            
            if ([self.data[@"code"] floatValue]>0) {
                _lblNEW.hidden=NO;
            }
            else
            {
                _lblNEW.hidden=YES;
            }
            
            
            return cell;
        }
        else
        {
        
            static NSString *identify = @"邀请好友";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
                cell.detailTextLabel.font = DSY_NORMALFONT_13;

                
            }
            cell.textLabel.text = @"邀请好友";
            cell.imageView.image = [UIImage imageNamed:@"邀请好友"];
//            UIImageView  *imglineheng=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, 1)];
//            imglineheng.image=[UIImage imageNamed:@"licai_line_hui"];
            
            
            UIView  *imglineheng=[[UIView alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, 1)];
            //imglineheng.image=[UIImage imageNamed:@"licai_line_hui"];
            imglineheng.backgroundColor=RGB(242, 242, 242);
            
            [cell.contentView addSubview:imglineheng];
            return cell;

        }
        

    }
    else
    {
        static NSString *identify = @"设置与安全";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
            cell.detailTextLabel.font = DSY_NORMALFONT_13;
            
        }
        cell.textLabel.text = @"设置与安全";
        cell.imageView.image = [UIImage imageNamed:@"设置与安全"];
         return cell;
    }
    
    
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        if ([TOKEN length] == 0) {
            [self pushToLoginController];
        }
        else      
        {
           
        
            if (indexPath.section==0) {

                
                if (indexPath.row==0) {
                    XiaoXiViewController *planDetailVC = [[XiaoXiViewController alloc] init];
                    planDetailVC.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:planDetailVC animated:YES];
                }
                else
                {
                    // 邀请好友
                    DSYAskFriendsViewController *friendVC = [[DSYAskFriendsViewController alloc] init];
                    friendVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:friendVC animated:YES];

                
                }
                

            }
            else
            {
                SheZhiAnQuanViewController *SheZhiAnQuan=[[SheZhiAnQuanViewController alloc] init];
                SheZhiAnQuan.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:SheZhiAnQuan animated:YES];
            
            }
    
            
        }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
