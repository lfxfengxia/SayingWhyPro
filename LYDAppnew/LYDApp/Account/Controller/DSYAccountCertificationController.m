//
//  DSYAccountCertificationController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/11.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountCertificationController.h"

@interface DSYAccountCertificationController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UITextField *realNameField;
@property (nonatomic, strong) UITextField *carNumberField;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *postBtn;

@end

@implementation DSYAccountCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"实名认证";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    [self contentTableView];
    [self footerView];
    [self postBtn];
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, self.view.height) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.separatorInset = UIEdgeInsetsZero;
        _contentTableView.separatorColor = rgba(239, 239, 239, 1);
        _contentTableView.backgroundColor = rgba(249, 249, 249, 1);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _contentTableView.rowHeight = H(44);
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.bounces = NO;
    }
    return _contentTableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentTableView.width, H(90))];
        self.contentTableView.tableFooterView = _footerView;
        _footerView.backgroundColor = rgba(249, 249, 249, 1);
    
    }
    return _footerView;
}

- (UIButton *)postBtn {
    if (!_postBtn) {
        _postBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.footerView  addSubview:_postBtn];
        _postBtn.frame = CGRectMake(0, 0, W(285), H(44));
        _postBtn.backgroundColor = ORANGECOLOR;
        _postBtn.layer.cornerRadius = X(3);
        _postBtn.titleLabel.font = DSY_NORMALFONT_18;
        [_postBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        [_postBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _postBtn.center = CGPointMake(self.footerView.width / 2, self.footerView.height / 2);
        
        [_postBtn addTarget:self action:@selector(postData:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _postBtn;
}


#pragma mark - contentTAbleView的代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *realID = @"dsyRealName";
    static NSString *carNumberID = @"dsyCarNumber";
    if (indexPath.row == 0) {
         UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:realID];
        
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(12), 0, (self.contentTableView.width - 2 *  X(12)) / 2, cell.contentView.height)];
        [cell.contentView addSubview:showLabel];
        showLabel.text = @"真实姓名";
        showLabel.textColor = rgba(102, 102, 102, 1);
        showLabel.font = DSY_NORMALFONT_14;
        
        self.realNameField = [[UITextField alloc] initWithFrame:CGRectMake(showLabel.maxX, 0, showLabel.width, showLabel.height)];
        [cell.contentView addSubview:self.realNameField];
        self.realNameField.placeholder = @"请输入您的真实姓名";
        self.realNameField.font = [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin];
        self.realNameField.textAlignment = NSTextAlignmentRight;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:carNumberID];
        
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(12), 0, (self.contentTableView.width - 2 *  X(12)) / 2, cell.contentView.height)];
        [cell.contentView addSubview:showLabel];
        showLabel.text = @"身份证号";
        showLabel.textColor = rgba(102, 102, 102, 1);
        showLabel.font = DSY_NORMALFONT_14;
        
        self.carNumberField = [[UITextField alloc] initWithFrame:CGRectMake(showLabel.maxX, 0, showLabel.width, showLabel.height)];
        [cell.contentView addSubview:self.carNumberField];
        self.carNumberField.placeholder = @"请输入您的身份证号";
        self.carNumberField.font = [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin];
        self.carNumberField.textAlignment = NSTextAlignmentRight;
        self.carNumberField.keyboardType = UIKeyboardTypeNumberPad;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

#pragma mark - 提交按钮的点击方法
- (void)postData:(UIButton *)sender {
    self.realNameField.text = [self.realNameField.text stringDeleteBlank];
    self.carNumberField.text = [self.carNumberField.text stringDeleteBlank];
    
    if (self.realNameField.text.length <= 0 || ![Helper justIdentityCard:self.carNumberField.text]) {
        [MBProgressHUD showError:@"请输入完整信息" toView:self.view];
        return;
    }

    [RYFactoryMethod alertWithTitle:@"友情提示" message:[NSString stringWithFormat:@"您的姓名:%@\n您的证号:%@", self.realNameField.text, self.carNumberField.text] forViewController:self okHandler:^(UIAlertAction *action) {
        
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"realName":self.realNameField.text, @"idNumber": self.carNumberField.text};
        
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"realName":self.realNameField.text, @"idNumber": self.carNumberField.text, @"sign":sign};
        
        [MBProgressHUD showMessage:@"正在认证..." toView:self.view];
        [LYDTool sendPutWithUrl:[NSString stringWithFormat:@"%@/account/authentication", APIPREFIX] parameters:para success:^(id data) {
            id backData = LYDJSONSerialization(data);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showSuccess:@"您已成功认证" toView:self.view];
            if (self.sucessBlock) {
                self.sucessBlock();
            }
            
        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
            [MBProgressHUD hideHUDForView:self.view];
            
            id response = LYDJSONSerialization(operation.responseObject);
            NSLog(@"%@", response);
            
            if ([response[@"code"] integerValue] == 401) {
                [DSYUtils showResponseError_401_ForViewController:self];
            } else if ([response[@"code"] integerValue] == 404) {
                [DSYUtils showResponseError_404_ForViewController:self message:@"" okHandler:^(UIAlertAction *action) {
                    [self.navigationController popViewControllerAnimated:YES];
                } cancelHandler:^(UIAlertAction *action) {
                    
                }];
            } else if ([response[@"code"] integerValue] == 201) {
                [MBProgressHUD showError:@"您已认证，无需再次认证" toView:self.view];
            } else {
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
            }
        }];
        
    } cancelHandler:^(UIAlertAction *action) {
        return ;
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.realNameField resignFirstResponder];
    [self.carNumberField resignFirstResponder];
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
