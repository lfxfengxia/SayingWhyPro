//
//  RBAboutUsViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBAboutUsViewController.h"
#import "DSYAbountUsController.h"

@interface RBAboutUsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation RBAboutUsViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleNavigationBarLabel.text = @"关于我们";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];

}

- (void)createUI {
    [self.dataArray addObjectsFromArray:@[@"关于零用贷", @"大事记"]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.maxY, kSCREENW, kSCREENH-self.navigationController.navigationBar.maxY) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = BgColor;
    [self.view addSubview:_tableView];

    _tableView.tableFooterView = [[UIView alloc] init];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"RBAboutUsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = rgba(102, 102, 102, 1);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYAbountUsController *aboutUsVC = [[DSYAbountUsController alloc] init];
    [self.navigationController pushViewController:aboutUsVC animated:YES];
}

@end
