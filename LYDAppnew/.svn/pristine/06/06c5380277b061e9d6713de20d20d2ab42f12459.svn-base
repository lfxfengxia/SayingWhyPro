//
//  XYExperiencePlanDetailController.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYExperiencePlanDetailController.h"
#import "XYExperienceDetailCell.h"

@interface XYExperiencePlanDetailController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView   *planDetailTableView;
@property (nonatomic, copy) NSMutableArray  *planDetailsArr;
@property (nonatomic, assign) NSInteger     planDetailPage;

@end

@implementation XYExperiencePlanDetailController

- (NSMutableArray *)planDetailsArr
{
    if (!_planDetailsArr) {
        _planDetailsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _planDetailsArr;
}

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
    XYExperienceDetailCell *cell = [XYExperienceDetailCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XYExperienceDetailCell cellHeight];
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
