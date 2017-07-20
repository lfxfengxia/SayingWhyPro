//
//  DSYBaseViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseViewController.h"

@interface DSYBaseViewController ()

@end

@implementation DSYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
}
- (void)setNavigaTitle:(NSString *)navigaTitle {
    _navigaTitle = [navigaTitle copy];
    self.titleNavigationBarLabel.text = _navigaTitle;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - 设置navigationBar的状态
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, 100, 20);
    self.navigationItem.titleView = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
    self.navigationItem.titleView = titleLabel;
    self.titleNavigationBarLabel = titleLabel;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[DSYImage(@"back_icon.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
