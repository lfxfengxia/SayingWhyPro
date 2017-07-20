//
//  XYHomeLDBCell.h
//  LYDApp
//
//  Created by fcl on 17/2/16.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"

@protocol XYHomeLDBCellDelegate <NSObject>

@optional
-(void)didClickButtonXYHomeLDBCell:(UIButton *)button;

@end

@interface XYHomeLDBCell : UITableViewCell
@property (nonatomic, strong) XYPlanModel   *model;
@property(nonatomic,weak) id<XYHomeLDBCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
