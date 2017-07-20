//
//  XYTransportDetailCell.h
//  LYDApp
//
//  Created by dookay_73 on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYTransportModel.h"

@interface XYTransportDetailCell : UITableViewCell

@property (nonatomic, strong) XYTransportModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;


@end
