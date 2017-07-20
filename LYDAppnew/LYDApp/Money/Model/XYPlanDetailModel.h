//
//  XYPlanDetailModel.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPlanDetailModel : NSObject

@property (nonatomic, strong) NSString  *planDetailId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *borrowerName;
@property (nonatomic, copy) NSString *borrowerCard;
@property (nonatomic, copy) NSString *apr;
@property (nonatomic, copy) NSString *periodsLeft;
@property (nonatomic, copy) NSString *loanAmount;
@property (nonatomic, copy) NSString *joinAmount;


@end
