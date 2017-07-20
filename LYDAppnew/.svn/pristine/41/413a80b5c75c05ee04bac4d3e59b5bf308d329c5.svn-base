//
//  RBServiceCenterViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/3.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBServiceCenterViewController.h"

@interface RBServiceCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *leftDataArray;
@property (nonatomic, strong) NSArray *rightDataArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation RBServiceCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"客服中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    _leftDataArray = @[@"新浪微博号", @"微信公众号", @"客服热线", @"客服邮箱"];
    _rightDataArray = @[@"零用贷金融", @"lingyongdai178", @"400-860-8858", @"lyd@lingyongdai.com"];
    _imageArray = @[@"service_sina", @"service_wechat", @"service_callphone", @"service_email"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _leftDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"RBMoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = rgba(194, 183, 176, 1);
        
        cell.detailTextLabel.font = cell.textLabel.font;
        cell.detailTextLabel.textColor = rgba(102, 102, 102, 1);
        
    }
    
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.textLabel.text = _leftDataArray[indexPath.row];
    cell.detailTextLabel.text = _rightDataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
#if TARGET_IPHONE_SIMULATOR//模拟器
        NSLog(@"模拟器");
#elif TARGET_OS_IPHONE//真机
        NSMutableString * phoneString = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4008608858"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];

#endif

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
