//
//  XYSanBidCell.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSanBidModel.h"

@interface XYSanBidCell : UITableViewCell

@property (nonatomic, strong) XYSanBidModel   *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
