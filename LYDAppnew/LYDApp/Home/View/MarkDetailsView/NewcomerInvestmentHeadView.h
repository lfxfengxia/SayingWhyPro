//
//  NewcomerInvestmentHeadView.h
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/28.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSanBidModel.h"

@interface NewcomerInvestmentHeadView : UIView
@property(nonatomic,strong)UILabel *investTime;
@property(nonatomic,strong)UILabel *eachAmount;
@property(nonatomic,strong)UILabel *earningspercent;
-(void)getAccount:(XYSanBidModel *)model;
@end
