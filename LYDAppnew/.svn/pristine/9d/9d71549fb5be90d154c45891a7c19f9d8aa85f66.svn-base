//
//  RBTitleView.m
//  LYDApp
//
//  Created by Riber on 16/11/7.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBTitleView.h"

@interface RBTitleView ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UILabel *selectLine; // 选中按钮底线
@property (nonatomic, strong) UILabel *bottomLine; // 视图底部分割线
@property (nonatomic, strong) NSMutableArray *widthArray;

@end

@implementation RBTitleView

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray {
    if (self = [super initWithFrame:frame]) {
        _titleArray = titleArray;
        self.backgroundColor = [UIColor whiteColor];
        
        _widthArray = [NSMutableArray arrayWithCapacity:0];
        [self createUI];
    }
    
    return self;
}

- (void)createUI {
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(kSCREENW/_titleArray.count), 0, kSCREENW/_titleArray.count, self.height-1);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:NormalColor forState:UIControlStateNormal];
        [button setTitleColor:SelectColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        CGRect rect = [_titleArray[i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, button.height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:button.titleLabel.font} context:nil];
        
        [_widthArray addObject:[NSNumber numberWithFloat:rect.size.width]];
        
        if (i == 0) {
            _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-1, kSCREENW, 1)];
            _bottomLine.backgroundColor = LIGHTGRAYTEXT;
            [self addSubview:_bottomLine];
            
            // 底部选中的线
            _selectLine = [[UILabel alloc] initWithFrame:CGRectMake((button.width - [_widthArray[0] floatValue])/2.0, self.height-2, [_widthArray[0] floatValue], 2)];
            _selectLine.backgroundColor = SelectColor;
            [self addSubview:_selectLine];
            button.selected = YES; // 默认第一个选中
        }
    }
}

- (void)setIsHaveRightLine:(BOOL)isHaveRightLine {
    if (isHaveRightLine) {
        if (isHaveRightLine) {
            for (int i = 0; i < _titleArray.count-1; i++) {
                UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENW/_titleArray.count + i*(kSCREENW/_titleArray.count)-1, 8, 1, self.height-1-2*8)];
                lineLabel.backgroundColor = LIGHTGRAYTEXT;
                [self addSubview:lineLabel];
            }
        }
    }
}

- (void)titleButtonClick:(UIButton *)titleButton {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            button.selected = NO;
        }
    }
    
    titleButton.selected = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        _selectLine.frame = CGRectMake(titleButton.x + (titleButton.width-[_widthArray[titleButton.tag] floatValue])/2.0, _selectLine.y, [_widthArray[titleButton.tag] floatValue], _selectLine.height);
    }];
    
    if (self.titleButtonClickBlock) {
        self.titleButtonClickBlock(titleButton.tag);
    }
}

- (void)setSelectIndex:(NSInteger)index {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            
            button.selected = NO;
            if (index == button.tag) {
                button.selected = YES;
            }
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
//        _selectLine.frame = CGRectMake((kSCREENW/_titleArray.count)*index + ((kSCREENW/_titleArray.count)-[_widthArray[index] floatValue])/2.0, _selectLine.y, [self.widthArray[index] floatValue], _selectLine.height);
        
        _selectLine.width = [self.widthArray[index] floatValue];
        _selectLine.centerX = (kSCREENW / self.titleArray.count) * (0.5 + index);
    }];
}

- (void)setButtonTitleFont:(UIFont *)font {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            
            button.titleLabel.font = font;
        }
    }
}

@end
