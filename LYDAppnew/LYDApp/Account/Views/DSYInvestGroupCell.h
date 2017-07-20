//
//  DSYInvestGroupCell.h
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSYInvestGroupModel;
@interface DSYInvestGroupCell : UITableViewCell

@property (nonatomic, strong) DSYInvestGroupModel *investGroup;
+ (DSYInvestGroupCell *)cellForTableView:(UITableView *)tableView;

@end
