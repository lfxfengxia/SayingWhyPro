//
//  DSYCouponSelectViewCell.h
//  LYDApp
//
//  Created by dai yi on 2016/12/22.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSYCouponModel;
@interface DSYCouponSelectViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *amoutNameLabel;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) DSYCouponModel *model;

+ (DSYCouponSelectViewCell *)cellForTableView:(UITableView *)tableView;

@end
