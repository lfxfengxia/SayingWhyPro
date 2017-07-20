//
//  XYBidZhuanXiangCell.m
//  LYDApp
//
//  Created by fcl on 2017/4/18.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "XYBidZhuanXiangCell.h"
@interface XYBidZhuanXiangCell ()

@property (nonatomic, strong) UILabel   *rateLabel;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *rateTextLabel;
@property (nonatomic, strong) UILabel   *startMoneyLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UIImageView   *imgBg;

@end
@implementation XYBidZhuanXiangCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.contentView.backgroundColor = [UIColor redColor];
        [self createUIWithFrame:frame];
    }
    return self;
}

- (void)createUIWithFrame:(CGRect)frame
{
    //    CGFloat itemW = (kSCREENW-KWidth(10))/2;
    //
    //
    //    CGFloat itemH = KHeight(101);
    //self.backgroundColor=[UIColor redColor];
    
    //    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(17), KWidth(136/2), KHeight(20))];
    //    self.rateLabel.textColor = ORANGECOLOR;
    //    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(28)];
    //    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    //    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    //    [self.contentView addSubview:self.rateLabel];
    //
    //    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.x, self.rateLabel.maxY + KHeight(15), KWidth(136/2), KHeight(11))];
    //    self.rateTextLabel.textColor = TEXTGARY;
    //    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    //    //    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    //    self.rateTextLabel.adjustsFontSizeToFitWidth = YES;
    //    self.rateTextLabel.text = @"预期年化利率";
    //    [self.contentView addSubview:self.rateTextLabel];
    //
    //    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.maxX + KWidth(25), KHeight(17), self.width - KWidth(20) * 2 - KWidth(136/2) - KWidth(10), KHeight(15))];
    //    self.titleLabel.font = [UIFont boldSystemFontOfSize:KHeight(16)];
    //    self.titleLabel.textColor = [UIColor blackColor];
    //    [self.contentView addSubview:self.titleLabel];
    //
    //    self.startMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.maxY + KHeight(13), KWidth(62), KHeight(17))];
    //    self.startMoneyLabel.textColor = [UIColor colorWithRed:0.40 green:0.61 blue:0.91 alpha:1.00];
    //    self.startMoneyLabel.font = [UIFont systemFontOfSize:KHeight(8)];
    //    self.startMoneyLabel.layer.borderColor = [UIColor colorWithRed:0.40 green:0.61 blue:0.91 alpha:1.00].CGColor;
    //    self.startMoneyLabel.textAlignment = NSTextAlignmentCenter;
    //    self.startMoneyLabel.layer.borderWidth = 0.5f;
    //    //self.startMoneyLabel.adjustsFontSizeToFitWidth = YES;
    //    [self.contentView addSubview:self.startMoneyLabel];
    //
    //    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.startMoneyLabel.maxX + KWidth(8), self.startMoneyLabel.y, KWidth(60), KHeight(17))];
    //    self.timeLabel.textColor = [UIColor colorWithRed:0.40 green:0.61 blue:0.91 alpha:1.00];
    //    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(8)];
    //    self.timeLabel.layer.borderColor = [UIColor colorWithRed:0.40 green:0.61 blue:0.91 alpha:1.00].CGColor;
    //    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    //    self.timeLabel.layer.borderWidth = 0.5f;
    //    //self.timeLabel.adjustsFontSizeToFitWidth = YES;
    //    [self.contentView addSubview:self.timeLabel];
    
    
    
    //    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KHeight(17), self.width - KWidth(20) * 2 - KWidth(136/2) - KWidth(10), KHeight(15))];
    //    self.titleLabel.font = [UIFont boldSystemFontOfSize:KHeight(16)];
    //    self.titleLabel.textColor = [UIColor blackColor];
    //    [self.contentView addSubview:self.titleLabel];
    
    
    
    //    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    //    btn.backgroundColor=[UIColor redColor];
    //
    //    [self.contentView addSubview:btn];
    
    self.imgBg=[[UIImageView alloc] init];
    self.imgBg.frame=CGRectMake(0, 0, self.width, self.height);
    UIImage *img=[UIImage imageNamed:@"xiangshoubiaocell"];
    self.imgBg.image=img;
    //self.imgBg.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.imgBg];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.width, self.height/4)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:KHeight(15)];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.imgBg addSubview:self.titleLabel];
    
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height/4, self.width,self.height/4)];
    self.rateLabel.textColor = ORANGECOLOR;
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    [self.imgBg addSubview:self.rateLabel];
    
    
    
    
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,2*self.height/4, self.width,self.height/4)];
    self.rateTextLabel.textColor = [UIColor grayColor];
    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(15)];
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.adjustsFontSizeToFitWidth = YES;
    self.rateTextLabel.text = @"预期年化利率";
    [self.imgBg addSubview:self.rateTextLabel];
    
    
    self.startMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,3*self.height/4, self.width/2, self.height/4)];
    self.startMoneyLabel.textColor =TEXTGARY;
    self.startMoneyLabel.font = [UIFont systemFontOfSize:KHeight(10)];
    
    self.startMoneyLabel.textAlignment = NSTextAlignmentCenter;
    
    //self.startMoneyLabel.adjustsFontSizeToFitWidth = YES;
    [self.imgBg addSubview:self.startMoneyLabel];
    
    
    
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.startMoneyLabel.maxX,3*self.height/4, self.width/2,self.height/4)];
    self.timeLabel.textColor = TEXTGARY;
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(10)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    //self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self.imgBg addSubview:self.timeLabel];
    
    
    
}

- (void)setModel:(XYSanBidModel *)model
{
    _model = model;
    
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%",[model.apr floatValue]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    self.startMoneyLabel.text = [NSString stringWithFormat:@"单份金额%@元",model.minAmount];
    NSMutableString *period = [NSMutableString string];
    if ([self.model.periodUnit integerValue] == 0) {
        period = [NSMutableString stringWithFormat:@"%@个月",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == 1) {
        period = [NSMutableString stringWithFormat:@"%@天",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == -1) {
        period = [NSMutableString stringWithFormat:@"%@年",self.model.periods];
    } else if ([self.model.periodUnit integerValue] == 2) {
        period = [NSMutableString stringWithFormat:@"%@周",self.model.periods];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"投资期限%@",period];
}

+ (NSString *)identifier
{
    return @"XYBidZhuanXiangCell";
}

@end
