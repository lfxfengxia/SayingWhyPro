//
//  DSYAccountCenterController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountCenterController.h"
#import "DSYAccountRealNameController.h"
#import "DSYAccountNickNameController.h"

#import "DSYAccountCertificationController.h"
#import "BDImageCropViewController.h"

#import <CommonCrypto/CommonDigest.h>

@interface DSYAccountCenterController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BDImageCropperDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) UIView *headerBackgroundView; /**< 头部视图的背景视图 */
@property (nonatomic, strong) UIImageView *headerBGView;    /**< 头部内容区域 */

@property (nonatomic, strong) UILabel *navigationTitleLabel;  /**< 导航栏的标题 */

@property (nonatomic,   weak) UIView *avatarShadowView;      /**< 头像阴影 */
@property (nonatomic, strong) UIImageView *avatarImgView;    /**< 头像 */
@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UIButton *logoutBtn;            /**< 退出按钮 */
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation DSYAccountCenterController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    // 获取系统自带滑动手势的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    self.pan = pan;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    //    [self.allVC.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    
    [self creatUI];
    
    // 加载数据
    [self updateData];
}
- (void)creatUI {
    [self headerBackgroundView];
    [self navigationTitleLabel];
    [self headerBGView];
    
    [self avatarImgView];
    
    [self contentTableView];
    [self logoutBtn];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)updateData {
    // 设置图像
    [self.avatarImgView setImageWithURL:[NSURL URLWithString:[DSYAccount sharedDSYAccount].avatar] placeholderImage:kPlaceholderImg];
}

#pragma mark - property的getter 方法（懒加载）
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
        // 添加假数据
    }
    return _dataArr;
}


#pragma mark 页面的创建

- (UIView *)headerBackgroundView {
    if (!_headerBackgroundView) {
        _headerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(220))];
        [self.view addSubview:_headerBackgroundView];
        _headerBackgroundView.userInteractionEnabled = YES;
        _headerBackgroundView.backgroundColor = rgba(249, 195, 56, 1);
    }
    return _headerBackgroundView;
}


- (UIImageView *)headerBGView {
    if (!_headerBGView) {
        _headerBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.headerBackgroundView.width, H(200))];
        [self.headerBackgroundView addSubview:_headerBGView];
        _headerBGView.userInteractionEnabled = YES;
        _headerBGView.image = DSYImage(@"account_headerbackground.png");
    }
    return _headerBGView;
}

- (UILabel *)navigationTitleLabel {
    if (!_navigationTitleLabel) {
        _navigationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.headerBGView.width, (44))];
        [self.headerBGView addSubview:_navigationTitleLabel];
        _navigationTitleLabel.text = @"个人中心";
        _navigationTitleLabel.userInteractionEnabled = YES;
        _navigationTitleLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
        _navigationTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 添加返回按钮
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_navigationTitleLabel addSubview:backBtn];
        backBtn.frame = CGRectMake(X(12), 0, W(25), H(22));
        backBtn.center = CGPointMake(backBtn.centerX, _navigationTitleLabel.centerY);
        [backBtn setImage:DSYImage(@"back_icon.png") forState:(UIControlStateNormal)];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, W(12.5));
        [backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _navigationTitleLabel;
}

- (UIImageView *)avatarImgView {
    if (!_avatarImgView) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W(72), W(72))];
        [self.headerBGView addSubview:bgView];
        bgView.center = CGPointMake(self.headerBGView.centerX, (self.headerBGView.height) / 2);
        bgView.layer.cornerRadius = W(36);
        self.avatarShadowView = bgView;
        [self addShadowForMyAvatar];
        
        _avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, W(72), W(72))];
        [self.headerBGView addSubview:_avatarImgView];
        _avatarImgView.layer.cornerRadius = _avatarImgView.width / 2;
        _avatarImgView.center = CGPointMake(self.headerBGView.centerX, (self.headerBGView.height) / 2);
        _avatarImgView.layer.masksToBounds = YES;
        _avatarImgView.layer.cornerRadius = _avatarImgView.width/2;
        _avatarImgView.userInteractionEnabled = YES;
        _avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setAvatarBtnClcik)];
        [_avatarImgView addGestureRecognizer:tap];
        
        // 创建下部的按钮
        UIButton *setAvatarBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.headerBGView addSubview:setAvatarBtn];
        setAvatarBtn.frame = CGRectMake(_avatarImgView.x, _avatarImgView.maxY + Y(10), _avatarImgView.width, H(22));
        [setAvatarBtn setTitle:@"设置头像" forState:(UIControlStateNormal)];
        [setAvatarBtn setTitleColor:rgba(163, 104, 40, 1) forState:(UIControlStateNormal)];
        setAvatarBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightSemibold];
        [setAvatarBtn addTarget:self action:@selector(setAvatarBtnClcik) forControlEvents:(UIControlEventTouchUpInside)];
        
//        [self addShadowForMyAvatar];
        
    }
    return _avatarImgView;
}


- (UITableView *)contentTableView {
    if (!_contentTableView) {
 
        
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerBackgroundView.maxY, self.view.width, self.view.height - self.headerBackgroundView.maxY) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_contentTableView];
        _contentTableView.backgroundColor = rgba(249, 249, 249, 1);
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.rowHeight = H(44);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        [_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultTableViewCell"];
        
        _contentTableView.separatorColor = self.view.backgroundColor;
        
        _contentTableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0); // 设置端距，这里表示separator离左边和右边均0像素
        
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _contentTableView;
}


- (UIButton *)logoutBtn {
    if (!_logoutBtn) {
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, H(80))];
        self.contentTableView.tableFooterView = footerView;
        footerView.backgroundColor = self.contentTableView.backgroundColor;
        
        _logoutBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [footerView addSubview:_logoutBtn];
        
        _logoutBtn.frame = CGRectMake(0, self.contentTableView.maxY + Y(14), W(350), H(49));
        _logoutBtn.center = CGPointMake(footerView.width / 2, footerView.height / 2);
        _logoutBtn.backgroundColor = ORANGECOLOR;
        _logoutBtn.layer.cornerRadius = X(2);
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
        [_logoutBtn setTitle:@"退出登录" forState:(UIControlStateNormal)];
        [_logoutBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_logoutBtn addTarget:self action:@selector(logoutClcik:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _logoutBtn;
}




#pragma mark - contentTableView的DataSource和Delegate方法
#pragma mark cotnentTableView 的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYAccount *account = [DSYAccount sharedDSYAccount];
    
    static NSString *ID = @"defaultTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
        
        cell.textLabel.font = DSY_NORMALFONT_13;
        cell.detailTextLabel.font = DSY_NORMALFONT_13;
        cell.detailTextLabel.textColor =  TEXTGARY;
        [cell insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentBottom)];
    }
    if (indexPath.row != 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {  // 实名认证
            cell.textLabel.text = @"实名认证";
            if (account.idNumber.length > 0) {
                cell.detailTextLabel.text = @"已认证";
            } else {
                cell.detailTextLabel.text = @"未认证";
            }
        } else {  // 昵称设置
            cell.textLabel.text = @"我的昵称";
            cell.detailTextLabel.text = account.nickName.length > 0 ? account.nickName : @"无";
        }
        
    } else {   // 手机号的设置
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"手机号";
        
        if (account.mobile.length != 11) {
            cell.detailTextLabel.text = @"手机号码有误";
        } else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ **** %@", [account.mobile substringToIndex:3], [account.mobile substringFromIndex:7]];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, H(10))];
    sectionHeader.backgroundColor = self.contentTableView.backgroundColor;
    [sectionHeader insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentBottom)];
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return H(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

#pragma mark contentTableView 的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        DSYAccount *account = [DSYAccount sharedDSYAccount];
        
        if ([Helper justIdentityCard:account.idNumber]) {
            // 已经认证过了
            DSYAccountRealNameController *realNameVC = [[DSYAccountRealNameController alloc] init];
            realNameVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:realNameVC animated:YES];
        } else{
//            // 当前用户为认证过
//            DSYAccountCertificationController *certificationVC = [[DSYAccountCertificationController alloc] init];
//            
//            certificationVC.sucessBlock = ^() {
//                [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
//                    [self updateData];
//                    [self.contentTableView reloadData];
//                }];
//            };
//            
//            [self.navigationController pushViewController:certificationVC animated:YES];
            DSYOpenAccountController *openAccountVC = [[DSYOpenAccountController alloc] init];
            [self.navigationController pushViewController:openAccountVC animated:YES];

            
            
        }
        
    } else if (indexPath.row == 2 && indexPath.section == 0) {
        DSYAccountNickNameController *nickNameVC = [[DSYAccountNickNameController alloc] init];
        nickNameVC.sucessBlock = ^() {
            [self.contentTableView reloadData];
        };
        [self.navigationController pushViewController:nickNameVC animated:YES];
    }
}

#pragma mark - 自定义方法
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
// 登录
- (void)logoutClcik:(UIButton *)sender
{
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN};
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign};
    [MBProgressHUD showMessage:@"正在退出登录" toView:self.view];

    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/passport/logout",APIPREFIX] parameters:para success:^(id data) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        [MBProgressHUD showSuccess:@"退出成功"];
        UserDefaultsWriteObj(@"", @"access-token");
        [self.tabBarController setSelectedIndex:3];
        [self.navigationController popViewControllerAnimated:NO];
        
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        
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
#pragma mark - pan手势的代理
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    //    NSLog(@"%f", self.mainScrollView.contentOffset.x);
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if(self.navigationController.childViewControllers.count == 1){
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchPoint =  [touch locationInView:self.view];
    // 判断滑动的起始点是否在小于左边的100
    if (touchPoint.x > 100 && gestureRecognizer == self.pan) {
        return NO;
    }
    return YES;
}
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger statusCode = [data[@"code"] integerValue];;
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
    }
}
#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
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
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}
#pragma mark - 给头像添加阴影
- (void)addShadowForMyAvatar {
    self.avatarShadowView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.avatarShadowView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.avatarShadowView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.avatarShadowView.layer.shadowRadius = 2;//阴影半径，默认3
    self.avatarShadowView.clipsToBounds = NO;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.avatarShadowView.bounds.size.width;
    
    [path addArcWithCenter:CGPointMake(self.avatarShadowView.width / 2, self.avatarShadowView.height / 2) radius:(width / 2 + 2) startAngle:0 endAngle:180 clockwise:YES];
    
    //设置阴影路径
    self.avatarShadowView.layer.shadowPath = path.CGPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
