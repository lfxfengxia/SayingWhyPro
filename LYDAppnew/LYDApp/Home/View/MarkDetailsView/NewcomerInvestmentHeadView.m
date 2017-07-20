//
//  NewcomerInvestmentHeadView.m
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/28.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "NewcomerInvestmentHeadView.h"

@implementation NewcomerInvestmentHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=4.0;
        self.layer.shadowOpacity=1;
        self.layer.shadowOffset=CGSizeMake(0, KHeight(4));
        self.layer.shadowRadius=4;
        self.layer.shadowColor=[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1].CGColor;
        UILabel *title=[[UILabel alloc]init];
        title.font=[UIFont systemFontOfSize:12*hx];
        title.textColor=RGB(255, 121, 1);
        title.text=@"预期年化利率";
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).mas_offset(KHeight(20));
            make.height.mas_equalTo(KHeight(14));
        }];
        
        UIImageView *leftImage=[[UIImageView alloc]init];
        leftImage.image=[UIImage imageNamed:@"左修饰"];
        [self addSubview:leftImage];
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(title.mas_left).mas_offset(-KWidth(8));
            make.top.equalTo(self.mas_top).mas_offset(KHeight(27));
            make.size.mas_equalTo(CGSizeMake(KWidth(18), KHeight(1)));
        }];
        
        UIImageView *rightImage=[[UIImageView alloc]init];
        rightImage.image=[UIImage imageNamed:@"右修饰"];
        [self addSubview:rightImage];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).mas_offset(+KWidth(8));
            make.top.equalTo(self.mas_top).mas_offset(KHeight(27));
            make.size.mas_equalTo(CGSizeMake(KWidth(18), KHeight(1)));
        }];
        
        
        self.earningspercent=[[UILabel alloc]init];
        self.earningspercent.textAlignment=NSTextAlignmentCenter;
        self.earningspercent.textColor=RGB(255, 121, 1);
        self.earningspercent.font=[UIFont systemFontOfSize:KHeight(34)];
        [self addSubview:self.earningspercent];
        [self.earningspercent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.top.equalTo(title.mas_bottom).mas_offset(KHeight(15));
            make.height.mas_equalTo(KHeight(34));
        }];
        
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=RGB(242, 242, 242);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.earningspercent.mas_bottom).mas_offset(KHeight(23));
            make.size.mas_equalTo(CGSizeMake(KWidth(1), KHeight(29)));
        }];
        
        UILabel *date=[[UILabel alloc]init];
        date.textColor=RGB(134, 134, 134);
        date.font=[UIFont systemFontOfSize:KHeight(12)];
        date.textAlignment=NSTextAlignmentCenter;
        date.text=@"投资期限";
        [self addSubview:date];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(line.mas_left);
            make.top.equalTo(self.earningspercent.mas_bottom).mas_offset(KHeight(20));
            make.size.mas_equalTo(CGSizeMake(KWidth(110), KHeight(14)));
        }];
        
        self.investTime=[[UILabel alloc]init];
        self.investTime.textAlignment=NSTextAlignmentCenter;
        self.investTime.font=[UIFont systemFontOfSize:KHeight(14)];
        self.investTime.textColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
        [self addSubview:self.investTime];
        [self.investTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(date);
            make.top.equalTo(date.mas_bottom).mas_offset(KHeight(4));
            make.height.mas_equalTo(KHeight(17));
        }];
        
        UILabel *amount=[[UILabel alloc]init];
        amount.textColor=RGB(134, 134, 134);
        amount.textAlignment=NSTextAlignmentCenter;
        amount.font=[UIFont systemFontOfSize:KHeight(12)];
        amount.text=@"单份金额";
        [self addSubview:amount];
        [amount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line.mas_right);
            make.top.equalTo(self.earningspercent.mas_bottom).mas_offset(KHeight(20));
            make.size.mas_equalTo(CGSizeMake(KWidth(110), KHeight(14)));
        }];
        
        self.eachAmount=[[UILabel alloc]init];
        self.eachAmount.textAlignment=NSTextAlignmentCenter;
        self.eachAmount.font=[UIFont systemFontOfSize:KHeight(14)];
        
        self.eachAmount.textColor=RGB(34, 34, 34);
        [self addSubview:self.eachAmount];
        [self.eachAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(amount);
            make.top.equalTo(date.mas_bottom).mas_offset(KHeight(4));
            make.height.mas_equalTo(KHeight(17));
        }];
    }
    return self;
}

-(void)getAccount:(XYSanBidModel *)model{
    self.earningspercent.text=[NSString stringWithFormat:@"%0.2f%%",[model.apr floatValue]];
    self.investTime.text=[NSString stringWithFormat:@"%@天",model.periods];
    self.eachAmount.text=[NSString stringWithFormat:@"%@元",model.minAmount];
}
@end
