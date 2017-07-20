//
//  DSYNewInvesting.h
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseModel.h"

@interface DSYNewInvesting : DSYBaseModel

@property (nonatomic, assign, setter=setId:) NSInteger investId;
@property (nonatomic,   copy) NSString *bidTitle;     /**< 标名 */
@property (nonatomic, assign) CGFloat amount;         /**< 投资金额 */
@property (nonatomic, assign) CGFloat totalIncome;    /**< 收益 */
@property (nonatomic,   copy) NSString *statusDesc;   /**< 状态 */
@property (nonatomic, assign) NSInteger type;

@end
