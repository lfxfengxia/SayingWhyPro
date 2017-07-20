//
//  AlertFenXiangGuoDongVCNew.h
//  LYDApp
//
//  Created by fcl on 2017/5/27.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PictureBlock)();
@interface AlertFenXiangGuoDongVCNew : UIViewController
- (instancetype)initWithImageName:(NSString *)imageName ButtonName:(NSString *)btnName  Amount:(NSString *)amount  JumpBlock:(PictureBlock)pictureBlock;
@end
