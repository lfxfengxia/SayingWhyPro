//
//  XYHomePlanTXCell.h
//  LYDApp
//
//  Created by fcl on 17/3/16.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"
@protocol XYHomePlanTXCellDelegate <NSObject>

@optional
-(void)didClickButtonXYHomePlanTXCell:(UIButton *)button;

@end

@interface XYHomePlanTXCell : UITableViewCell
@property (nonatomic, strong) XYPlanModel   *model;
 @property(nonatomic,weak) id<XYHomePlanTXCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;
@end
