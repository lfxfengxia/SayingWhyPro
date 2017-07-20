//
//  XYHomePlanCell.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"

@interface XYHomePlanCell : UITableViewCell

@property (nonatomic, strong) XYPlanModel   *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
