//
//  DSYCouponModel.h
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseModel.h"

@interface DSYCouponModel : DSYBaseModel

@property (nonatomic,   copy) NSString *couponName;  /**< 加息劵名 */
@property (nonatomic, assign) NSInteger coupontType; /**< 0现金卷，1加息劵 */
//@property (nonatomic,   copy) NSString *couponId;    /**< 优惠券id */
@property (nonatomic, assign) CGFloat startAmount;   /**< 底价 */
@property (nonatomic, assign) CGFloat endAmount;     /**< 最高价 */
@property (nonatomic,   copy) NSString *startDate;   /**< 起始日期 */
@property (nonatomic,   copy) NSString *endDate;     /**< 结束日期 */

//@property (nonatomic, assign) CGFloat amount;        /**< 现金抵用券的时候 */
@property (nonatomic, assign) CGFloat rate;          /**< 加息券的时候 */

@property (nonatomic, assign) NSInteger useStatus;   /**< 优惠券状态，0, 未绑定，1：未使用，2：已使用，3：过期 */

@property (nonatomic, assign, setter=setId:) NSInteger couponId;
@property (nonatomic,   copy) NSString *code;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CGFloat amount;
@property (nonatomic, assign) CGFloat minInvestAmount;
@property (nonatomic,   copy, setter=setDescription:) NSString *couponDescription;
@property (nonatomic,   copy) NSString *products;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double expireTime;


/**
 * 已使用的优惠券
 */
@property (nonatomic,   copy) NSString *title;        /**< 优惠券明细 */
@property (nonatomic,   copy) NSString *bidTitle;     /**< 借款标标题  */
@property (nonatomic, assign) CGFloat investAmount;   /**< 投资金额 */
@property (nonatomic, assign) CGFloat realPayAmount;  /**< 实际支出金额 */
@property (nonatomic, assign) CGFloat bidRate;        /**< 标的利率 */
@property (nonatomic, assign) NSUInteger useTime;     /**< 使用时间 */


@end
