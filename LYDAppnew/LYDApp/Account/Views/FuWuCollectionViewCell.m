//
//  FuWuCollectionViewCell.m
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/30.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "FuWuCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation FuWuCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.image=[[UIImageView alloc]init];
        //self.image.backgroundColor=RGB(<#r#>, <#g#>, <#b#>);
        [self.contentView addSubview:self.image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KWidth(68), KHeight(60)));
        }];
        
        self.label=[[UILabel alloc]init];
        self.label.font= [UIFont systemFontOfSize:KWidth(14)];
        self.label.textColor=RGB(34, 34, 34);
        self.label.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.contentView);
            make.top.equalTo(self.image.mas_bottom).mas_offset(KHeight(14));
            make.height.mas_equalTo(KHeight(17));
        }];
        
        self.NewBtn=[[UIButton alloc]init];
        [self.NewBtn setBackgroundImage:[UIImage imageNamed:@"NewBTN"] forState:UIControlStateNormal];
        [self.NewBtn setTitle:@"NEW" forState:UIControlStateNormal];
        self.NewBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        [self.NewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.NewBtn];
        [self.NewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).mas_offset(-KWidth(13));
            make.top.equalTo(self.contentView.mas_top);
            make.size.mas_equalTo(CGSizeMake(KWidth(30), KHeight(15)));
        }];
    }
    return self;
}

-(void)FuWuCollectionViewCellWithDic:(NSMutableDictionary *)dic{
    [self.image setImageWithURL:[NSURL URLWithString:dic[@"serviceImg"]] placeholderImage:nil];
    self.label.text=dic[@"serviceTitle"];
    BOOL New=[[dic objectForKey:@"serviceNew"] boolValue];
    if(New)
    {
        self.NewBtn.hidden=NO;
    }else
    {
        self.NewBtn.hidden=YES;
    }
}

@end
