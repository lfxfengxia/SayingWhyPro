//
//  XYErrorHud.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/25.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYErrorHud.h"

@implementation XYErrorHud



- (instancetype)initWithTitle:(NSString *)title andDoneBtnTitle:(NSString *)doneBtnTitle andDoneBtnHidden:(BOOL)hidden
{
    self = [super init];
    if (self) {
        [self createUIWithTitle:title andDoneBtnTitle:doneBtnTitle andDoneBtnHidden:hidden];
    }
    return self;
}

- (void)createUIWithTitle:(NSString *)title andDoneBtnTitle:(NSString *)doneBtnTitle andDoneBtnHidden:(BOOL)hidden
{
    self.frame = CGRectMake(0, 0, kSCREENW, kSCREENH);
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, kSCREENH)];
    [self addSubview:self.bgView];
    
    self.bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth(480/2), KHeight(357/2))];
    self.bgIV.center = self.center;
    self.bgIV.image = [UIImage imageNamed:@"errorView"];
    self.bgIV.userInteractionEnabled = YES;
    [self addSubview:self.bgIV];
    
    self.cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bgIV.width - KWidth(25 / 2) - KWidth(25 / 2), KHeight(83/2), KWidth(25 / 2), KWidth(25 / 2))];
    [self.cancleBtn setBackgroundImage:[UIImage imageNamed:@"errorCancleBtn"] forState:UIControlStateNormal];
    [self.cancleBtn addTarget:self action:@selector(cancleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgIV addSubview:self.cancleBtn];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(15), KHeight(174/2), self.bgIV.width - KWidth(30), KHeight(17))];
    self.titleLabel.textColor = TEXTBLACK;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:KHeight(18)];
    self.titleLabel.text = title;
    self.titleLabel.numberOfLines = 0;
    [self.bgIV addSubview:self.titleLabel];
    
    if (hidden == NO) {
        self.doneBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.bgIV.width - KWidth(100)) / 2, self.titleLabel.maxY + KHeight(33/2), KWidth(100), KHeight(30))];
        self.doneBtn.backgroundColor = [UIColor colorWithRed:0.23 green:0.49 blue:1.00 alpha:1.00];
        [self.doneBtn setTitle:doneBtnTitle forState:UIControlStateNormal];
        [self.doneBtn addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.doneBtn.layer.cornerRadius = 2.0f;
        self.doneBtn.layer.masksToBounds = YES;
        self.doneBtn.titleLabel.font = [UIFont systemFontOfSize:KHeight(16)];
        [self.bgIV addSubview:self.doneBtn];
    } else {
        self.titleLabel.y += KHeight(15);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.bgView addGestureRecognizer:tap];
}

- (void)cancleBtnClicked:(UIButton *)button
{
    [self removeFromSuperview];
}

- (void)viewTapped:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}

- (void)doneBtnClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(errorHud:doneBtnClicked:)]) {
        [self.delegate errorHud:self doneBtnClicked:button];
        [self removeFromSuperview];
    }
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:message andDoneBtnTitle:nil andDoneBtnHidden:YES];
    [view.window addSubview:errorHud];
}


@end
