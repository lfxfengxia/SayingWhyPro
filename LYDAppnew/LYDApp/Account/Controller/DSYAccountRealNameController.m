//
//  DSYAccountRealNameController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountRealNameController.h"
#import "DSYAccountCertificationController.h"

@interface DSYAccountRealNameController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UIView *footerView;

@end

@implementation DSYAccountRealNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 设置导航栏
    [self setupNavigationBar];
    
    [self contentTableView];
    [self footerView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark contentTableView的创建
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height ) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.backgroundColor = [UIColor whiteColor];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.rowHeight = H(44);
        
//        _contentTableView.separatorColor = [UIColor grayColor];
        _contentTableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0); // 设置端距，这里表示separator离左边和右边均0像素
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _contentTableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, self.view.height - self.dataArr.count * H(44))];
        self.contentTableView.tableFooterView = _footerView;
        _footerView.backgroundColor = rgba(249, 249, 249, 1);
    }
    return _footerView;
}

#pragma mark - contentTableView的Datasource和Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"defaultTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
        
        cell.textLabel.font = DSY_NORMALFONT_14;
        cell.textLabel.textColor=TEXTGARY;
        cell.detailTextLabel.font = DSY_NORMALFONT_14;
        cell.detailTextLabel.textColor =  TEXTGARY;
    }
    DSYAccount *account = [DSYAccount sharedDSYAccount];
    
    if (indexPath.row == 0) {
        // 设置的姓名
//        if (account.realName.length <= 1) {
//            cell.textLabel.text = @"***";
//        } else {
//            cell.textLabel.text = [NSString stringWithFormat:@"*%@", [account.realName substringFromIndex:1]];
//        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", account.realName];
    } else {
        if (account.idNumber.length != 18) {
            cell.textLabel.text = @"身份证号有误或需要认证";
        } else {
//            cell.textLabel.text = [NSString stringWithFormat:@"%@********%@", [account.idNumber substringToIndex:6], [account.idNumber substringFromIndex:14]];
            
        cell.textLabel.text = [NSString stringWithFormat:@"%@",account.idNumber];
        }
    }
    
    if (account.idNumber.length > 0) {
        cell.detailTextLabel.text = @"已认证";
    } else {
        cell.detailTextLabel.text = @"未认证";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
       
    }
}

#pragma mark - 设置navigationBar的状态
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, 100, 20);
    self.navigationItem.titleView = titleLabel;
    titleLabel.text = @"实名认证";
    titleLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[DSYImage(@"back_icon.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    //    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    //    statusBarView.backgroundColor = rgba(249, 195, 56, 1);
    //    [self.view addSubview:statusBarView];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //
    //
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    self.navigationController.navigationBar.tintColor = rgba(249, 195, 56, 1);
    //    self.view.window.frame = CGRectMake(0, 20, self.view.window.frame.size.width, self.view.window.frame.size.height - 20);
    //
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    // 设置
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
