//
//  DSYDebtsTableViewCell.h
//  LYDApp
//
//  Created by dai yi on 2016/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseTableViewCell.h"

@class DSYFinancingModel;
typedef void(^DebtsTableViewCellBlock)(NSIndexPath *, DSYFinancingCellButtonClickType);

@interface DSYDebtsTableViewCell : DSYFinancingBaseTableViewCell

@property (nonatomic, strong) DSYFinancingModel *financing;
@property (nonatomic, strong) NSIndexPath *currentIndex;

@property (nonatomic,   copy) DebtsTableViewCellBlock block;

+ (DSYDebtsTableViewCell *)cellForTableView:(UITableView *)tableView;

@end
