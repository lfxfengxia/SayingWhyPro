//
//  LYDPlanConfirmController.h
//  LYDApp
//
//  Created by fcl on 17/2/23.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

//零定宝确认页面

#import "DSYBaseViewController.h"
#import "XYPlanModel.h"


@class DSYCouponModel;
@interface LYDPlanConfirmController : DSYBaseViewController

@property (nonatomic, strong) XYPlanModel   *model;
@property (nonatomic, strong) DSYCouponModel *coupon;

//@property (nonatomic, strong) NSString      *amount;
@property (nonatomic, strong) NSString      *sumMoney;//投资金额
@property (nonatomic, strong) NSString      *discount;
@property (nonatomic, strong) NSString      *couponId;

@end
