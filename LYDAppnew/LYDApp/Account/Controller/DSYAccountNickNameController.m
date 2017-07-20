//
//  DSYAccountNickNameController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountNickNameController.h"

#define kTextLightGray_91 rgba(91, 91, 91, 1)

@interface DSYAccountNickNameController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) UIView *settingBGView;       /**< 设置昵称的区域 */
@property (nonatomic, strong) UIView *noticeBGView;        /**< 提示显示区域 */

@property (nonatomic, strong) UITextField *nicknameField;  /**< 昵称输入框 */

@end

@implementation DSYAccountNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    
    [self creatUI];
}

- (void)creatUI {
    [self contentTableView];
    
    [self settingBGView];
    [self nicknameField];
    [self noticeBGView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - property的getter 方法(懒加载)
#pragma mark contentTableView的创建
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, H(44)) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        
        _contentTableView.bounces = NO;
        _contentTableView.rowHeight = H(44);
        _contentTableView.contentSize = CGSizeMake(self.contentTableView.width, self.contentTableView.height);
//        _contentTableView.numberOfSections = 1;
//        _contentTableView.separatorColor = [UIColor grayColor];
        _contentTableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0); // 设置端距，这里表示separator离左边和右边均0像素
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _contentTableView;
}

- (UIView *)settingBGView {
    if (!_settingBGView) {
        _settingBGView = [[UIView alloc] initWithFrame:CGRectMake(X(40), self.contentTableView.maxY + Y(64), (self.view.width - X(80)), H(140))];
        [self.view addSubview:_settingBGView];
//        _settingBGView.backgroundColor = [UIColor greenColor];
    }
    return _settingBGView;
}

- (UITextField *)nicknameField {
    if (!_nicknameField) {
        UILabel *newNicknameShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.settingBGView.width, H(35))];
        [self.settingBGView addSubview:newNicknameShowLabel];
        newNicknameShowLabel.font = DSY_NORMALFONT_16;
        newNicknameShowLabel.textColor = kTextLightGray_91;
        newNicknameShowLabel.text = @"设置新昵称";
        newNicknameShowLabel.textAlignment = NSTextAlignmentCenter;
        
        _nicknameField = [[UITextField alloc] initWithFrame:CGRectMake(0, newNicknameShowLabel.maxY + Y(5), self.settingBGView.width, H(44))];
        [self.settingBGView addSubview:_nicknameField];
        _nicknameField.layer.cornerRadius = X(2);
        _nicknameField.layer.borderColor = TEXTGARY.CGColor;
        _nicknameField.textAlignment = NSTextAlignmentCenter;
        _nicknameField.textColor = kTextLightGray_91;
        _nicknameField.font = DSY_NORMALFONT_18;
        _nicknameField.clipsToBounds = YES;
        _nicknameField.placeholder = @"请输入新昵称";
        _nicknameField.layer.borderWidth = X(0.5);
        
        [_nicknameField addLeftViewWithImage:@"" rightViewWithImage:@"" forWidth:W(3)];
        
        // 创建button
        UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.settingBGView addSubview:postBtn];
        postBtn.frame = CGRectMake(_nicknameField.x, _nicknameField.maxY + Y(10), _nicknameField.width, _nicknameField.height);
        postBtn.backgroundColor = ORANGECOLOR;
        postBtn.layer.cornerRadius = X(2);
        postBtn.titleLabel.font = DSY_NORMALFONT_18;
        [postBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        [postBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        
        [postBtn addTarget:self action:@selector(postBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _nicknameField;
}


- (UIView *)noticeBGView {
    if (!_noticeBGView) {
        _noticeBGView = [[UIView alloc] initWithFrame:CGRectMake(self.settingBGView.x, self.settingBGView.maxY + Y(85), self.settingBGView.width, H(90))];
        [self.view addSubview:_noticeBGView];
        
        UILabel *regularShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _noticeBGView.width, H(20))];
        regularShowLabel.text = @"昵称设置规则";
        regularShowLabel.font = DSY_NORMALFONT_16;
        regularShowLabel.textColor = rgba(67, 67, 68, 1);
        [_noticeBGView addSubview:regularShowLabel];
        
        
        UILabel *regularLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, regularShowLabel.maxY + Y(10), self.settingBGView.width, H(70))];
        [_noticeBGView addSubview:regularLabel];
        regularLabel.textColor = kTextLightGray_91;
        regularLabel.numberOfLines = 0;
        regularLabel.font = DSY_NORMALFONT_13;
        
        // 设置行间距
        NSString *regularStr = @"1.昵称由2-12位字符组成 \n2.昵称只能包含数字或字母或汉字，或数字、字母、汉字组合";
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:regularStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:Y(10)];
        [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, regularStr.length)];
        regularLabel.attributedText = attributeString;
    }
    return _noticeBGView;
}


//昵称的正则表达式
-(BOOL)nicheng:(NSString *)str
{
    NSString * regex = @"^[A-Za-z0-9]{2,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}



#pragma mark - contentTableView的Datasource和Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"nickName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
        cell.textLabel.font = DSY_NORMALFONT_16;
        cell.textLabel.textColor = kTextLightGray_91;
        cell.detailTextLabel.font = DSY_NORMALFONT_16;
        cell.detailTextLabel.textColor =  ORANGECOLOR;
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 设置数据
    cell.textLabel.text = @"当前昵称";
    cell.detailTextLabel.text = [DSYAccount sharedDSYAccount].nickName;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - 自定义方法
- (void)postBtnClick:(UIButton *)sender {
    NSLog(@"--------------------正在提交修改的昵称----------------------");
    
    if (self.nicknameField.text.length < 2) {
        [MBProgressHUD showError:@"您的输入有误，请参照设置规则" toView:self.view];
        return;
    }
    if (self.nicknameField.text.length > 12) {
        [MBProgressHUD showError:@"您的输入有误，请参照设置规则" toView:self.view];
        return;
    }
    
    if ([Helper containChineseWord:self.nicknameField.text]) {
        [MBProgressHUD showError:@"您的输入有误，请参照设置规则" toView:self.view];
        return;
    }
    
    
//        if ([self nicheng:self.nicknameField.text]) {
//            [MBProgressHUD showError:@"您的输入有误，请参照设置规则" toView:self.view];
//            return;
//        }
    
    
//    NSString *timestamp = [LYDTool createTimeStamp];
//    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"nickName":self.nicknameField.text};
//    
//    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
//    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"nickName":self.nicknameField.text, @"sign":sign};
        NSString *url = [NSString stringWithFormat:@"%@/account/nickName?%@", APIPREFIX, [self getUrl]];NSDictionary *para = [self getMyPara];
    
    
    [LYDTool sendPutWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        
        NSInteger statusCode = [backData[@"code"] integerValue];
        
        if (statusCode == 200) {
            
            [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
                [MBProgressHUD showSuccess:@"设置成功" toView:self.view];
                if (self.sucessBlock) {
                    self.sucessBlock();
                }
                [self.contentTableView reloadData];
            }];
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        NSInteger errorData = operation.response.statusCode;
        
        NSLog(@"%zi",operation.response.statusCode);
        
        if (errorData == 401) {
            [DSYUtils showResponseError_401_ForViewController:self];
        } else if (errorData == 404) {
            [DSYUtils showResponseError_404_ForViewController:self message:@"未发现当前用户信息" okHandler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } cancelHandler:^(UIAlertAction *action) {
            }];
        } else if (errorData == 201) {
            [MBProgressHUD showError:@"该昵称已被使用，请重新填写昵称" toView:self.view];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
        
    }];
    
}



- (NSString *)getUrl {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"nickName":self.nicknameField.text};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    
    return [NSString stringWithFormat:@"appKey=%@&timestamp=%@&deviceId=%@&token=%@&nickName=%@&sign=%@", APPKEY, timestamp, DEVICEID, TOKEN,self.nicknameField.text, sign];
}





- (NSDictionary *)getMyPara {
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"nickName":self.nicknameField.text};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"nickName":self.nicknameField.text, @"sign":sign};
    return para;
}





#pragma mark - 设置navigationBar的状态
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, 100, 20);
    self.navigationItem.titleView = titleLabel;
    titleLabel.text = @"我的昵称";
    titleLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[DSYImage(@"back_icon.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    //    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    //    statusBarView.backgroundColor = rgba(249, 195, 56, 1);
    //    [self.view addSubview:statusBarView];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //
    //
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    self.navigationController.navigationBar.tintColor = rgba(249, 195, 56, 1);
    //    self.view.window.frame = CGRectMake(0, 20, self.view.window.frame.size.width, self.view.window.frame.size.height - 20);
    //
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    // 设置
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nicknameField resignFirstResponder];
}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
