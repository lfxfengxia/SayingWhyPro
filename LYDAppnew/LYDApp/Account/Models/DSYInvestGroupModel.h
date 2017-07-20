//
//  DSYInvestGroupModel.h
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseModel.h"

@interface DSYInvestGroupModel : DSYBaseModel

@property (nonatomic,   copy) NSString *investName;       /**< 借款人 */
@property (nonatomic,   copy) NSString *phone;            /**< 手机号码 */
@property (nonatomic, assign) CGFloat   borrowAmount;     /**< 借款金额 */
@property (nonatomic,   copy) NSString *pactCode;         /**< 合同编号 */

@property (nonatomic,   copy) NSString *borrowerName;
@property (nonatomic,   copy) NSString *borrowerMobile;
@property (nonatomic,   copy) NSString *contractNo;
@property (nonatomic, assign) CGFloat investAmount;

@end
