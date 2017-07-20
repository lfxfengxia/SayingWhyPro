//
//  DSYCouponFirstCell.h
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSYCouponModel;

typedef void(^DSYCouponFirstCellBtnclickBlock)(DSYCouponModel*);
@interface DSYCouponFirstCell : UITableViewCell

@property (nonatomic, strong) DSYCouponModel *coupon;

@property (nonatomic,   copy) DSYCouponFirstCellBtnclickBlock block;

+ (DSYCouponFirstCell *)cellForTableView:(UITableView *)tableView;

@end
