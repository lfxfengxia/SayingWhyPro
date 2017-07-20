//
//  CouponsView.m
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/27.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "CouponsView.h"

@implementation CouponsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIImageView *image=[[UIImageView alloc]init];
        image.image=[UIImage imageNamed:@"优惠券"];
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(KWidth(12));
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(KWidth(20), KHeight(14)));
        }];
        
        UILabel *label=[[UILabel alloc]init];
        label.text=@"优惠券";
        label.textColor=RGB(34, 34, 34);
        label.font=[UIFont systemFontOfSize:KHeight(12)];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).mas_offset(KWidth(10));
            make.top.and.bottom.equalTo(self);
        }];
        
        self.jiantou=[[UIImageView alloc]init];
        self.jiantou.image=[UIImage imageNamed:@"进入"];
        [self addSubview:self.jiantou];
        [self.jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(-KWidth(12));
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(KWidth(8), KHeight(16)));
        }];
        
        self.Coupons=[[UILabel alloc]init];
        self.Coupons.textColor=RGB(255, 121, 1);
        self.Coupons.font= [UIFont systemFontOfSize:KWidth(12)];
        self.Coupons.textAlignment=NSTextAlignmentRight;
        [self addSubview:self.Coupons];
        [self.Coupons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.jiantou.mas_left).mas_offset(-KWidth(10));
            make.top.and.bottom.equalTo(self);
        }];
    }
    return self;
}

@end
