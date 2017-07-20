//
//  XYTransportPlanDetailController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYTransportPlanDetailController.h"
#import "XYTransportDetailModel.h"
#import "XYTransportDetailCell.h"

@interface XYTransportPlanDetailController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView   *planDetailTableView;
@property (nonatomic, assign) NSInteger     planDetailPage;

@end

@implementation XYTransportPlanDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNavigationBarLabel.text = @"项目详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    self.planDetailPage = 1;
    
    [self createPlanDetailTableView];
}



- (void)createPlanDetailTableView
{
    self.planDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH - 64) style:UITableViewStyleGrouped];
    self.planDetailTableView.delegate = self;
    self.planDetailTableView.dataSource = self;
    [self.view addSubview:self.planDetailTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYTransportDetailCell *cell = [XYTransportDetailCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XYTransportDetailCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
