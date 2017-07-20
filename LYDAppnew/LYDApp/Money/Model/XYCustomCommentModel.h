//
//  XYCustomCommentModel.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYCustomCommentModel : NSObject

//@property (nonatomic, strong) NSString  *commentId;
@property (nonatomic, strong) NSString  *content;
@property (nonatomic, strong) NSString  *createTime;
@property (nonatomic, strong) NSString  *userRealName;
@property (nonatomic, strong) NSString  *userPhone;
@property (nonatomic, strong) NSString  *replayContent;
@property (nonatomic, assign) CGFloat   cellHeight;

@end
