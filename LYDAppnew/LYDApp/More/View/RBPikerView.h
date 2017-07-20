//
//  RBPikerView.h
//  LYDApp
//
//  Created by Riber on 16/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBPikerView : UIView

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, copy) NSString *promptString;

@property (nonatomic, copy) void (^cancelButtonClickBlock)();
@property (nonatomic, copy) void (^doneButtonClickBlock)();
@property (nonatomic, strong) NSArray *dataArray;

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray;

- (void)reloadData;

@end
