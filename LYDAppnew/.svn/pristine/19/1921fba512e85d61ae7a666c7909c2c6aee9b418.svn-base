//
//  LoginStareViewController.m
//  LYDApp
//
//  Created by fcl on 2017/6/29.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "LoginStareViewController.h"
#import "XYRegisterController.h"
#import "XYForgotController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "DSYBindAccountController.h"
#import "XYLoginController.h"
@interface LoginStareViewController ()

@end

@implementation LoginStareViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    if ([TOKEN length] != 0) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGB(245, 245, 245);
    
    [self createUI];
   
}

- (void)createUI
{
    UIImageView *image=[[UIImageView alloc]init];
    image.image=[UIImage imageNamed:@"收益-未登录-图片"];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.top.equalTo(self.view);
        make.height.mas_equalTo(KHeight(350));
    }];
    
    UIButton *registerBtn=[[UIButton alloc]init];
    registerBtn.layer.cornerRadius=18;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:KHeight(15)];
    registerBtn.backgroundColor=RGB(255, 121, 1);
    [registerBtn addTarget:self action:@selector(goToRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(image.mas_bottom).mas_offset(KHeight(24));
        make.size.mas_equalTo(CGSizeMake(KWidth(200), KHeight(40)));
    }];
    

    UIButton *loginBtn=[[UIButton alloc]init];
    loginBtn.layer.cornerRadius=18;
    loginBtn.layer.borderWidth=0.5;
    loginBtn.layer.borderColor=RGB(255, 121, 1).CGColor;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:RGB(255, 121, 1) forState:UIControlStateNormal];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:KHeight(15)];
    loginBtn.backgroundColor=[UIColor clearColor];
    [loginBtn addTarget:self action:@selector(GoToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(registerBtn.mas_bottom).mas_offset(KHeight(14));
        make.size.mas_equalTo(CGSizeMake(KWidth(200), KHeight(40)));

    }];

}

-(void)goToRegister
{
    XYRegisterController *Register=[[XYRegisterController alloc]init];
    Register.fromSource=@"start";
    Register.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:Register animated:YES];
}

-(void)GoToLogin
{
    XYLoginController *login=[[XYLoginController alloc]init];
    login.fromSource=@"start";
    login.hidesBottomBarWhenPushed=YES;
    login.hiddenBackBtn=YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
