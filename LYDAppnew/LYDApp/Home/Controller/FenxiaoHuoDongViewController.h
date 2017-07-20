//
//  FenxiaoHuoDongViewController.h
//  LYDApp
//
//分享活动
//
//  Created by fcl on 2017/4/25.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseDetailController.h"
@class XYBannerModel;
@interface FenxiaoHuoDongViewController : DSYFinancingBaseDetailController

@property (nonatomic, strong) XYBannerModel *banner;
@property(nonatomic,strong)UIView *fugaiview;

@property (nonatomic,copy)NSString *describe;
@property (nonatomic,copy)NSString *imgStr;
@property (nonatomic,copy)NSString *partookStr;
@property (nonatomic,copy)NSString *partookUrl;
@property (nonatomic,copy)NSString *strtitle;




@property (nonatomic, copy) NSDictionary  *gongxiangDic;


@end
