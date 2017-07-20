//
//  DSYOpenAccountController.h
//  LYDApp
//
//  Created by dai yi on 2016/12/16.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseDetailController.h"

typedef NS_ENUM(NSInteger, DSYOpenAccountControllerFromType) {
    DSYOpenAccountControllerFromTypeNone,    /**< 默认 */
    DSYOpenAccountControllerFromTypeRegister   /**< 来自成功注册 */
};

@interface DSYOpenAccountController : DSYFinancingBaseDetailController

- (instancetype)initWithType:(DSYOpenAccountControllerFromType )type;

@property (nonatomic, assign) DSYOpenAccountControllerFromType type;

@end
