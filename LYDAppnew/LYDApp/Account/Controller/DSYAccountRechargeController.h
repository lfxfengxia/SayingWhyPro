//
//  DSYAccountRechargeController.h
//  LYDApp
//
//  Created by dai yi on 2016/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseDetailController.h"

@interface DSYAccountRechargeController : DSYFinancingBaseDetailController

@property (nonatomic, assign) NSInteger comeFrom;      /**< 来处，0: 来自充值界面，1：来自投资界面 */

@end
