//
//  XYBidCell.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/3.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSanBidModel.h"

@interface XYBidCell : UICollectionViewCell

@property (nonatomic, strong) XYSanBidModel *model;

+ (NSString *)identifier;

@end
