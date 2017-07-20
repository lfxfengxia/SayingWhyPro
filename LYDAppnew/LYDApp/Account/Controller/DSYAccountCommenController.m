//
//  DSYAccountCommenController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/15.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountCommenController.h"

@interface DSYAccountCommenController () <UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UILabel *thankLabel;
@property (nonatomic, strong) BRPlaceholderTextView *textView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation DSYAccountCommenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigaTitle = @"评论";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    _bgScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_bgScrollView];
    
    
    _textView = [[BRPlaceholderTextView alloc] initWithFrame:CGRectMake(KWidth(46), 70 + KHeight(50), kSCREENW-2*KWidth(46), KHeight(200))];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:KWidth(14)];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00].CGColor;
    _textView.placeholder = @"  在此输入您的评论";
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
