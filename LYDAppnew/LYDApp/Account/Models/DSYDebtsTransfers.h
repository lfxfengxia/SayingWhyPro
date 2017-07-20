//
//  DSYDebtsTransfers.h
//  LYDApp
//
//  Created by dai yi on 2016/12/24.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseModel.h"

@interface DSYDebtsTransfers : DSYBaseModel

@property (nonatomic,   copy) NSString *bidTitle;
@property (nonatomic,   copy) NSString *investTime;
@property (nonatomic,   copy) NSString *repayTime;
@property (nonatomic, assign) CGFloat investAmount;
@property (nonatomic, assign) CGFloat couponAmount;
@property (nonatomic, assign) CGFloat totalIncome;
@property (nonatomic, assign) NSInteger investId;

@end
