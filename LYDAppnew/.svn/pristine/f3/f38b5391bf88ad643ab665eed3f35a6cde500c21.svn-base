//
//  XYErrorHud.h
//  LYDApp
//
//  Created by dookay_73 on 2016/11/25.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@class XYErrorHud;

@protocol XYErrorHudDelegate <NSObject>

- (void)errorHud:(XYErrorHud *)hud doneBtnClicked:(UIButton *)button;

- (void)errorHud:(XYErrorHud *)hud cancleBtnClicked:(UIButton *)button;

@end

@interface XYErrorHud : UIView

@property (nonatomic, weak) id<XYErrorHudDelegate> delegate;

@property (nonatomic, strong) UIView        *bgView;
@property (nonatomic, strong) UIImageView   *bgIV;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIButton  *doneBtn;
@property (nonatomic, strong) UIButton  *cancleBtn;
@property (nonatomic, assign) BOOL      doneBtnHidden;

- (instancetype)initWithTitle:(NSString *)title andDoneBtnTitle:(NSString *)doneBtnTitle andDoneBtnHidden:(BOOL)hidden;

+ (void)showMessage:(NSString *)message toView:(UIView *)view;
@end
