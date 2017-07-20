//
//  DSYFinancingAsiignDebtsController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//  债权转让

#import "DSYFinancingAsiignDebtsController.h"
#import "BRPlaceholderTextView.h"
#import "DSYFinancingModel.h"
#import "DSYFinancingDetailController.h"
#import "DSYAssignServiceController.h"

#define kDSYTextGrayColor_102 rgba(102, 102, 102, 1)
#define kDSYTextGrayColor_51  rgba( 51,  51,  51, 1)
#define kDSYTextGrayColor_153 rgba(153, 153, 153, 1)
#define kTextThinFont [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin]

@interface DSYFinancingAsiignDebtsController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UIButton *assignBtn;           /**< 确认按钮 */
@property (nonatomic, strong) UITableView *contentTableView; /**< 主要内容区域 */

@property (nonatomic, strong) UIView *headerView;           /**< 头部视图 */
@property (nonatomic, strong) UILabel *titleLabel;          /**< 债权的title */
@property (nonatomic, strong) UIButton *agreeBtn;           /**< 转让协议 */
@property (nonatomic, strong) UILabel *borrowIdLabel;       /**< 借款标编号 */
@property (nonatomic, strong) UILabel *borrowerNameLabel;   /**< 借款人 */
@property (nonatomic, strong) UILabel *annualRateLabel;     /**< 年利率 */
@property (nonatomic, strong) UILabel *overdueLabel;        /**< 逾期情况 */
@property (nonatomic, strong) UILabel *investAmountLabel;   /**< 投资本金 */
@property (nonatomic, strong) UILabel *receiveAmountLabel;  /**< 待收本金 */

@property (nonatomic, strong) UILabel *totalReceiveAmountLabel;           /**< 本息合计应收金额 */

@property (nonatomic,   weak) UITextField *assignTitleField;              /**< 转让标题 */
@property (nonatomic,   weak) UITextField *assignBaseAmountField;         /**< 待收本金转让底价 */
@property (nonatomic,   weak) UITextField *assignTypeField;               /**< 转让方式 */
@property (nonatomic,   weak) UITextField *assignDeadLineDateField;       /**< 转让期限 */


@property (nonatomic, strong) UIView *footerView;                         /**< footer */
@property (nonatomic, strong) BRPlaceholderTextView *assignReasonField;   /**< 转让原因的输入 */
@property (nonatomic, strong) UILabel *inputNoticeLabel;

@property (nonatomic, strong) UIPickerView *typeKeyboard;
@property (nonatomic, strong) UIPickerView *deadLineKeyboard;

@property (nonatomic, strong) NSMutableArray *typeDataList;     /**< 方式 */
@property (nonatomic, strong) NSMutableArray *dateDataList;     /**< 天数 */

@property (nonatomic, assign) NSInteger transferPeriod;

@end

@implementation DSYFinancingAsiignDebtsController

- (instancetype)initWithFinancing:(DSYFinancingModel *)financing {
    self = [super init];
    if (self) {
        _financing = financing;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"债权转让";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor redColor];
    
    [self creatUI];
    [self.contentTableView reloadData];
    
    [self loadData];
}

- (void)creatUI {
    [self assignBtn];
    
    [self contentTableView];
    
    [self headerView];
    [self titleLabel];
    [self agreeBtn];
    [self borrowIdLabel];
    [self borrowerNameLabel];
    [self annualRateLabel];
    [self overdueLabel];
    [self investAmountLabel];
    [self receiveAmountLabel];
    
    
    [self footerView];
    [self assignReasonField];
    [self inputNoticeLabel];
    
    [self typeKeyboard];
    [self deadLineKeyboard];
}

- (void)setupMyUIWithData:(id)data {
    [self.contentTableView reloadData];
    [self.contentTableView layoutIfNeeded];
    
    
//    self.titleLabel.backgroundColor  = [UIColor redColor];
//    self.agreeBtn.backgroundColor  = [UIColor greenColor];
    
    self.titleLabel.text = data[@"bidTitle"];
    self.borrowIdLabel.text      = [NSString stringWithFormat:@"借款标编号: %@", data[@"bidCode"]];
    self.borrowerNameLabel.text  = [NSString stringWithFormat:@"借款人: %@", data[@"borrowerName"]];
    self.annualRateLabel.text    = [NSString stringWithFormat:@"年利率: %.1f%%", [data[@"bidApr"] floatValue]];
    self.overdueLabel.text       = [NSString stringWithFormat:@"逾期情况: %@", data[@"overdueDesc"]];
    self.investAmountLabel.text  = [NSString stringWithFormat:@"投资本金: %.2f元", [data[@"investCorpus"] floatValue]];
    self.receiveAmountLabel.text = [NSString stringWithFormat:@"待收本息: %.2f元", [data[@"receiveCorpus"] floatValue]];
    self.totalReceiveAmountLabel.text = [NSString stringWithFormat:@"%.2f元", [data[@"receiveAmountTotal"] floatValue]];
    
//    self.assignTitleField.text = @"零定宝-一个月";
    self.assignBaseAmountField.placeholder = @"不大于本金";
//    self.assignTypeField.text = @"方式1";
//    self.assignDeadLineDateField.text = @"2016-11-30";
    
}

- (void)loadData {

    NSString *url = [NSString stringWithFormat:@"%@/user/invests/%ld/detail", APIPREFIX, self.financing.investId];
    NSDictionary *para = [self getMyPara];
    [MBProgressHUD showMessage:@"正在加载数据..." toView:self.view];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
        // 错误处理方法
        [self errorDealWithOperation:operation];
    }];
}




- (NSDictionary *)getMyPara {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"investId":@(self.financing.investId)};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"investId":@(self.financing.investId), @"sign":sign};
    
    //    , @"investId":@(self.financing.investId)
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    [self.contentTableView.footer endRefreshing];
    [self.contentTableView.header endRefreshing];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        [self setupMyUIWithData:data];

    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
        // 如果加载数据有问题就让page恢复
    }
}

#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    [self.contentTableView.footer endRefreshing];
    [self.contentTableView.header endRefreshing];
    NSInteger errorData = operation.response.statusCode;
    NSLog(@"%zi",operation.response.statusCode);
    if (errorData == 401) {
        // 401错误处理
        [DSYUtils showResponseError_401_ForViewController:self];
    } else if (errorData == 404) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"未发现当前信息" okHandler:^(UIAlertAction *action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}

- (NSMutableArray *)typeDataList {
    if (!_typeDataList) {
        _typeDataList = [NSMutableArray arrayWithCapacity:0];
        [_typeDataList addObject:@"方式一"];
        [_typeDataList addObject:@"方式二"];
        [_typeDataList addObject:@"方式三"];
    }
    return _typeDataList;
}

- (NSMutableArray *)dateDataList {
    if (!_dateDataList) {
        _dateDataList = [NSMutableArray arrayWithCapacity:0];
        
        [_dateDataList addObject:@"一天"];
        [_dateDataList addObject:@"二天"];
        [_dateDataList addObject:@"三天"];
        [_dateDataList addObject:@"四天"];
        [_dateDataList addObject:@"五天"];
    }
    return _dateDataList;
}

#pragma mark - property的getter方法(懒加载)
#pragma mark assignBtn的创建-----
- (UIButton *)assignBtn {
    if (!_assignBtn) {
        _assignBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.view addSubview:_assignBtn];
        _assignBtn.frame = CGRectMake(0, self.view.height - 64 - H(60) - H(45), kSCREENW, H(60));
        _assignBtn.backgroundColor = ORANGECOLOR;
        
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _assignBtn.height - Y(22.5), _assignBtn.width, H(20))];
        [_assignBtn addSubview:showLabel];
        showLabel.text = @"确认即视为同意债权转让协议";
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.font = DSY_NORMALFONT_11;
        showLabel.textColor = [UIColor whiteColor];
        showLabel.userInteractionEnabled = NO;
        
        UILabel *okLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, showLabel.y - H(26), kSCREENW, H(26))];
        [_assignBtn addSubview:okLabel];
        okLabel.text = @"确认";
        okLabel.textColor = [UIColor whiteColor];
        okLabel.font = [UIFont systemFontOfSize:W(16.0f) weight:UIFontWeightSemibold];
        okLabel.textAlignment = NSTextAlignmentCenter;
        okLabel.userInteractionEnabled = NO;
        
        [_assignBtn addTarget:self action:@selector(assignBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _assignBtn;
}


#pragma mark contentTableView的创建----------------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, self.assignBtn.y) style:(UITableViewStyleGrouped)];
        [self.view addSubview:_contentTableView];
        
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        
    }
    return _contentTableView;
}

#pragma mark headerView的创建----------------
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(235))];
        self.contentTableView.tableHeaderView = _headerView;
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

#pragma mark titleLabel的创建----------------
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(20), 0, (self.headerView.width - 2 * X(20)) / 2, H(45))];
        [self.headerView addSubview:_titleLabel];
        _titleLabel.textColor = kDSYTextGrayColor_102;
        _titleLabel.font = [UIFont systemFontOfSize:W(16.0f) weight:UIFontWeightSemibold];
    }
    return _titleLabel;
}

#pragma mark agreeBtn的创建----------------
- (UIButton *)agreeBtn {
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.headerView  addSubview:_agreeBtn];
        [_agreeBtn setTitle:@"债权转让协议" forState:(UIControlStateNormal)];
        [_agreeBtn setTitleColor:rgba(42, 149, 231, 1) forState:(UIControlStateNormal)];
        _agreeBtn.frame = CGRectMake(self.titleLabel.maxX, self.titleLabel.y, self.titleLabel.width, self.titleLabel.height);
        _agreeBtn.titleLabel.font = DSY_NORMALFONT_15;
        _agreeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        _agreeBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
//        [_agreeBtn.titleLabel fixSingleWidthForRight];
        _agreeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_agreeBtn addTarget:self action:@selector(agreeBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _agreeBtn;
}


#pragma mark borrowIdLabel的创建------------
- (UILabel *)borrowIdLabel {
    if (!_borrowIdLabel) {
        _borrowIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.maxY, self.titleLabel.width * 2, H(30))];
        [self.headerView addSubview:_borrowIdLabel];
        _borrowIdLabel.textColor = kDSYTextGrayColor_102;
        _borrowIdLabel.font = kTextThinFont;
    }
    return _borrowIdLabel;
}

#pragma mark borrowerNameLabel的创建------------
- (UILabel *)borrowerNameLabel {
    if (!_borrowerNameLabel) {
        _borrowerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.borrowIdLabel.x, self.borrowIdLabel.maxY, self.borrowIdLabel.width, self.borrowIdLabel.height)];
        [self.headerView addSubview:_borrowerNameLabel];
        _borrowerNameLabel.textColor = kDSYTextGrayColor_102;
        _borrowerNameLabel.font = kTextThinFont;
    }
    return _borrowerNameLabel;
}

#pragma mark annualRateLabel的创建------------
- (UILabel *)annualRateLabel {
    if (!_annualRateLabel) {
        _annualRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.borrowerNameLabel.x, self.borrowerNameLabel.maxY, self.borrowerNameLabel.width, self.borrowerNameLabel.height)];
        [self.headerView addSubview:_annualRateLabel];
        _annualRateLabel.textColor = kDSYTextGrayColor_102;
        _annualRateLabel.font = kTextThinFont;
    }
    return _annualRateLabel;
}

#pragma mark overdueLabel的创建------------
- (UILabel *)overdueLabel {
    if (!_overdueLabel) {
        NSLog(@"%f", self.annualRateLabel.maxY);
        _overdueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.annualRateLabel.x, self.annualRateLabel.maxY, self.annualRateLabel.width, self.annualRateLabel.height)];
        [self.headerView addSubview:_overdueLabel];
        _overdueLabel.textColor = kDSYTextGrayColor_102;
        _overdueLabel.font = kTextThinFont;
    }
    return _overdueLabel;
}

#pragma mark investAmountLabel的创建------------
- (UILabel *)investAmountLabel {
    if (!_investAmountLabel) {
        NSLog(@"%f", self.overdueLabel.maxY);
        _investAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.overdueLabel.x, self.overdueLabel.maxY, self.overdueLabel.width, self.overdueLabel.height)];
        [self.headerView addSubview:_investAmountLabel];
        _investAmountLabel.textColor = kDSYTextGrayColor_102;
        _investAmountLabel.font = kTextThinFont;
    }
    return _investAmountLabel;
}

#pragma mark investAmountLabel的创建------------
- (UILabel *)receiveAmountLabel {
    if (!_receiveAmountLabel) {
        _receiveAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.investAmountLabel.x, self.investAmountLabel.maxY, self.investAmountLabel.width, self.investAmountLabel.height)];
        [self.headerView addSubview:_receiveAmountLabel];
        _receiveAmountLabel.textColor = kDSYTextGrayColor_102;
        _receiveAmountLabel.font = kTextThinFont;
    }
    return _receiveAmountLabel;
}

#pragma mark footerView的创建-------------
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(138))];
        self.contentTableView.tableFooterView = _footerView;
        _footerView.backgroundColor = [UIColor whiteColor];
    }
    return _footerView;
}

#pragma mark assignReasonField的创建------------
- (BRPlaceholderTextView *)assignReasonField {
    if (!_assignReasonField) {
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(20), 0, self.footerView.width - 2 * X(20), H(44))];
        [self.footerView addSubview:showLabel];
        showLabel.font = kTextThinFont;
        showLabel.textColor = kDSYTextGrayColor_102;
        showLabel.text = @"转让原因:";
        
        _assignReasonField = [[BRPlaceholderTextView alloc] initWithFrame:CGRectMake(showLabel.x, showLabel.maxY, showLabel.width , H(88))];
        [self.footerView addSubview:_assignReasonField];
        _assignReasonField.textColor = kDSYTextGrayColor_153;
        _assignReasonField.font = kTextThinFont;
        _assignReasonField.layer.cornerRadius = X(3.0);
        _assignReasonField.layer.borderColor = rgba(204, 204, 204, 1).CGColor;
        _assignReasonField.placeholder = @" 请输入不超过200字";
        _assignReasonField.layer.borderWidth = X(1);
        _assignReasonField.delegate = self;
        _assignReasonField.contentInset = UIEdgeInsetsMake(0, 0, W(10), 0);
        
        [_assignReasonField addMaxTextLengthWithMaxLength:200 andEvent:^(BRPlaceholderTextView *text) {
            NSLog(@"%@", text);
        }];
    }
    return _assignReasonField;
}

#pragma mark assignReasonField的创建------------
- (UILabel *)inputNoticeLabel {
    if (!_inputNoticeLabel) {
        _inputNoticeLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(self.assignReasonField.maxX - W(50) - X(5), self.assignReasonField.maxY - Y(20), W(50), H(20)) andTextColor:rgba(172, 172, 172, 1) fontOfSystemSize:W(11.0f)];
        [self.footerView addSubview:_inputNoticeLabel];
        _inputNoticeLabel.text = @"000/000";
        [_inputNoticeLabel fixSingleWidthForRight];
        _inputNoticeLabel.text = @"0/200";
        _inputNoticeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _inputNoticeLabel;
}


#pragma mark - contentTableView的DataSource以及Delegate
#pragma mark contentTAbleView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"本兮合计应收金额"];
        
        cell.textLabel.text = @"本息合计应收金额:";
        cell.textLabel.font = kTextThinFont;
        cell.textLabel.textColor = kDSYTextGrayColor_102;
        
        
        cell.detailTextLabel.textColor = rgba(228, 18, 32, 1);
        cell.detailTextLabel.font = kTextThinFont;
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        self.totalReceiveAmountLabel = cell.detailTextLabel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"转让标题"];
        self.assignTitleField = [self creatTextFieldWithTitle:@"转让标题: " forTableViewCell:cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"待收本金转让底价"];
        
        self.assignBaseAmountField = [self creatTextFieldWithTitle:@"转让底价: " forTableViewCell:cell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
//    else if (indexPath.section == 1 && indexPath.row == 2) {
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"转让方式"];
//        
//        self.assignTypeField = [self creatTextFieldWithTitle:@"转让方式: " forTableViewCell:cell];
//        self.assignTypeField.enabled = NO;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        UIImageView *indicator = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENW - X(35), 0, W(17), H(10))];
//        [cell.contentView addSubview:indicator];
//        indicator.centerY = self.assignTypeField.centerY;
//        indicator.image = DSYImage(@"down_indicator.png");
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickeda:)];
//        indicator.userInteractionEnabled = YES;
//        [indicator addGestureRecognizer:tap];
//        
//        return cell;
//    }
     else if (indexPath.section == 1 && indexPath.row == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"转让期限"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.assignDeadLineDateField = [self creatTextFieldWithTitle:@"转让期限: " forTableViewCell:cell];
        self.assignDeadLineDateField.enabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator'
        UIImageView *indicator = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENW - X(35), 0, W(17), H(10))];
        [cell.contentView addSubview:indicator];
        indicator.userInteractionEnabled = YES;
        indicator.centerY = self.assignDeadLineDateField.centerY;
        indicator.image = DSYImage(@"down_indicator.png");
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickedab:)];
        indicator.userInteractionEnabled = YES;
        [indicator addGestureRecognizer:tap];
        
        return cell;
    } else {
        static NSString *ID = @"defaultTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return H(10);
    } else {
        return 0.000001;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
//            [self addAlertActionWithTitle:@"转让方式" actionArray:self.typeDataList forTextField:self.assignTypeField];
            [self addAlertActionWithTitle:@"转让期限" actionArray:self.dateDataList forTextField:self.assignDeadLineDateField];
        } else if (indexPath.row == 3) {
//            [self addAlertActionWithTitle:@"转让期限" actionArray:self.dateDataList forTextField:self.assignDeadLineDateField];
        }
    }
}

- (void)tapClickeda:(UITapGestureRecognizer *)tap {
    [self addAlertActionWithTitle:@"转让方式" actionArray:self.typeDataList forTextField:self.assignTypeField];
}

- (void)tapClickedab:(UITapGestureRecognizer *)tap {
    [self addAlertActionWithTitle:@"转让期限" actionArray:self.dateDataList forTextField:self.assignDeadLineDateField];
}

- (void)addAlertActionWithTitle:(NSString *)title actionArray:(NSArray *)actions forTextField:(UITextField *)field {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    for (NSInteger i = 0; i < actions.count; i++) {
        NSString *str = actions[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:str style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            field.text = str;
            self.transferPeriod = i;
        }];
        [alertVC addAction:action];
    }
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - 自定义方法
- (UITextField *) creatTextFieldWithTitle:(NSString *)title forTableViewCell:(UITableViewCell *)cell {
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(20), 0, W(50), cell.contentView.height)];
    [cell.contentView addSubview:showLabel];
    showLabel.text = title;
    showLabel.font = kTextThinFont;
    showLabel.textColor = kDSYTextGrayColor_102;
    [showLabel fixSingleWidth];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(showLabel.maxX + 2, 0, (cell.contentView.width - 2 * X(20) / 2), cell.contentView.height)];
    [cell.contentView addSubview:textField];
    textField.font = kTextThinFont;
    textField.textColor = kDSYTextGrayColor_153;
    return textField;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 200 && textView.markedTextRange == nil) {
        textView.text = [textView.text substringToIndex:200];
        [RYFactoryMethod alertViewOrControllerShow:@"项目名应在200个字以内" viewController:self];
        
    }
    self.inputNoticeLabel.text = [NSString stringWithFormat:@"%zi/200", textView.text.length];
}

#pragma mark 债权转让按钮的点击方法
- (void)assignBtnClicked:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"%@/trade/transfer", APIPREFIX];
    
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"investId":@(self.financing.investId), @"transferTitle":self.assignTitleField.text, @"transferPrice":@([self.assignBaseAmountField.text floatValue]), @"transferPeriod":@(self.transferPeriod+1), @"transferReason":self.assignReasonField.text};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"investId":@(self.financing.investId), @"transferTitle":self.assignTitleField.text, @"transferPrice":@([self.assignBaseAmountField.text floatValue]), @"transferPeriod":@(self.transferPeriod+1), @"transferReason":self.assignReasonField.text, @"sign":sign};
    [MBProgressHUD showMessage:@"正在发布债权" toView:self.view];
    [LYDTool sendPostWithUrl:url parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        id backData = LYDJSONSerialization(data);
        NSInteger statusCode = [backData[@"code"] integerValue];;
        
        if (statusCode == 200) {
            // 数据加载成功后设置相应的信息
            [MBProgressHUD showSuccess:@"债权转让成功" toView:self.view];
            // 获取父控制器
            DSYFinancingDetailController *parent = (DSYFinancingDetailController *)self.parentViewController;
            if (parent.block) {
                parent.block(1);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.parentViewController.navigationController popViewControllerAnimated:YES];
            });
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
            // 如果加载数据有问题就让page恢复
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
        NSInteger errorData = operation.response.statusCode;
        NSLog(@"%zi",operation.response.statusCode);
        if (errorData == 401) {
            // 401错误处理
            [DSYUtils showResponseError_401_ForViewController:self];
        } else if (errorData == 404) {
            [DSYUtils showResponseError_404_ForViewController:self message:@"未发现当前信息" okHandler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } cancelHandler:^(UIAlertAction *action) {
            }];
        } else if (errorData == 201) {
            [MBProgressHUD showError:@"债权已经转让，请重新转让" toView:self.view];
        } else {
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [self.view.window addSubview:errorHud];
        }
    }];
}

#pragma mark - 协议转让按钮的点击方法--------
- (void)agreeBtnClicked:(UIButton *)sender {
    DSYAssignServiceController *assignServiceVC = [[DSYAssignServiceController alloc] init];
    [self.navigationController pushViewController:assignServiceVC animated:YES];
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
