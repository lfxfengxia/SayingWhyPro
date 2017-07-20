//
//  DSYFanancingDetailController.h
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseViewController.h"

@class DSYFinancingModel;

typedef void(^DSYFinancingDetailControllerBlock)(NSInteger);
@interface DSYFinancingDetailController : DSYBaseViewController

@property (nonatomic, strong) DSYFinancingModel *financing;

- (instancetype)initWithFinancing:(DSYFinancingModel *)financing;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,   copy) DSYFinancingDetailControllerBlock block;

@end
