//
//  RBMessageModel.h
//  LYDApp
//
//  Created by Riber on 16/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBMessageModel : DSYBaseModel

@property (nonatomic,   copy, setter=setId:) NSString *messageId;
@property (nonatomic,   copy) NSString *title;
@property (nonatomic,   copy) NSString *desTitle;
@property (nonatomic,   copy) NSString *createTime;
@property (nonatomic,   copy) NSString *body;
@property (nonatomic, assign) BOOL read;

@end
