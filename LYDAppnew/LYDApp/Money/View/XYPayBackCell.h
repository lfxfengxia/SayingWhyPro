//
//  XYPayBackCell.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPayBackModel.h"

@interface XYPayBackCell : UITableViewCell

@property (nonatomic, strong) XYPayBackModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
