//
//  BuyMarkHeadViewYiYueBiao.h
//  LYDApp
//
//  Created by fcl on 2017/6/27.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"
@interface BuyMarkHeadViewYiYueBiao : UIView
@property(nonatomic,strong)UILabel *investTime;
@property(nonatomic,strong)UILabel *eachAmount;
@property(nonatomic,strong)UILabel *earningspercent;
-(void)getAccount:(XYPlanModel *)model;
@end
