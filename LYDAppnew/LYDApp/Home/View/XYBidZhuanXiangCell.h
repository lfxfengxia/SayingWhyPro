//
//  XYBidZhuanXiangCell.h
//  LYDApp
//
//  Created by fcl on 2017/4/18.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSanBidModel.h"
@interface XYBidZhuanXiangCell : UICollectionViewCell
@property (nonatomic, strong) XYSanBidModel *model;

+ (NSString *)identifier;
@end
