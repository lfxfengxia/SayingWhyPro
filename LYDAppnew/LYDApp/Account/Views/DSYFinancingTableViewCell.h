//
//  DSYFinancingTableViewCell.h
//  LYDApp
//
//  Created by dai yi on 2016/11/7.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSYFinancingBaseTableViewCell.h"

typedef void(^FinancingTableViewCellClickBlock)(NSIndexPath *, DSYFinancingCellButtonClickType);
@class DSYFinancingModel;

@interface DSYFinancingTableViewCell : DSYFinancingBaseTableViewCell

@property (nonatomic, strong) DSYFinancingModel *financing;
@property (nonatomic, strong) NSIndexPath *currentIndex;

+ (DSYFinancingTableViewCell *)financingTableViewCellForTableView:(UITableView *)tableView;


@property (nonatomic,   copy) FinancingTableViewCellClickBlock block;

@end
