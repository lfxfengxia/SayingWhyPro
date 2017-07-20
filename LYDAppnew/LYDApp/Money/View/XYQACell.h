//
//  XYQACell.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYQAModel.h"

@interface XYQACell : UITableViewCell

@property (nonatomic, strong) XYQAModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
