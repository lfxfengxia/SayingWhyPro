//
//  XYHomePlanTXCellFirstReMen.m
//  LYDApp
//
//  Created by fcl on 2017/4/19.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "XYHomePlanTXCellFirstReMen.h"
@interface XYHomePlanTXCellFirstReMen ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *rateLabel;
@property (nonatomic, strong) UILabel   *rateTextLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UILabel   *timeTextLabel;
@property (nonatomic, strong) UILabel   *moneyLabel;
@property (nonatomic, strong) UILabel   *moneyTextLabel;
@property (nonatomic, strong) UILabel   *payWayLabel;
@property (nonatomic, strong) UILabel   *payWayTextLabel;
@property (nonatomic, strong) UILabel   *aprDiscountLabel;
@property (nonatomic, strong) UIImageView   *titleLabelBg;
@property (nonatomic, strong) UIView   *jiangeView;
@property (nonatomic, strong) UIImageView   *imgLine;
@property (nonatomic, strong) UIButton   *btnqiangou;

@end

@implementation XYHomePlanTXCellFirstReMen

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYHomePlanTXCellFirstReMen";
    XYHomePlanTXCellFirstReMen *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYHomePlanTXCellFirstReMen alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.borderWidth=0;
        
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
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
    
    
    
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(15), self.titleLabelBg.maxY + vMargin, (kSCREENW/2-KWidth(12))/3, KHeight(30))];
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(30)];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    self.rateLabel.textColor = ORANGECOLOR;
  

    [self.contentView addSubview:self.rateLabel];
    
    self.aprDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.maxX, self.rateLabel.frame.origin.y+self.rateLabel.frame.size.height/2, 2*(kSCREENW/2-KWidth(12))/3, self.rateLabel.frame.size.height/2)];
    self.aprDiscountLabel.textColor = TEXTGARY;
    self.aprDiscountLabel.textAlignment = NSTextAlignmentLeft;
    self.aprDiscountLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    self.aprDiscountLabel.adjustsFontSizeToFitWidth = YES;
    self.aprDiscountLabel.text = @"%(贴息)";
    self.aprDiscountLabel.textColor=ORANGECOLOR;
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
    self.btnqiangou.backgroundColor=[UIColor orangeColor];
    [self.btnqiangou setTitle:@"抢购" forState:UIControlStateNormal];
    self.btnqiangou.titleLabel.textColor=[UIColor whiteColor];
    self.btnqiangou.layer.cornerRadius=15;
    [self.btnqiangou addTarget:self action:@selector(QiangGouClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnqiangou];
    
    
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.maxX, self.rateLabel.maxY + KHeight(6), (kSCREENW/2-KWidth(12))/2, textlabelH)];
    self.moneyLabel.textColor = TEXTGARY;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.moneyLabel];

    
    
    UIImageView *lblline2=[[UIImageView alloc] initWithFrame:CGRectMake(self.moneyTextLabel.maxX+10, self.titleLabelBg.maxY + vMargin+20, 1, labelH+textlabelH+vMargin)];
    lblline2.image=[UIImage imageNamed:@"hangline"];
    [self.contentView addSubview:lblline2];
    
    
    

}



//调到份数标购买页
-(void)QiangGouClick:(UIButton *)btn
{

 

 [self.Qianggoudelegate didClickButton:btn];


}




- (void)setModel:(XYPlanModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
    
    CGFloat W=[Helper widthOfString:model.title font:[UIFont systemFontOfSize:KHeight(12)] height:KHeight(12)];
    self.titleLabel.frame=CGRectMake(15+10, KHeight(10),W, KHeight(12));
    
    self.titleLabelBg.frame=CGRectMake(KWidth(6), KHeight(10),W+30+20, KHeight(32));
    
    if ([model.periods integerValue]==3) {
        self.titleLabelBg.image=[UIImage imageNamed:@"3个月标背景"];
    }
    else if ([model.periods integerValue]==6)
    {
        
        self.titleLabelBg.image=[UIImage imageNamed:@"6个月标背景"];
    }
    else if ([model.periods integerValue]==9)
    {
        
        self.titleLabelBg.image=[UIImage imageNamed:@"9个月标背景"];
    }
    else if ([model.periods integerValue]==12)
    {
        
        self.titleLabelBg.image=[UIImage imageNamed:@"12个月标背景"];
    }
    
    
    
    
    
    
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f",[model.apr floatValue]-[model.aprDiscount floatValue]];
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
    

    self.moneyLabel.text=[NSString stringWithFormat:@"%@元/份",model.perAmount];
    
    NSMutableString *payWay = [NSMutableString string];
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
    
    return KHeight(170 / 2)+KHeight(10)+20+20;
    //return KHeight(170 / 2)+KHeight(10);
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
