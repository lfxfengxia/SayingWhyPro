//
//  XYHomeLDBShouQingCell.m
//  LYDApp
//
//  Created by fcl on 2017/6/21.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "XYHomeLDBShouQingCell.h"
#import "Helper.h"


@interface XYHomeLDBShouQingCell ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIImageView   *titleLabelBg;
@property (nonatomic, strong) UIImageView   *imgLine;
@property (nonatomic, strong) UILabel   *rateLabel;
@property (nonatomic, strong) UILabel   *rateTextLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UILabel   *timeTextLabel;
@property (nonatomic, strong) UILabel   *moneyLabel;
@property (nonatomic, strong) UILabel   *moneyTextLabel;
@property (nonatomic, strong) UILabel   *payWayLabel;
@property (nonatomic, strong) UILabel   *payWayTextLabel;
@property (nonatomic, strong) UILabel   *aprDiscountLabel;
@property (nonatomic, strong) UIView   *jiangeView;
@property (nonatomic, strong) UIButton   *btnqiangou;



//@property (nonatomic, strong)  UILabel  *loanScheduleLabel;

@property (nonatomic, strong) UILabel *lblloanSchedule;//标的进度
@property (nonatomic, strong) UIView *view_2;//进度条
@property(nonatomic,strong) UIImageView *smallImageView;


@end

@implementation XYHomeLDBShouQingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYHomeLDBShouQingCell";
    XYHomeLDBShouQingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYHomeLDBShouQingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    
    //    UILabel *lblfenggengxian=[[UILabel alloc] initWithFrame:CGRectMake(KWidth(10), 0, WIDTH-KWidth(20), KHeight(0.5))];
    //    lblfenggengxian.backgroundColor=[UIColor grayColor];
    //    [self.contentView addSubview:lblfenggengxian];
    //
    //
    //    CGFloat hMargin = (kSCREENW - (KWidth(138/2) * 4) - (KWidth(20) * 2)) / 3;
    //    CGFloat vMargin = KHeight(12);
    //    CGFloat labelW  = KWidth(138/2);
    //    CGFloat labelH  = KHeight(14);
    //    CGFloat textlabelH  = KHeight(11);
    //
    //
    //
    //
    //
    //    self.jiangeView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, 10)];
    //    self.jiangeView.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    //    self.jiangeView.hidden=YES;
    //    self.jiangeView.layer.borderWidth=0;
    //    [self.contentView addSubview:self.jiangeView];
    //
    //
    //    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kSCREENW - (KWidth(12) * 2), KHeight(12))];
    //    self.titleLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    //    self.titleLabel.textColor = [UIColor whiteColor];
    //    [self.titleLabelBg addSubview:self.titleLabel];
    //
    //    self.titleLabelBg = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(12), KHeight(10), kSCREENW - (KWidth(12) * 2)+30, KHeight(12)+30)];
    //
    //
    //    self.titleLabelBg.image=[UIImage imageNamed:@"title_button_ba"];
    //
    //
    //    [self.titleLabelBg addSubview:self.titleLabel];
    //    [self.contentView addSubview:self.titleLabelBg];
    //
    //    //还款方式
    //    self.payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabelBg.maxX + KWidth(10), self.titleLabelBg.frame.origin.y, kSCREENW, self.titleLabelBg.frame.size.height)];
    //    //    self.payWayLabel.numberOfLines = 2;
    //    self.payWayLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    //    self.payWayLabel.textAlignment = NSTextAlignmentLeft;
    //    self.payWayLabel.textColor = TEXTBLACK;
    //    //    self.payWayLabel.adjustsFontSizeToFitWidth = YES;
    //    [self.contentView addSubview:self.payWayLabel];
    //    //self.payWayLabel.backgroundColor=[UIColor redColor]
    //
    //
    //
    //
    //    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(12), self.titleLabelBg.maxY + vMargin, (kSCREENW/2-KWidth(12))/3, KHeight(30))];
    //    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(30)];
    //    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    //    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    //    self.rateLabel.textColor = ORANGECOLOR;
    //
    //
    //    [self.contentView addSubview:self.rateLabel];
    //
    //    self.aprDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.maxX, self.rateLabel.frame.origin.y+self.rateLabel.frame.size.height/2, 2*(kSCREENW/2-KWidth(12))/3, self.rateLabel.frame.size.height/2)];
    //    self.aprDiscountLabel.textColor = TEXTGARY;
    //    self.aprDiscountLabel.textAlignment = NSTextAlignmentLeft;
    //    self.aprDiscountLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    //    self.aprDiscountLabel.adjustsFontSizeToFitWidth = YES;
    //    self.aprDiscountLabel.text = @"%(贴息)";
    //    self.aprDiscountLabel.textColor=ORANGECOLOR;
    //    [self.contentView addSubview:self.aprDiscountLabel];
    //
    //
    //    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.x, self.rateLabel.maxY + KHeight(6), labelW, textlabelH)];
    //    self.rateTextLabel.textColor = TEXTGARY;
    //    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    //    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    //    self.rateTextLabel.adjustsFontSizeToFitWidth = YES;
    //    self.rateTextLabel.text = @"预期年化利率";
    //    [self.contentView addSubview:self.rateTextLabel];
    //
    //
    //    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENW/2,  self.rateLabel.frame.origin.y+self.rateLabel.frame.size.height/2, (kSCREENW/2-KWidth(12))/2, labelH)];
    //    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(16)];
    //    self.timeLabel.textColor = [UIColor blackColor];
    //    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    //    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    //    [self.contentView addSubview:self.timeLabel];
    //
    //    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENW/2, self.rateLabel.maxY + KHeight(6), self.timeLabel.frame.size.width, textlabelH)];
    //    self.timeTextLabel.textColor = TEXTGARY;
    //    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    //    self.timeTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    //    self.timeTextLabel.adjustsFontSizeToFitWidth = YES;
    //    self.timeTextLabel.text = @"借款期限";
    //    [self.contentView addSubview:self.timeTextLabel];
    //
    //
    //
    //    self.btnqiangou = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.btnqiangou.frame=CGRectMake(self.timeLabel.maxX,  self.rateLabel.frame.origin.y, (kSCREENW/2-KWidth(12))/2, self.rateLabel.frame.size.height);
    //    self.btnqiangou.backgroundColor=[UIColor orangeColor];
    //    [self.btnqiangou setTitle:@"抢购" forState:UIControlStateNormal];
    //    self.btnqiangou.titleLabel.textColor=[UIColor whiteColor];
    //    self.btnqiangou.layer.cornerRadius=15;
    //    [self.contentView addSubview:self.btnqiangou];
    //
    //
    //
    //    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.maxX, self.rateLabel.maxY + KHeight(6), (kSCREENW/2-KWidth(12))/2, textlabelH)];
    //    self.moneyLabel.textColor = TEXTGARY;
    //    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    //    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    //    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    //    [self.contentView addSubview:self.moneyLabel];
    //
    //
    //
    //    //    UIImageView *lblline2=[[UIImageView alloc] initWithFrame:CGRectMake(self.moneyTextLabel.maxX+10, self.titleLabelBg.maxY + vMargin+20, 1, labelH+textlabelH+vMargin)];
    //    //    lblline2.image=[UIImage imageNamed:@"hangline"];
    //    //    [self.contentView addSubview:lblline2];
    //
    //
    //
    //
    //
    //
    //
    //
    //    //百分比
    //
    //    //        _lblloanSchedule = [[UILabel alloc]initWithFrame:CGRectMake(KWidth(20)+30*(kSCREENW-2*KWidth(20))*0.01, self.titleLabelBg.maxY, 200, 20)];
    //    //        _lblloanSchedule.text=[NSString stringWithFormat:@"30%%"];
    //    //        _lblloanSchedule.textColor=[UIColor orangeColor];
    //    //        _lblloanSchedule.font=[UIFont systemFontOfSize:7];
    //    //        _lblloanSchedule.textAlignment=NSTextAlignmentLeft;
    //    //        [self.contentView addSubview:_lblloanSchedule];
    //
    //    UIView *view_1 = [[UIView alloc]initWithFrame:CGRectMake(KWidth(20), self.rateTextLabel.maxY+KHeight(12),kSCREENW-2*KWidth(20), 2)];
    //    view_1.backgroundColor=[UIColor lightGrayColor];
    //    //    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(88*hx+model.loanSchedule *1.14*hx-20*hx+36*hx, 24*hy, 40*hx, 10*hy)];
    //
    //    [self.contentView addSubview:view_1];
    //
    //
    //    _view_2= [[UIView alloc]initWithFrame:CGRectMake(KWidth(20), self.rateTextLabel.maxY+KHeight(12), 30*(kSCREENW-2*KWidth(20))*0.01, 2)];
    //    //    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(88*hx+model.loanSchedule *1.14*hx-20*hx+36*hx, 24*hy, 40*hx, 10*hy)];
    //    _view_2.backgroundColor=[UIColor orangeColor];
    //    [self.contentView addSubview:_view_2];
    //
    //
    //    _smallImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_view_2.maxX, self.rateTextLabel.maxY+KHeight(12)-4, 10, 10)];
    //    _smallImageView.image = [UIImage imageNamed:@"椭圆-5"];
    //    [self.contentView addSubview:_smallImageView];
    
    
    UILabel *lblfenggengxian=[[UILabel alloc] initWithFrame:CGRectMake(KWidth(10), 0, WIDTH-KWidth(20), KHeight(0.5))];
    lblfenggengxian.backgroundColor=RGB(201, 201, 201);
    [self.contentView addSubview:lblfenggengxian];
    
    
    CGFloat hMargin = (kSCREENW - (KWidth(138/2) * 4) - (KWidth(20) * 2)) / 3;
    CGFloat vMargin = KHeight(12);
    CGFloat labelW  = KWidth(138/2);
    CGFloat labelH  = KHeight(14);
    CGFloat textlabelH  = KHeight(11);
    
    
    
    
    
    self.jiangeView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, 10)];
    self.jiangeView.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    self.jiangeView.hidden=YES;
    self.jiangeView.layer.borderWidth=0;
    [self.contentView addSubview:self.jiangeView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kSCREENW - (KWidth(12) * 2), KHeight(12))];
    self.titleLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.titleLabelBg addSubview:self.titleLabel];
    
    self.titleLabelBg = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(12), KHeight(10), kSCREENW - (KWidth(12) * 2)+30, KHeight(12)+30)];
    
    
    self.titleLabelBg.image=[UIImage imageNamed:@"title_button_ba"];
    
    
    [self.titleLabelBg addSubview:self.titleLabel];
    [self.contentView addSubview:self.titleLabelBg];
    
    //还款方式
    self.payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabelBg.maxX + KWidth(10), self.titleLabelBg.frame.origin.y, kSCREENW, self.titleLabelBg.frame.size.height)];
    //    self.payWayLabel.numberOfLines = 2;
    self.payWayLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.payWayLabel.textAlignment = NSTextAlignmentLeft;
    self.payWayLabel.textColor = TEXTBLACK;
    //    self.payWayLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.payWayLabel];
    //self.payWayLabel.backgroundColor=[UIColor redColor]
    
    
    
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(12), self.titleLabelBg.maxY + vMargin, (kSCREENW/2-KWidth(12))/3, KHeight(30))];
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(30)];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    self.rateLabel.textColor =  [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1/1.0];
;
    
    
    [self.contentView addSubview:self.rateLabel];
    
    self.aprDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.maxX, self.rateLabel.frame.origin.y+self.rateLabel.frame.size.height/2, 2*(kSCREENW/2-KWidth(12))/3, self.rateLabel.frame.size.height/2)];
    self.aprDiscountLabel.textColor = TEXTGARY;
    self.aprDiscountLabel.textAlignment = NSTextAlignmentLeft;
    self.aprDiscountLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    self.aprDiscountLabel.adjustsFontSizeToFitWidth = YES;
    self.aprDiscountLabel.text = @"%(贴息)";
    self.aprDiscountLabel.textColor= [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1/1.0];
;
    [self.contentView addSubview:self.aprDiscountLabel];
    
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.x, self.rateLabel.maxY + KHeight(6), labelW, textlabelH)];
    self.rateTextLabel.textColor = TEXTGARY;
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.rateTextLabel.adjustsFontSizeToFitWidth = YES;
    self.rateTextLabel.text = @"预期年化利率";
    [self.contentView addSubview:self.rateTextLabel];
    
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENW/2,  self.rateLabel.frame.origin.y+self.rateLabel.frame.size.height/2, (kSCREENW/2-KWidth(12))/2, labelH)];
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(16)];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.timeLabel];
    
    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENW/2, self.rateLabel.maxY + KHeight(6), self.timeLabel.frame.size.width, textlabelH)];
    self.timeTextLabel.textColor = TEXTGARY;
    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.timeTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.timeTextLabel.adjustsFontSizeToFitWidth = YES;
    self.timeTextLabel.text = @"借款期限";
    [self.contentView addSubview:self.timeTextLabel];
    
    
    
    self.btnqiangou = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnqiangou.frame=CGRectMake(self.timeLabel.maxX,  self.rateLabel.frame.origin.y, (kSCREENW/2-KWidth(12))/2, self.rateLabel.frame.size.height);
    self.btnqiangou.backgroundColor= [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1/1.0];

    [self.btnqiangou setTitle:@"售罄" forState:UIControlStateNormal];
    self.btnqiangou.titleLabel.textColor=[UIColor whiteColor];
    self.btnqiangou.layer.cornerRadius=15;
    [self.contentView addSubview:self.btnqiangou];
    
    
    
    
    
    
    
    //    UIImageView *lblline2=[[UIImageView alloc] initWithFrame:CGRectMake(self.moneyTextLabel.maxX+10, self.titleLabelBg.maxY + vMargin+20, 1, labelH+textlabelH+vMargin)];
    //    lblline2.image=[UIImage imageNamed:@"hangline"];
    //    [self.contentView addSubview:lblline2];
    
    
    
    
    
    
    
    
    //百分比
    
    //        _lblloanSchedule = [[UILabel alloc]initWithFrame:CGRectMake(KWidth(20)+30*(kSCREENW-2*KWidth(20))*0.01, self.titleLabelBg.maxY, 200, 20)];
    //        _lblloanSchedule.text=[NSString stringWithFormat:@"30%%"];
    //        _lblloanSchedule.textColor=[UIColor orangeColor];
    //        _lblloanSchedule.font=[UIFont systemFontOfSize:7];
    //        _lblloanSchedule.textAlignment=NSTextAlignmentLeft;
    //        [self.contentView addSubview:_lblloanSchedule];
    
    UIView *view_1 = [[UIView alloc]initWithFrame:CGRectMake(KWidth(20), self.rateTextLabel.maxY+KHeight(12),kSCREENW-2*KWidth(20), 2)];
    view_1.backgroundColor=[UIColor lightGrayColor];
    //    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(88*hx+model.loanSchedule *1.14*hx-20*hx+36*hx, 24*hy, 40*hx, 10*hy)];
    
    [self.contentView addSubview:view_1];
    
    
    _view_2= [[UIView alloc]initWithFrame:CGRectMake(KWidth(20), self.rateTextLabel.maxY+KHeight(12), 30*(kSCREENW-2*KWidth(20))*0.01, 2)];
    //    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(88*hx+model.loanSchedule *1.14*hx-20*hx+36*hx, 24*hy, 40*hx, 10*hy)];
    _view_2.backgroundColor=[UIColor orangeColor];
    [self.contentView addSubview:_view_2];
    
    
    _smallImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_view_2.maxX, self.rateTextLabel.maxY+KHeight(12)-4, 10, 10)];
    _smallImageView.image = [UIImage imageNamed:@"椭圆-5"];
    [self.contentView addSubview:_smallImageView];
    
    
  
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.textColor = TEXTGARY;
    self.moneyLabel.textAlignment = NSTextAlignmentRight;
    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).mas_offset(-KWidth(17));
        make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-KHeight(10));
        make.height.mas_equalTo(KHeight(14));
    }];

    UIImageView *image=[[UIImageView alloc]init];
    image.image=[UIImage imageNamed:@"钱-3"];
    [self.contentView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moneyLabel.mas_left).mas_offset(-KWidth(6));
        make.centerY.equalTo(self.moneyLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KWidth(12), KHeight(12)));
    }];
    
}

- (void)setModel:(XYPlanModel *)model
{
    
    
    
    //    _model = model;
    //
    //
    //
    //    //_lblloanSchedule.text=[NSString stringWithFormat:@"%@%%",model.loanSchedule];
    //    int ttttt = [model.loanSchedule intValue];
    //
    //    _lblloanSchedule.text=[NSString stringWithFormat:@"%d%%",ttttt];
    //    if (model.loanSchedule.intValue==100) {//满标
    //        _lblloanSchedule.textColor=[UIColor grayColor];
    //        _smallImageView.image = [UIImage imageNamed:@"灰圆"];
    //        _view_2.backgroundColor = [UIColor lightGrayColor];
    //
    //
    //        self.titleLabelBg.image=[UIImage imageNamed:@"1个月标售罄背景"];
    //        self.imgLine.image=[UIImage imageNamed:@"licai_line_hui"];
    //
    //        //百分比
    //
    //        _lblloanSchedule.frame = CGRectMake(KWidth(20)+model.loanSchedule.intValue*(kSCREENW-2*KWidth(20))*0.01-10, self.titleLabelBg.maxY, 200, 20);
    //
    //
    //
    //
    //
    //        _view_2.frame=CGRectMake(KWidth(20), self.rateTextLabel.maxY+KHeight(12), model.loanSchedule.intValue*(kSCREENW-2*KWidth(20))*0.01, 2);
    //
    //
    //
    //        _smallImageView.frame= CGRectMake(_view_2.maxX, self.rateTextLabel.maxY+KHeight(12)-4, 10, 10);
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //    } else {
    //        _lblloanSchedule.textColor=[UIColor grayColor];
    //        _smallImageView.image = [UIImage imageNamed:@"椭圆-5"];
    //        _view_2.backgroundColor = [UIColor orangeColor];
    //        self.titleLabelBg.image=[UIImage imageNamed:@"1个月标背景"];
    //
    //        //百分比
    //
    //        _lblloanSchedule.frame = CGRectMake(KWidth(20)+model.loanSchedule.intValue*(kSCREENW-2*KWidth(20))*0.01-10, self.titleLabelBg.maxY, 200, 20);
    //        self.imgLine.image=[UIImage imageNamed:@"licai_line"];
    //
    //
    //
    //
    //        _view_2.frame=CGRectMake(KWidth(20), self.rateTextLabel.maxY+KHeight(12), model.loanSchedule.intValue*(kSCREENW-2*KWidth(20))*0.01, 2);
    //
    //
    //
    //        _smallImageView.frame= CGRectMake(_view_2.maxX, self.rateTextLabel.maxY+KHeight(12)-4, 10, 10);
    //
    //
    //
    //    }
    //
    //
    //
    //    self.titleLabel.text = model.title;
    //    CGFloat W=[Helper widthOfString:model.title font:[UIFont systemFontOfSize:KHeight(12)] height:KHeight(12)];
    //    self.titleLabel.frame=CGRectMake(15, 15,W, KHeight(12));
    //    self.rateLabel.text = [NSString stringWithFormat:@"%.2f",[model.apr floatValue]-[model.aprDiscount floatValue]];
    //    self.titleLabelBg.frame=CGRectMake(KWidth(12), KHeight(10),W+30, KHeight(12)+30);
    //    //self.aprDiscountLabel.text=[NSString stringWithFormat:@"+%.2f%%(贴息)",[model.aprDiscount floatValue]];
    //
    //
    //
    //
    //    NSString *Ratastr=[NSString stringWithFormat:@"%%+%.2f%%(贴息)",[model.aprDiscount floatValue]];
    //    NSUInteger loca1=(NSUInteger)(Ratastr.length-4);
    //    NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:Ratastr];
    //    [str1 addAttribute:NSForegroundColorAttributeName value:TEXTGARY range:NSMakeRange(loca1, 4)];
    //    //self.aprDiscountLabel.font = [UIFont systemFontOfSize:_font+57];
    //    self.aprDiscountLabel.attributedText = str1;
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //    NSMutableString *period = [NSMutableString string];
    //    if ([model.periodUnit integerValue] == 0) {
    //        period = [NSMutableString stringWithFormat:@"%@个月",model.periods];
    //        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
    //        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 2, 2)];
    //        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 2, 2)];
    //        self.timeLabel.attributedText = timeAttr;
    //
    //    } else if ([self.model.periodUnit integerValue] == 1) {
    //        period = [NSMutableString stringWithFormat:@"%@日",self.model.periods];
    //        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
    //        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
    //        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
    //        self.timeLabel.attributedText = timeAttr;
    //
    //    } else if ([self.model.periodUnit integerValue] == -1) {
    //        period = [NSMutableString stringWithFormat:@"%@年",self.model.periods];
    //        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
    //        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
    //        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
    //        self.timeLabel.attributedText = timeAttr;
    //
    //    } else if ([self.model.periodUnit integerValue] == 2) {
    //        period = [NSMutableString stringWithFormat:@"%@周",self.model.periods];
    //        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
    //        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
    //        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
    //        self.timeLabel.attributedText = timeAttr;
    //    }
    //
    //    //    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
    //    //    [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
    //    //    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
    //    //    self.timeLabel.attributedText = timeAttr;
    //
    //    //    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",model.leftAmount]];
    //    //    [moneyAttr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [moneyAttr length])];
    //    //    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange(0, [moneyAttr length])];
    //    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",model.leftAmount];
    //
    //    NSMutableString *payWay = [NSMutableString string];
    //
    //
    //
    //    //    PAID_MONTH_EQUAL_PRINCIPAL_INTEREST(1," 按月还款、等额本息"),
    //    //    PAID_WEEK_EQUAL_PRINCIPAL_INTEREST(2,"按周还款、等额本息"),
    //    //    PAID_MONTH_ONCE_REPAYMENT(3,"按月付息、到期还本"),
    //    //    PAID_WEEK_ONCE_REPAYMENT(4," 按周付息、到期还本"),
    //    //    ONCE_REPAYMENT(5,"一次还本付息");
    //
    //
    //
    //    if ([model.repaymentType integerValue] == 1) {
    //        payWay = [NSMutableString stringWithFormat:@"按月还款\n等额本息"];
    //    }
    //    else if ([model.repaymentType integerValue] == 2){
    //        payWay = [NSMutableString stringWithFormat:@"按周还款\n等额本息"];
    //    }
    //    else if ([model.repaymentType integerValue] == 3){
    //        payWay = [NSMutableString stringWithFormat:@"按月付息\n到期还本"];
    //    }
    //    else if ([model.repaymentType integerValue] == 4){
    //        payWay = [NSMutableString stringWithFormat:@"按周付息\n到期还本"];
    //    }
    //    else if ([model.repaymentType integerValue] == 5){
    //        payWay = [NSMutableString stringWithFormat:@"一次还本付息"];
    //    }
    //    else if ([model.repaymentType integerValue] == 6){
    //        payWay = [NSMutableString stringWithFormat:@"到期付息\n体验金收回"];
    //    }
    //
    //    self.payWayLabel.frame =CGRectMake(self.titleLabelBg.maxX + KWidth(10), self.titleLabelBg.frame.origin.y, kSCREENW, self.titleLabelBg.frame.size.height);
    //    self.payWayLabel.text=payWay;
    
    
    
    
    _model = model;
    
    
    
    //_lblloanSchedule.text=[NSString stringWithFormat:@"%@%%",model.loanSchedule];
    int ttttt = [model.loanSchedule intValue];
    
    _lblloanSchedule.text=[NSString stringWithFormat:@"%d%%",ttttt];
    if (model.loanSchedule.intValue==100) {//满标
        _lblloanSchedule.textColor=[UIColor grayColor];
        _smallImageView.image = [UIImage imageNamed:@"灰圆"];
        _view_2.backgroundColor = [UIColor lightGrayColor];
        
        
        self.titleLabelBg.image=[UIImage imageNamed:@"1个月标售罄背景"];
        self.imgLine.image=[UIImage imageNamed:@"licai_line_hui"];
        
        //百分比
        
        _lblloanSchedule.frame = CGRectMake(KWidth(20)+model.loanSchedule.intValue*(kSCREENW-2*KWidth(20))*0.01-10, self.titleLabelBg.maxY, 200, 20);
        
        
        
        
        
        _view_2.frame=CGRectMake(KWidth(20), self.rateTextLabel.maxY+KHeight(12), model.loanSchedule.intValue*(kSCREENW-2*KWidth(20))*0.01, 2);
        
        
        
        _smallImageView.frame= CGRectMake(_view_2.maxX, self.rateTextLabel.maxY+KHeight(12)-4, 10, 10);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    } else {
        _lblloanSchedule.textColor=[UIColor grayColor];
        _smallImageView.image = [UIImage imageNamed:@"椭圆-5"];
        _view_2.backgroundColor = [UIColor orangeColor];
        self.titleLabelBg.image=[UIImage imageNamed:@"1个月标背景"];
        
        //百分比
        
        _lblloanSchedule.frame = CGRectMake(KWidth(20)+model.loanSchedule.intValue*(kSCREENW-2*KWidth(20))*0.01-10, self.titleLabelBg.maxY, 200, 20);
        self.imgLine.image=[UIImage imageNamed:@"licai_line"];
        
        
        
        
        _view_2.frame=CGRectMake(KWidth(20), self.rateTextLabel.maxY+KHeight(12), model.loanSchedule.intValue*(kSCREENW-2*KWidth(20))*0.01, 2);
        
        
        
        _smallImageView.frame= CGRectMake(_view_2.maxX, self.rateTextLabel.maxY+KHeight(12)-4, 10, 10);
        
        
        
    }
    
    
    
    self.titleLabel.text = model.title;
    CGFloat W=[Helper widthOfString:model.title font:[UIFont systemFontOfSize:KHeight(12)] height:KHeight(12)];
    self.titleLabel.frame=CGRectMake(15+10, KHeight(10),W, KHeight(12));
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f",[model.apr floatValue]-[model.aprDiscount floatValue]];
    self.titleLabelBg.frame=CGRectMake(KWidth(6), KHeight(10),W+30+20, KHeight(32));
    //self.aprDiscountLabel.text=[NSString stringWithFormat:@"+%.2f%%(贴息)",[model.aprDiscount floatValue]];
    
    
    
    
    NSString *Ratastr=[NSString stringWithFormat:@"%%+%.2f%%(贴息)",[model.aprDiscount floatValue]];
    NSUInteger loca1=(NSUInteger)(Ratastr.length-4);
    NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:Ratastr];
    [str1 addAttribute:NSForegroundColorAttributeName value:TEXTGARY range:NSMakeRange(loca1, 4)];
    //self.aprDiscountLabel.font = [UIFont systemFontOfSize:_font+57];
    self.aprDiscountLabel.attributedText = str1;
    
    
    
    
    
    
    
    
    
    
    
    
    
    NSMutableString *period = [NSMutableString string];
    if ([model.periodUnit integerValue] == 0) {
        period = [NSMutableString stringWithFormat:@"%@个月",model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 2, 2)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 2, 2)];
        self.timeLabel.attributedText = timeAttr;
        
    } else if ([self.model.periodUnit integerValue] == 1) {
        period = [NSMutableString stringWithFormat:@"%@日",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;
        
    } else if ([self.model.periodUnit integerValue] == -1) {
        period = [NSMutableString stringWithFormat:@"%@年",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;
        
    } else if ([self.model.periodUnit integerValue] == 2) {
        period = [NSMutableString stringWithFormat:@"%@周",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;
    }
    
    //    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
    //    [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
    //    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
    //    self.timeLabel.attributedText = timeAttr;
    
    //    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",model.leftAmount]];
    //    [moneyAttr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [moneyAttr length])];
    //    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange(0, [moneyAttr length])];
    self.moneyLabel.text = [NSString stringWithFormat:@"剩余金额:%@元",model.leftAmount];
    
    NSMutableString *payWay = [NSMutableString string];
    
    
    
    //    PAID_MONTH_EQUAL_PRINCIPAL_INTEREST(1," 按月还款、等额本息"),
    //    PAID_WEEK_EQUAL_PRINCIPAL_INTEREST(2,"按周还款、等额本息"),
    //    PAID_MONTH_ONCE_REPAYMENT(3,"按月付息、到期还本"),
    //    PAID_WEEK_ONCE_REPAYMENT(4," 按周付息、到期还本"),
    //    ONCE_REPAYMENT(5,"一次还本付息");
    
    
    
    if ([model.repaymentType integerValue] == 1) {
        payWay = [NSMutableString stringWithFormat:@"按月还款、等额本息"];
    }
    else if ([model.repaymentType integerValue] == 2){
        payWay = [NSMutableString stringWithFormat:@"按周还款、等额本息"];
    }
    else if ([model.repaymentType integerValue] == 3){
        payWay = [NSMutableString stringWithFormat:@"按月付息、到期还本"];
    }
    else if ([model.repaymentType integerValue] == 4){
        payWay = [NSMutableString stringWithFormat:@"按周付息、到期还本"];
    }
    else if ([model.repaymentType integerValue] == 5){
        payWay = [NSMutableString stringWithFormat:@"一次还本付息"];
    }
    else if ([model.repaymentType integerValue] == 6){
        payWay = [NSMutableString stringWithFormat:@"到期付息、体验金收回"];
    }
    
    self.payWayLabel.frame =CGRectMake(self.titleLabelBg.maxX + KWidth(10), self.titleLabelBg.frame.origin.y, kSCREENW, self.titleLabelBg.frame.size.height);
    self.payWayLabel.text=payWay;
    
}

+ (CGFloat)cellHeight
{
    return KHeight(170/2)+KHeight(40)+20+KHeight(20);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
