//
//  DSYCouponAddController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//  添加

#import "DSYCouponAddController.h"
#import "DSYAccountCouponController.h"

#define kTextColorGray_102 rgba(102, 102, 102, 1)

@interface DSYCouponAddController ()

@property (nonatomic, strong) UIView *contentBgView;    /**< 主要视图区域 */

@property (nonatomic, strong) UITextField *couponField; /**< 优惠券的输入 */

@property (nonatomic, strong) UIButton *okBtn;          /**< 确定按钮 */
@property (nonatomic, strong) UIButton *cancelBtn;      /**< 取消按钮 */

@end

@implementation DSYCouponAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = rgba(249, 249, 249, 1);
    
    [self setupUI];
    
//    [self loadData];
}


- (void)loadData {
    NSString *code = self.couponField.text ;
    
    if (code.length <= 0 ) {
        [MBProgressHUD showError:@"请输入优惠券码" toView:self.view];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/user/coupons", APIPREFIX];
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"code":code};
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"code":code, @"sign":sign};
    
    [MBProgressHUD showMessage:@"正在绑定优惠券" toView:self.view];
    [LYDTool sendPostWithUrl:url parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view];
        
        id backData = LYDJSONSerialization(data);
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            [MBProgressHUD showSuccess:@"绑定成功!" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIViewController *parentVC = self.parentViewController;
                if ([parentVC isKindOfClass:[DSYAccountCouponController class]]) {
                    DSYAccountCouponController *vc = (DSYAccountCouponController *)parentVC;
                    vc.unUsedRefresh = YES;
                    vc.currentIndex = 1;
                }
                
            });

        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:self];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:self.view];
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:self.view];
    }];

}


- (void)setupUI {
    [self contentBgView];
    [self couponField];
    [self okBtn];
    [self cancelBtn];
}

- (UIView *)contentBgView {
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] initWithFrame:CGRectMake(0, Y(10), self.view.width, self.view.height - H(55))];
        [self.view addSubview:_contentBgView];
        _contentBgView.backgroundColor = [UIColor whiteColor];
    }
    return _contentBgView;
}

- (UITextField *)couponField {
    if (!_couponField) {
        
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Y(52), self.contentBgView.width, H(45))];
        [self.contentBgView addSubview:showLabel];
    
        showLabel.text = @"优惠券码";
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.textColor = kTextColorGray_102;
        showLabel.font = DSY_NORMALFONT_15;
        _couponField = [[UITextField alloc] initWithFrame:CGRectMake(0, showLabel.maxY, W(250), H(44))];
        [self.contentBgView addSubview:_couponField];
        _couponField.centerX = self.contentBgView.width / 2;
        _couponField.textColor = kTextColorGray_102;
        _couponField.textAlignment = NSTextAlignmentCenter;
        _couponField.font = DSY_NORMALFONT_15;
        _couponField.placeholder = @"请输入优惠券码";
        _couponField.layer.cornerRadius = X(3.0);
        _couponField.layer.borderColor = kTextColorGray_102.CGColor;
        _couponField.layer.borderWidth = H(0.5);
        
    }
    return _couponField;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.contentBgView addSubview:_okBtn];
        CGFloat width = (self.couponField.width - W(30)) / 2;
        _okBtn.frame = CGRectMake(self.couponField.x, self.couponField.maxY + Y(30), width, H(44));
        _okBtn.backgroundColor = ORANGECOLOR;
        _okBtn.layer.cornerRadius = X(3.0);
        _okBtn.titleLabel.font = DSY_NORMALFONT_15;
        [_okBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_okBtn addTarget:self action:@selector(addCouponClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _okBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.contentBgView addSubview:_cancelBtn];
        CGFloat width = (self.couponField.width - W(30)) / 2;
        _cancelBtn.frame = CGRectMake(self.couponField.maxX - width, self.okBtn.y, width, H(44));
        
        _cancelBtn.layer.cornerRadius = X(3.0);
        _cancelBtn.layer.borderWidth = H(0.5);
        _cancelBtn.layer.borderColor = rgba(194, 183, 176, 1).CGColor;
        _cancelBtn.titleLabel.font = DSY_NORMALFONT_15;
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:rgba(194, 183, 176, 1) forState:(UIControlStateNormal)];
    }
    return _cancelBtn;
}

#pragma mark - 添加按钮
- (void)addCouponClicked:(UIButton *)btn {
    [self loadData];
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
