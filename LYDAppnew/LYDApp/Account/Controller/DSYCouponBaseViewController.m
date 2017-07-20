//
//  DSYCouponBaseViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYCouponBaseViewController.h"

@interface DSYCouponBaseViewController ()

@end

@implementation DSYCouponBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self contentTableView];
}

#pragma mark contentTableView的创建
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64  - H(45)) style:(UITableViewStylePlain)];
        NSLog(@"%f", kSCREENH);
        [self.view addSubview:_contentTableView];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = rgba(249, 249, 249, 1);
        _contentTableView.bounces = YES;
        _contentTableView.rowHeight = H(132);
    }
    return _contentTableView;
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
