//
//  DSYAlertViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAlertViewController.h"

@interface DSYAlertViewController ()

@property (nonatomic, strong) UIView *alertBGView;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic,   copy) AlertViewControllerOKBlock okBlock;
@property (nonatomic,   copy) AlertViewControllerCancelBlock cancelBlock;
@property (nonatomic,   copy) AlertViewControllerDismissBlock dismissBlock;

@end

@implementation DSYAlertViewController

- (instancetype)initWithMessage:(NSString *)message oKBlock:(AlertViewControllerOKBlock)okBlock cancelBlock:(AlertViewControllerCancelBlock)cancelBlock dismissBlock:(AlertViewControllerDismissBlock)dismissBlock {
    self = [super init];
    if (self) {
        _okBlock = okBlock;
        _cancelBlock = cancelBlock;
        _dismissBlock = dismissBlock;
        _message = [message copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.alertBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W(240), H(150))];
    [self.view addSubview:_alertBGView];
    _alertBGView.backgroundColor = [UIColor whiteColor];
    _alertBGView.layer.cornerRadius = X(15.0);
    _alertBGView.center = self.view.center;
    
    [self closeBtn];
    [self cancelBtn];
    [self okBtn];
    [self titlelabel];
    
    [self loadData];
}

- (void)loadData {
    self.titlelabel.text = self.message;
}



- (void)setMessage:(NSString *)message {
    _message = [message copy];
    
    self.titlelabel.text = _message;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.alertBGView addSubview:_closeBtn];
        _closeBtn.frame = CGRectMake(self.alertBGView.width - X(12.5 + 12), Y(12), W(12.5), H(12.5));
        [_closeBtn setBackgroundImage:DSYImage(@"account_bank_close.png") forState:(UIControlStateNormal)];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeBtn;
}

- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, self.alertBGView.height / 2 - Y(40), self.alertBGView.width, H(30)) andTextColor:rgba(102, 102, 102, 1) fontOfSystemSize:W(18.0f)];
        [self.alertBGView addSubview:_titlelabel];
    }
    return _titlelabel;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.alertBGView addSubview:_cancelBtn];
        _cancelBtn.frame = CGRectMake(0, 0, W(90), H(40));
        _cancelBtn.layer.cornerRadius = X(3);
        _cancelBtn.layer.borderColor = ORANGECOLOR.CGColor;
        _cancelBtn.layer.borderWidth = H(0.75);
        _cancelBtn.titleLabel.textColor = ORANGECOLOR;
        _cancelBtn.titleLabel.font = DSY_NORMALFONT_14;
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:ORANGECOLOR forState:(UIControlStateNormal)];
        CGFloat centerX = (self.alertBGView.width - 2 * W(90)) / 3 + W(90) / 2;
        CGFloat centerY = self.alertBGView.height / 2 + self.alertBGView.height / 4;
        _cancelBtn.center = CGPointMake(centerX, centerY);
        [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelBtn;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.alertBGView addSubview:_okBtn];
        _okBtn.frame = CGRectMake(0, 0, W(90), H(40));
        _okBtn.layer.cornerRadius = X(3);
        _okBtn.layer.borderColor = ORANGECOLOR.CGColor;
        _okBtn.layer.borderWidth = H(0.75);
        _okBtn.titleLabel.textColor = ORANGECOLOR;
        _okBtn.backgroundColor = ORANGECOLOR;
        _okBtn.titleLabel.font = DSY_NORMALFONT_14;
        [_okBtn setTitle:@"确认" forState:(UIControlStateNormal)];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        CGFloat centerX = self.alertBGView.width - ((self.alertBGView.width - 2 * W(90)) / 3 + W(90) / 2);
        CGFloat centerY = self.alertBGView.height / 2 + self.alertBGView.height / 4;
        _okBtn.center = CGPointMake(centerX, centerY);
        [_okBtn addTarget:self action:@selector(okClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _okBtn;
}

- (void)closeBtnClicked:(UIButton *)button {
    self.dismissBlock(self);
}

- (void)cancelClick:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
    [self closeBtnClicked:nil];
}

- (void)okClicked:(UIButton *)sender {
    if (self.okBlock) {
        self.okBlock(self);
    }
    [self closeBtnClicked:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.dismissBlock) {
        self.dismissBlock(self);
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
