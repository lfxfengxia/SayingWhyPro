//
//  DSYInvestHFViewController.h
//  LYDApp
//
//  Created by dai yi on 2016/12/20.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseDetailController.h"
#import "XYPlanModel.h"

@interface DSYInvestHFViewController : DSYFinancingBaseDetailController

@property (nonatomic, assign) CGFloat amount;

@property (nonatomic, strong) XYPlanModel   *model;

@property (nonatomic, strong) NSString      *discount;
@property (nonatomic, strong) NSString      *couponId;

@property (nonatomic,   copy) NSString *payUrl;

@end
