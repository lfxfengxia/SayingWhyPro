//
//  XYJoinRecordController.h
//  LYDApp
//
//  Created by dookay_73 on 2016/11/28.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseViewController.h"
#import "XYPlanModel.h"

@interface XYJoinRecordController : DSYBaseViewController

@property (nonatomic, strong) NSString  *planId;
@property (nonatomic, strong) NSString  *type;
@property (nonatomic, strong) XYPlanModel *model;
@end
