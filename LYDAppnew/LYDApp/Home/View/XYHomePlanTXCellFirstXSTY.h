//
//  XYHomePlanTXCellFirstXSTY.h
//  LYDApp
//
//  Created by fcl on 2017/4/19.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"
@interface XYHomePlanTXCellFirstXSTY : UITableViewCell
@property (nonatomic, strong) XYPlanModel   *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
