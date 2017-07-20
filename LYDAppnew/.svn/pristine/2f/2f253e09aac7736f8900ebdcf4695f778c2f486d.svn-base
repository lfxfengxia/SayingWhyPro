//
//  XYHomeLDBCellFirst.h
//  LYDApp
//
//  Created by fcl on 2017/4/18.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"
@protocol YiYueBiaocellDelegate <NSObject>

@optional
-(void)didClickButtonYiYueBiao:(UIButton *)button;

@end
@interface XYHomeLDBCellFirst : UITableViewCell
@property (nonatomic, strong) XYPlanModel   *model;
@property(nonatomic,weak) id<YiYueBiaocellDelegate> delete;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;
@end
