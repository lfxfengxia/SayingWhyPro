//
//  DSYInviteDetailViewController.h
//  LYDApp
//
//  Created by dai yi on 2016/12/30.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseDetailController.h"

@interface DSYInviteDetailViewController : DSYFinancingBaseDetailController

@end

@interface DSYDateModel : DSYBaseModel

@property (nonatomic,   copy) NSString *rigsterStartDate;
@property (nonatomic,   copy) NSString *rigsterEndDate;
@property (nonatomic,   copy) NSString *investStartDate;
@property (nonatomic,   copy) NSString *investEndDate;

@end
