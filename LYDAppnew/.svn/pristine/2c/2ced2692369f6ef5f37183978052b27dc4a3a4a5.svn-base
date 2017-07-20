//
//  DSYBindAccountController.m
//  LYDApp
//
//  Created by dai yi on 2017/1/3.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "DSYBindAccountController.h"
#import "XYRegisterController.h"
#import "DSYBindMobileViewController.h"

@interface DSYBindAccountController ()

@property (nonatomic, strong) UIImage *oldNavigationShadowImg;   /**< 导航栏上的阴影线条 */

@property (nonatomic, strong) XYMainScrollView  *mainScrollView;    /**< 主要视图 */
@property (nonatomic, strong) UILabel *myNavigationTitle;           /**< 导航的title */

@property (nonatomic, strong) UIImageView   *bgImgView;             /**< 背景视图 */
@property (nonatomic, strong) UIImageView   *logoImgView;           /**< logo */

@property (nonatomic, strong) UIImageView *avatarImgView;    /**< 头像 */
@property (nonatomic, strong) UILabel     *nameLabel;        /**< 昵称 */
@property (nonatomic, strong) UIButton    *loginBtn;         /**< 直接登录按钮(已有账号的登录按钮) */
@property (nonatomic, strong) UIButton    *registerBtn;      /**< 注册按钮(创建新账号的按钮) */

@end

@implementation DSYBindAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"账户绑定";
    self.navigationItem.leftBarButtonItem = nil;
    
    
    [self mainScrollView];
    [self myNavigationTitle];
    [self bgImgView];
    [self logoImgView];
    
    [self avatarImgView];
    [self nameLabel];
    [self loginBtn];
    [self registerBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
//    self.oldNavigationShadowImg = self.navigationController.navigationBar.shadowImage;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:(UIBarMetricsDefault)];
//    self.navigationController.navigationBar.shadowImage = self.oldNavigationShadowImg;
}


#pragma mark - 创建UI的控件-----------------------------

#pragma mark mainScrollView的创建------------
- (XYMainScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[XYMainScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}
#pragma mark titleNavigationBarLabel的创建------------
- (UILabel *)myNavigationTitle {
    if (!_myNavigationTitle) {
        _myNavigationTitle = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(51, 51, 51) fontOfSystemSize:W(17.0f) isBold:YES];
        [self.view addSubview:_myNavigationTitle];
        [_myNavigationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(20);
            make.height.mas_equalTo(44);
        }];
        _myNavigationTitle.text = @"账户绑定";
    }
    return _myNavigationTitle;
}

#pragma mark logoImgView的创建------------
- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:self.mainScrollView.bounds];
        [self.mainScrollView addSubview:_bgImgView];
        _bgImgView.image = DSYImage(@"LoginBG.png");
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}

#pragma mark logoView的创建------------
- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithImage:DSYImage(@"Logo.png")];
        [self.bgImgView addSubview:_logoImgView];
        _logoImgView.y  = Y(95);
        _logoImgView.centerX = self.bgImgView.width / 2;
    }
    return _logoImgView;
}

#pragma mark avatarImgView的创建------------
- (UIImageView *)avatarImgView {
    if (!_avatarImgView) {
        _avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.logoImgView.maxY + Y(29), W(72), W(72))];
        [self.bgImgView addSubview:_avatarImgView];
        _avatarImgView.layer.cornerRadius = _avatarImgView.width / 2;
        _avatarImgView.layer.masksToBounds = YES;
        _avatarImgView.centerX = self.bgImgView.width / 2;
        _avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_avatarImgView setImageWithURL:[NSURL URLWithString:self.resp.iconurl] placeholderImage:kPlaceholderImg];
    }
    return _avatarImgView;
}

#pragma mark nameLabel的创建------------
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(X(37.5), self.avatarImgView.maxY, self.bgImgView.width - X(75), H(48)) andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(14.0f)];
        [self.bgImgView addSubview:_nameLabel];
        _nameLabel.text = [NSString stringWithFormat:@"Hi! %@", self.resp.name];
    }
    return _nameLabel;
}


#pragma mark loginBtn的创建------------
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.bgImgView addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgImgView).with.offset(X(37.5));
            make.right.equalTo(self.bgImgView).with.offset(X(-37.5));
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(Y(20));
            make.height.mas_equalTo(kNormalCellHeight);
        }];
        _loginBtn.backgroundColor = ORANGECOLOR;
        [_loginBtn setTitle:@"已用账号" forState:(UIControlStateNormal)];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _loginBtn.layer.cornerRadius = X(3.0);
        
        [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginBtn;
}

#pragma mark registerBtn的创建------------
- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.bgImgView addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.loginBtn.mas_left).with.offset(X(0));
            make.right.equalTo(self.loginBtn.mas_right).with.offset(X(0));
            make.top.equalTo(self.loginBtn.mas_bottom).with.offset(Y(12.5));
            make.height.mas_equalTo(kNormalCellHeight);
        }];
        _registerBtn.backgroundColor = [UIColor whiteColor];
        [_registerBtn setTitle:@"创建新账号" forState:(UIControlStateNormal)];
        [_registerBtn setTitleColor:ORANGECOLOR forState:(UIControlStateNormal)];
        _registerBtn.layer.cornerRadius = X(3.0);
        _registerBtn.layer.borderColor = ORANGECOLOR.CGColor;
        _registerBtn.layer.borderWidth = 1.0f;
        
        [_registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _registerBtn;
}

#pragma mark - 自定义方法---------------------
#pragma mark 已有账号的点击方法--------
- (void)loginBtnClicked:(UIButton *)sender {
    DSYBindMobileViewController *mobileVC = [[DSYBindMobileViewController alloc] init];
    mobileVC.resp = self.resp;
    [self.navigationController pushViewController:mobileVC animated:YES];
}

#pragma mark 创建新账号的点击方法-----
- (void)registerBtnClicked:(UIButton *)sender {
    XYRegisterController *registVC = [[XYRegisterController alloc] init];
    registVC.hidesBottomBarWhenPushed = YES;
    registVC.comeFrom = @"weixin";
    registVC.resp = self.resp;
    [self.navigationController pushViewController:registVC animated:YES];
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
