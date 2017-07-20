//
//  XYHomeLDBShouQingCell.h
//  LYDApp
//
//  Created by fcl on 2017/6/21.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"
@interface XYHomeLDBShouQingCell : UITableViewCell
@property (nonatomic, strong) XYPlanModel   *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
