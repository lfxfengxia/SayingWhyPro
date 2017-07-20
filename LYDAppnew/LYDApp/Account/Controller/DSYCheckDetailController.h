//
//  DSYCheckDetailController.h
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseViewController.h"

@class DSYFinancingModel;
@interface DSYCheckDetailController : DSYBaseViewController

@property (nonatomic, strong) DSYFinancingModel *financing;
- (instancetype)initWithFinancing:(DSYFinancingModel *)financing;

@end
