//
//  DSYFinancingDebtsTableCell.h
//  LYDApp
//
//  Created by dai yi on 2016/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSYFinancingModel;
@interface DSYFinancingDebtsTableCell : UITableViewCell

@property (nonatomic, strong) DSYFinancingModel *model;

+ (DSYFinancingDebtsTableCell *)cellForTableView:(UITableView *)tableView;

@end
