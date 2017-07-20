//
//  XYHomePlanTXCellFirstReMen.h
//  LYDApp
//
//  Created by fcl on 2017/4/19.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"



@protocol MycellDelegate <NSObject>

@optional
-(void)didClickButton:(UIButton *)button;

@end
@interface XYHomePlanTXCellFirstReMen : UITableViewCell
@property (nonatomic, strong) XYPlanModel   *model;
 @property(nonatomic,weak) id<MycellDelegate> Qianggoudelegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;
@end
