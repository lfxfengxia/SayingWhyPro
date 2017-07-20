//
//  RBPikerView.m
//  LYDApp
//
//  Created by Riber on 16/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBPikerView.h"

@interface RBPikerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UILabel *promptLabel;
@property(nonatomic,assign) NSInteger selectedRow;

@end

@implementation RBPikerView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray
{
    if (self = [super initWithFrame:frame]) {
        _dataArray = dataArray;
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
    
    UIView *fengexian=[[UIView alloc] initWithFrame:CGRectMake(0, _toolView.maxY, frame.size.width, 0.5)];
    fengexian.backgroundColor=TEXTGARY;
    [self addSubview:fengexian];
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _toolView.maxY, frame.size.width, 200)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
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

- (void)reloadData {
    [_pickerView reloadComponent:0];
}

- (void)setDefaultConfig {
    _toolView.backgroundColor = [UIColor whiteColor];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (void)cancelButtonClick:(UIButton *)cancelButton {
    if (self.cancelButtonClickBlock) {
        self.cancelButtonClickBlock([_pickerView selectedRowInComponent:0]);
    }
}

- (void)doneButtonClick:(UIButton *)doneButton {
    if (self.doneButtonClickBlock) {
        self.doneButtonClickBlock([_pickerView selectedRowInComponent:0]);
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedRow = row;
  [pickerView reloadAllComponents];   //一定要写这句

}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    
    UILabel *lbl=(UILabel *)view;
    if (!lbl) {
        lbl=[[UILabel alloc] initWithFrame:CGRectMake((kSCREENW-100)/2, 0, 100, 60)];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.font=[UIFont systemFontOfSize:14];
        for(UIView *speartorView in pickerView.subviews)
        {
            if (speartorView.frame.size.height < 1)//取出分割线view
            {
                speartorView.backgroundColor = [UIColor colorWithRed:59/255.0 green:148/255.0 blue:174 alpha:1];
                CGRect dd=speartorView.frame;
                speartorView.frame=CGRectMake(lbl.frame.origin.x, dd.origin.y, lbl.frame.size.width, dd.size.height);
            }
        }
    }
    if (row == _selectedRow) {
        
        lbl.text=_dataArray[row];
        lbl.textColor=[UIColor colorWithRed:59/255.0 green:148/255.0 blue:174 alpha:1];
        return lbl;
    } else {
       
        lbl.textColor=TEXTGARY;
        lbl.text=_dataArray[row];
        return lbl;
    }
    
}



- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in self.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = [UIColor clearColor];//隐藏分割线
        }
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60;

}


//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSDictionary * attrDic = @{NSForegroundColorAttributeName:AEUI_RED_COLOR,
//                               NSFontAttributeName:systemFont(15)};
//    
//    NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:goodsTypeDataSource[@(row+1)]
//                                                                      attributes:attrDic];
//    return attrString;
//}

@end
