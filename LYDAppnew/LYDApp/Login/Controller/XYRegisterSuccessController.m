//
//  XYRegisterSuccessController.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYRegisterSuccessController.h"

@interface XYRegisterSuccessController ()

@property (nonatomic, strong) XYMainScrollView  *mainSV;
@property (nonatomic, strong) UIImageView   *bgIV;
@property (nonatomic, strong) UIImageView   *logoIV;
@property (nonatomic, strong) UILabel       *successLabel;
@property (nonatomic, strong) UILabel       *inviteLabel;
@property (nonatomic, strong) UILabel       *inviterNumLabel;
@property (nonatomic, strong) UILabel       *hintLabel;
@property (nonatomic, strong) UIButton      *openButton;
@property (nonatomic, strong) UIButton      *backButton;


@end

@implementation XYRegisterSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)createUI
{
    self.mainSV = [[XYMainScrollView alloc] initWithFrame:self.view.bounds];
    self.mainSV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainSV];
    
    self.bgIV = [[UIImageView alloc] initWithFrame:self.mainSV.bounds];
    self.bgIV.image = [UIImage imageNamed:@"LoginBG"];
    [self.mainSV addSubview:self.bgIV];
    
    self.logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(260/2), KHeight(252/2), KWidth(230/2), KHeight(150/2))];
    self.logoIV.image = [UIImage imageNamed:@"Logo"];
    [self.mainSV addSubview:self.logoIV];
    
    self.successLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.logoIV.maxY + KHeight(43), kSCREENW - 15, KHeight(22))];
    self.successLabel.font = [UIFont boldSystemFontOfSize:KHeight(23)];
    self.successLabel.textColor = [UIColor colorWithRed:0.42 green:0.69 blue:0.25 alpha:1.00];
    self.successLabel.text = @"恭喜您注册成功！";
    self.successLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainSV addSubview:self.successLabel];
    
    self.inviteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.successLabel.maxY + KHeight(27), kSCREENW - 20, KHeight(30))];
    self.inviteLabel.font = [UIFont systemFontOfSize:KHeight(16.0f)];
    self.inviteLabel.textColor = TEXTBLACK;
    self.inviteLabel.textAlignment = NSTextAlignmentCenter;
    self.inviteLabel.text = @"您的邀请码";
    [self.mainSV addSubview:self.inviteLabel];
    
    self.inviterNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.inviteLabel.maxY + KHeight(25), kSCREENW - 20, KHeight(25))];
    self.inviterNumLabel.font = [UIFont systemFontOfSize:KHeight(34)];
    self.inviterNumLabel.textColor = TEXTBLACK;
    self.inviterNumLabel.textAlignment = NSTextAlignmentCenter;
    self.inviterNumLabel.text = self.code;
    [self.mainSV addSubview:self.inviterNumLabel];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(372/2)) / 2, self.inviterNumLabel.maxY + KHeight(2), KWidth(372/2), KHeight(7))];
    line.image = [UIImage imageNamed:@"bottomLine"];
    [self.mainSV addSubview:line];
    
    self.hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, line.maxY + KHeight(93), kSCREENW - 20, KHeight(36))];
    self.hintLabel.numberOfLines = 2;
    self.hintLabel.font = [UIFont systemFontOfSize:KHeight(15.0f)];
    self.hintLabel.textColor = TEXTBLACK;
    self.hintLabel.textAlignment = NSTextAlignmentCenter;
    self.hintLabel.text = @"恭喜您注册成功！\n您已获得了30,000元体验金!";
    [self.mainSV addSubview:self.hintLabel];
    
    self.openButton = [[UIButton alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(300)) / 2, self.hintLabel.maxY + KHeight(10), KWidth(300), KHeight(44))];
    [self.openButton setBackgroundColor:ORANGECOLOR];
    [self.openButton setTitle:@"立即开户" forState:UIControlStateNormal];
    [self.openButton addTarget:self action:@selector(openButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.openButton.layer.cornerRadius = 2.0f;
    self.openButton.layer.masksToBounds = YES;
    [self.mainSV addSubview:self.openButton];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(300/2) )/ 2, self.openButton.maxY + KHeight(20), KWidth(300/2), KHeight(16))];
    [self.backButton setTitle:@"稍后开户，返回首页" forState:UIControlStateNormal];
    [self.backButton setTitleColor:TEXTGARY forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:KHeight(16.0f)];
    [self.mainSV addSubview:self.backButton];
    
}

- (void)openButtonClicked:(UIButton *)button
{
    DSYOpenAccountController *oppenAcountVC = [[DSYOpenAccountController alloc] initWithType:(DSYOpenAccountControllerFromTypeRegister)];

    [self.navigationController pushViewController:oppenAcountVC animated:YES];
}

- (void)backButtonClicked:(UIButton *)button
{
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.view.alpha = 0;
//        self.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    } completion:^(BOOL finished) {
//        
//        
//        appDelegate.window.rootViewController = [[XYMainTabBarController alloc] init];
//        
//    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
