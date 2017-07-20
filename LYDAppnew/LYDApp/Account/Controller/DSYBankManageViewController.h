//
//  DSYBankManageViewController.h
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseDetailController.h"

@class DSYBankModel;

typedef void(^DSYBankManageViewControllerBlock)(BOOL);
@interface DSYBankManageViewController : DSYFinancingBaseDetailController

@property (nonatomic, strong) DSYBankModel *myBank;
@property (nonatomic,   copy) DSYBankManageViewControllerBlock block;

@end
