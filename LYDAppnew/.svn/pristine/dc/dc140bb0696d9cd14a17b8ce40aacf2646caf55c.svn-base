//
//  RBSecurityCenterViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBSecurityCenterViewController.h"
#import "RBModifyPasswordViewController.h"

@interface RBSecurityCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation RBSecurityCenterViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"安全中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createUI];
}

- (void)createUI {
    [self.dataArray addObjectsFromArray:@[@"修改登录密码", @"开户"]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavMaxY, kSCREENW, kSCREENH-NavMaxY) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"RBSecurityCenterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = rgba(102, 102, 102, 1);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RBModifyPasswordViewController *modifyPasswordVC = [[RBModifyPasswordViewController alloc] init];
        [self.navigationController pushViewController:modifyPasswordVC animated:YES];
    } else {
        if ([DSYAccount sharedDSYAccount].ipsAccount.length == 16) {
            [MBProgressHUD showError:@"您已有账户，无需再开户" toView:self.view];
        } else {
            DSYOpenAccountController *openVC = [[DSYOpenAccountController alloc] init];
            [self.navigationController pushViewController:openVC animated:YES];
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KHeight(45.f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}


@end
