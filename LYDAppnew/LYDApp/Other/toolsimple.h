//
//  toolsimple.h
//  LYDApp
//
//  Created by fcl on 17/3/22.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface toolsimple : NSObject
+(toolsimple*) sharedPersonalData ;
@property ( nonatomic) NSInteger  isalert;
@property ( nonatomic) NSInteger  isAnZhuang;//判断首付是刚安装进入用于调整view的位置1.为第一次
@end
@interface UIView (toolsimple)
//获取view所在的控制器
-(UIViewController*) parentController;
@end
