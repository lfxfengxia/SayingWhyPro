//
//  DSYSocityCollectionViewCell.m
//  LYDApp
//
//  Created by yidai on 16/11/11.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYSocityCollectionViewCell.h"

@interface DSYSocityCollectionViewCell ()

@property (nonatomic, strong) UIView *bgView;  /**< 背景视图 */

@end

@implementation DSYSocityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews {
    self.bgView = [[UIView alloc] init];
    [self.contentView addSubview:_bgView];
    
    self.iconView = [[UIImageView alloc] init];
    [self.bgView addSubview:_iconView];
    
    self.socityNameLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_socityNameLabel];
    self.socityNameLabel.textColor = rgba(49, 49, 49, 1);
    self.socityNameLabel.font = DSY_NORMALFONT_13;
    self.socityNameLabel.textAlignment = NSTextAlignmentCenter;
}

// 只会被调用一次
- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.backgroundColor = rgba(249, 249, 249, 1);
    self.bgView.frame = self.contentView.bounds;
    self.bgView.backgroundColor = rgba(249, 249, 249, 1);
    self.iconView.frame = CGRectMake(0, Y(6), H(43), H(43));
    self.iconView.centerX = self.bgView.centerX;
    
    self.socityNameLabel.frame = CGRectMake(0, self.iconView.maxY, self.bgView.width, H(28));
    
}

@end
