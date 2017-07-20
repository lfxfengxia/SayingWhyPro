//
//  XYBannerModel.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/3.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSYBaseModel.h"

@interface XYBannerModel : DSYBaseModel

@property (nonatomic, copy,setter=setId:) NSString *bannerId;
//@property (nonatomic, copy) NSString *site_id;
//@property (nonatomic, copy) NSString *category_id;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *Thumb;
//@property (nonatomic, copy) NSString *data_category_id;
//@property (nonatomic, copy) NSString *data_id;
//@property (nonatomic, copy) NSString *sort;
//@property (nonatomic, copy) NSString *is_enable;
//@property (nonatomic, copy,setter=setDescription:) NSString *bannerDescription;
//@property (nonatomic, copy) NSString *create_time;
//@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, copy) NSString *sortOrder;

@end
