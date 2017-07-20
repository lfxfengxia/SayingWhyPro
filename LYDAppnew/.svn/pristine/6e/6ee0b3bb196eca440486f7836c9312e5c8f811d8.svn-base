//
//  RBFeedBackViewController.m
//  LYDApp
//
//  Created by Riber on 16/11/3.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBFeedBackViewController.h"

@interface RBFeedBackViewController () <UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UILabel *thankLabel;
@property (nonatomic, strong) BRPlaceholderTextView *textView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation RBFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleNavigationBarLabel.text = @"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    _bgScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_bgScrollView];
    
    _thankLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, 64 + KHeight(65), kSCREENW, 20) andTextColor:rgba(102, 102, 102, 1) fontOfSystemSize:KWidth(14)];
    _thankLabel.text = @"感谢您对零用贷的支持，我们期待您的宝贵意见";
    _thankLabel.textAlignment = NSTextAlignmentCenter;
    [_bgScrollView addSubview:_thankLabel];
    
    _textView = [[BRPlaceholderTextView alloc] initWithFrame:CGRectMake(KWidth(46), _thankLabel.maxY + KHeight(50), kSCREENW-2*KWidth(46), KHeight(200))];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:KWidth(14)];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00].CGColor;
    _textView.placeholder = @"  在此输入您的意见";
    [_textView setPlaceholderFont:[UIFont systemFontOfSize:KWidth(14)]];
    [_bgScrollView addSubview:_textView];
    
    _countLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(_textView.width-100-10, _textView.height-20, 100, 20) andTextColor:rgba(173, 171, 172, 1) fontOfSystemSize:KWidth(11) isBold:NO];
    _countLabel.textAlignment = NSTextAlignmentRight;
    _countLabel.text = @"0/200";
    [_textView addSubview:_countLabel];
    
    _submitButton = [RYFactoryMethod initWithNormalButtonFrame:CGRectMake(KWidth(46), _textView.maxY + KHeight(28), kSCREENW-2*KWidth(46), 44) title:@"提交" titleColor:[UIColor whiteColor] fontOfSystemSize:KWidth(18)];
    _submitButton.backgroundColor = rgba(252, 120, 35, 1);
    [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:_submitButton];
    
    _bgScrollView.contentSize = CGSizeMake(0, _submitButton.maxY + 10);
}

- (void)submitButtonClick:(UIButton *)submitButton {
    [self.view endEditing:YES];
    
    if (_textView.text.length == 0) {
        
        [RYFactoryMethod alertViewOrControllerShow:@"请填写意见反馈" viewController:self];
        return;
    }
    
    [self startRequestOfSubmit];
}

- (void)startRequestOfSubmit {
    NSString *url = [NSString stringWithFormat:@"%@/common/feedback", APIPREFIX];
    NSDictionary *para = [self getMyPara];
    [LYDTool sendPostWithUrl:url parameters:para success:^(id data) {
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
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"message": self.textView.text};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"message": self.textView.text, @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        [MBProgressHUD showSuccess:@"反馈意见成功!" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
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

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 200 && textView.markedTextRange == nil) {
        textView.text = [textView.text substringToIndex:200];
        [RYFactoryMethod alertViewOrControllerShow:@"项目名应在200个字以内" viewController:self];

    }
    _countLabel.text = [NSString stringWithFormat:@"%zi/200", textView.text.length];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
