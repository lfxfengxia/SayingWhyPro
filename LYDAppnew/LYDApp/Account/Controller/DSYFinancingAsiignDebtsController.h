//
//  DSYFinancingAsiignDebtsController.h
//  LYDApp
//
//  Created by dai yi on 2016/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseDetailController.h"

@class DSYFinancingModel;
@interface DSYFinancingAsiignDebtsController : DSYFinancingBaseDetailController

@property (nonatomic, strong) DSYFinancingModel *financing;
- (instancetype)initWithFinancing:(DSYFinancingModel *)financing;
@end
