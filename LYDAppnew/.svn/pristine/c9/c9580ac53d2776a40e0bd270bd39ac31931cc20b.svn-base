//
//  DSYAbountUsController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/24.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAbountUsController.h"
#import "DSYAbountUsWebViewController.h"


@interface DSYAbountUsController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;     /**< 主视图 */

@end

@implementation DSYAbountUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigaTitle = @"关于我们";
    
    [self contentTableView];
    
    //    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark contentTableView的创建---------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.rowHeight = kNormalCellHeight;
    }
    return _contentTableView;
}


#pragma mark - contentTableView的DataSource和Delegate
#pragma mark contentTableView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [self creatTableViewCellWithIdentifier:@"about_us" forTitle:@"关于我们"];
        [cell insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentTop)];
        return cell;
    } else if (indexPath.row == 1) {
        return [self creatTableViewCellWithIdentifier:@"safe_protect" forTitle:@"安全保障"];
    } else if (indexPath.row == 2) {
        return [self creatTableViewCellWithIdentifier:@"qualification_honor" forTitle:@"资质荣誉"];
    } else if (indexPath.row == 3) {
        return [self creatTableViewCellWithIdentifier:@"cooperator_pather" forTitle:@"合作伙伴"];
    } else if (indexPath.row == 4) {
        return [self creatTableViewCellWithIdentifier:@"important_events" forTitle:@"大事记"];
    } else if (indexPath.row == 5) {
        return [self creatTableViewCellWithIdentifier:@"contact_us" forTitle:@"联系我们"];
    } else {
        
        static NSString *defaultID = @"defaultTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:defaultID];
        }
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

#pragma mark contentTableView的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DSYAbountUsWebViewController *abountWeb = [[DSYAbountUsWebViewController alloc] init];
        [self.navigationController pushViewController:abountWeb animated:YES];
    }
//    else if (indexPath.row == 1) {
//       
//        DSYSecurityWebViewController *securityVC = [[DSYSecurityWebViewController alloc] init];
//        [self.navigationController pushViewController:securityVC animated:YES];
//    } else if (indexPath.row == 2) {
//        DSYHornorWebViewController *hornorVC = [[DSYHornorWebViewController alloc] init];
//        [self.navigationController pushViewController:hornorVC animated:YES];
//    } else if (indexPath.row == 3) {
//        DSYPartnerWebViewController *partnerVC = [[DSYPartnerWebViewController alloc] init];
//        [self.navigationController pushViewController:partnerVC animated:YES];
//    } else if (indexPath.row == 4) {
//        DSYImportantWebViewController *eventsVC = [[DSYImportantWebViewController alloc] init];
//        [self.navigationController pushViewController:eventsVC animated:YES];
//    } else {
//        DSYContactWebViewController *contactVC = [[DSYContactWebViewController alloc] init];
//        [self.navigationController pushViewController:contactVC animated:YES];
//    }
}

- (UITableViewCell *)creatTableViewCellWithIdentifier:(NSString *)defaultID forTitle:(NSString *)title {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:defaultID];
    
    cell.textLabel.text = title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    [cell insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentBottom)];
    
    return cell;
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
