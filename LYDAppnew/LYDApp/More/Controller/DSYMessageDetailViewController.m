//
//  DSYMessageDetailViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/12/25.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYMessageDetailViewController.h"
#import "RBMessageModel.h"

@interface DSYMessageDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) UILabel *contentLabel;     /**< 现在需要显示的label */

@end

@implementation DSYMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = self.message.title;
    [self contentTableView];
    
//    [self loadData];
}

- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@/user/message/read", APIPREFIX];
    NSDictionary *para = [self getMyPara];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        // 错误处理方法
        [self errorDealWithOperation:operation];
    }];
}



- (NSDictionary *)getMyPara {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"messageId":self.message.messageId};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"messageId":self.message.messageId, @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        self.contentLabel.text = self.message.body;
        
        if (self.block) {
            self.block();
        }
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
    }
}

#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger errorData = operation.response.statusCode;
    NSLog(@"%zi",operation.response.statusCode);
    if (errorData == 401) {
        // 401错误处理
        [DSYUtils showResponseError_401_ForViewController:self];
    } else if (errorData == 404) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
            [self pushToLoginController];
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}

#pragma mark contentTableView的创建---------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = self.view.backgroundColor;
        _contentTableView.rowHeight = [Helper heightOfString:self.message.body font:[UIFont systemFontOfSize:16.0f] width:self.contentTableView.width - 24] + 24;
    }
    return _contentTableView;
}


#pragma mark - contentTableView的DataSource和Delegate
#pragma mark contentTableView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *defaultID = @"defaultTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:defaultID];
    }
    
    cell.textLabel.backgroundColor = [UIColor whiteColor];
    [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.textLabel.superview).with.insets(UIEdgeInsetsMake(12, 12, 12, 12));
    }];
    self.contentLabel = cell.textLabel;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:16.0f];
    self.contentLabel.text = self.message.body;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark contentTableView的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
