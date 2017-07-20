//
//  DSYFinancingNewCell.h
//  LYDApp
//
//  Created by dai yi on 2016/11/28.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSYFinancingModel;
@class DSYDebtsTransfers;
@interface DSYFinancingNewCell : UITableViewCell

@property (nonatomic, strong) DSYFinancingModel *financing;
@property (nonatomic, strong) DSYDebtsTransfers *transers;

+ (DSYFinancingNewCell *)cellForTableView:(UITableView *)tableView;

@end
