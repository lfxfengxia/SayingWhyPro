//
//  XYTransportCell.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/7.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYTransportModel.h"

@interface XYTransportCell : UITableViewCell

@property (nonatomic, strong) XYTransportModel   *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
