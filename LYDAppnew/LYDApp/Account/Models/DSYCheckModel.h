//
//  DSYCheckModel.h
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseModel.h"

@interface DSYCheckModel : DSYBaseModel

@property (nonatomic, assign) CGFloat backAmount;
@property (nonatomic, assign) NSUInteger backDate;
@property (nonatomic, assign) NSUInteger actualDate;

@property (nonatomic,   copy) NSString *title;
@property (nonatomic, assign) NSInteger periods;
@property (nonatomic,   copy) NSString *receiveTime;
@property (nonatomic, assign) CGFloat receiveAmount;
@property (nonatomic,   copy) NSString *statusDesc;
@property (nonatomic,   copy) NSString *realReceiveTime;
//@property (nonatomic,   copy) NSString *title;
//@property (nonatomic, assign, setter=setId:) NSInteger transferId;
//@property (nonatomic, assign) CGFloat bidRate;
//@property (nonatomic, assign) CGFloat receivingAmount;
//@property (nonatomic, assign) CGFloat investId;
//@property (nonatomic,   copy) NSString *createTime;
//@property (nonatomic, assign) NSInteger type;
//@property (nonatomic,   copy) NSString *transferReason;
//@property (nonatomic,   copy) NSString *realRate;
//@property (nonatomic, assign) NSInteger transferPrice;
//@property (nonatomic, assign) NSInteger period;
//@property (nonatomic, assign) NSInteger leftDay;
//@property (nonatomic, assign) NSInteger status;


@end
