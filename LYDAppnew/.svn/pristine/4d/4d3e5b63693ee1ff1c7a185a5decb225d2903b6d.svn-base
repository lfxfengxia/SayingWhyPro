//
//  RBDatePickerView.m
//  LYDApp
//
//  Created by Riber on 16/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBDatePickerView.h"

@interface RBDatePickerView ()

@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation RBDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI:frame];
    }
    
    return self;
}

- (void)createUI:(CGRect)frame {
    
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
    _toolView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_toolView];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(0, 0, 60, 44);
    _cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _cancelButton.contentEdgeInsets = UIEdgeInsetsMake(0, KWidth(20), 0, 0);
    [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_toolView addSubview:_cancelButton];
    
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.frame = CGRectMake(frame.size.width-60, 0, 60, 44);
    _doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _doneButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, KWidth(20));
    [_doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_toolView addSubview:_doneButton];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _toolView.maxY, frame.size.width, 200)];
    [self addSubview:_datePicker];
    
    [self setDefaultConfig];
}

- (void)setPromptString:(NSString *)promptString {
    if (promptString.length != 0 || ![promptString isEqualToString:@""]) {
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-100)/2.0, 0, 100, 44)];
        _promptLabel.textColor = [UIColor lightGrayColor];
        _promptLabel.font = [UIFont systemFontOfSize:14];
        _promptLabel.text = promptString;
        [_toolView addSubview:_promptLabel];
    }
}

- (void)setDefaultConfig {
    _toolView.backgroundColor = [UIColor whiteColor];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _datePicker.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker setDate:[NSDate date]];
}

- (void)cancelButtonClick:(UIButton *)cancelButton {
    if (self.cancelButtonClickBlock) {
        self.cancelButtonClickBlock(_datePicker);
    }
}

- (void)doneButtonClick:(UIButton *)doneButton {
    if (self.doneButtonClickBlock) {
        self.doneButtonClickBlock(_datePicker);
    }
}

@end
