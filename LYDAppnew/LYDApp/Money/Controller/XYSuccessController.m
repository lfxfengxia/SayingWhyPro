//
//  XYSuccessController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/11.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYSuccessController.h"

@interface XYSuccessController ()

@property (nonatomic, strong) UIImageView   *logoIV;
@property (nonatomic, strong) UIImageView   *successIV;

@end

@implementation XYSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"确认投资";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[DSYAccount sharedDSYAccount] updateMyAccountWithComplete:^{
        
    }];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)createUI
{
    self.logoIV = [[UIImageView alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(232/2)) / 2, KHeight(238/2) + 64, KWidth(232 /2), KHeight(150/2))];
    self.logoIV.image = [UIImage imageNamed:@"Logo"];
    [self.view addSubview:self.logoIV];
    
    self.successIV = [[UIImageView alloc] initWithFrame:CGRectMake((kSCREENW - KWidth(340/2)) / 2, self.logoIV.maxY + KHeight(50), KWidth(340/2), KHeight(45/2))];
    self.successIV.image = [UIImage imageNamed:@"confirmSuccess"];
    [self.view addSubview:self.successIV];
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
