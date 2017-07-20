//
//  LDBDetailViewController.h
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/26.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"
@interface BuyFenshuMarkVC : DSYFinancingBaseDetailController
@property(nonatomic,strong)XYPlanModel *model;
@property(nonatomic,copy)NSString *myBalance;
@end
