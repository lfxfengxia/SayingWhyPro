//
//  XYMainTextField.m
//  LYDApp
//
//  Created by dookay_73 on 16/10/31.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYMainTextField.h"

@implementation XYMainTextField

- (instancetype)initWithFrame:(CGRect)frame andLeftTitle:(NSString *)title andLeftFrame:(CGRect)leftFrame andPlaceHolder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.leftLabel = [[UILabel alloc] initWithFrame:leftFrame];
        self.leftLabel.text = title;
        self.leftLabel.font = [UIFont systemFontOfSize:KHeight(15)];
        self.leftLabel.textColor = TEXTBLACK;
        
        self.leftView = self.leftLabel;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.placeholder = placeholder;
    }
    return self;
}

@end
