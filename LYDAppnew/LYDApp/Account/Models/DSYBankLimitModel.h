//
//  DSYBankLimitModel.h
//  LYDApp
//
//  Created by dai yi on 2017/1/3.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "DSYBaseModel.h"

@interface DSYBankLimitModel : DSYBaseModel

@property (nonatomic,   copy) NSString *bankCode;
@property (nonatomic,   copy) NSString *bankName;
@property (nonatomic, assign) CGFloat singleTransQuota;
@property (nonatomic, assign) CGFloat cardDailyTransQuota;

@end
