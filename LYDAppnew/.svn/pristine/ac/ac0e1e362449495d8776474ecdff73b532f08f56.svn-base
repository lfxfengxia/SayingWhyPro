//
//  DSYFinancingInvestmentsController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//  投资组合

#import "DSYFinancingInvestmentsController.h"
#import "DSYFinancingInvestCell.h"

@interface DSYFinancingInvestmentsController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation DSYFinancingInvestmentsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"投资组合";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self contentTableView];
}

#pragma mark - contentTableView的创建
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, self.view.height - 64) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        
        _contentTableView.separatorInset = UIEdgeInsetsZero;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _contentTableView.separatorColor = rgba(236, 232, 227, 1);
        _contentTableView.rowHeight = H(100);
    }
    return _contentTableView;
}

#pragma mark - cotnentTableView的DataSource协议方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSYFinancingInvestCell *cell = [DSYFinancingInvestCell cellForTableView:tableView];
    
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
